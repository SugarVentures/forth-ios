//
//  RecordController+AVCam.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/18/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Photos


extension RecordController {
       
    // MARK: Session
    func createSession()
    {
        dispatch_async(self.sessionQueue) {
            switch self.setupResult {
            case .Success:
                // Only setup observers and start the session running if setup succeeded.
                self.addObservers()
                self.session.startRunning()
                self.sessionRunning = self.session.running
            case .CameraNotAuthorized:
                dispatch_async(dispatch_get_main_queue()){
                    let message = NSLocalizedString("AVCam doesn't have permission to use the camera, please change privacy settings", comment: "Alert message when the user has denied access to the camera" )
                    let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                    let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: UIAlertActionStyle.Cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    // Provide quick access to Settings.
                    let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment: "Alert button to open Settings"), style: UIAlertActionStyle.Default) {action in
                        UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!)
                    }
                    alertController.addAction(settingsAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            case .SessionConfigurationFailed:
                dispatch_async(dispatch_get_main_queue()) {
                    let message = NSLocalizedString("Unable to capture media", comment: "Alert message when something goes wrong during capture session configuration")
                    let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                    let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: UIAlertActionStyle.Cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            }
        }

    }
    
    func setupForSesion ()
    {
        // Create the AVCaptureSession.
        self.session = AVCaptureSession()
        
        // Setup the preview view.
        self.previewView.session = self.session
        
        // Communicate with the session and other session objects on this queue.
        self.sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL)
        
        self.setupResult = AVCamSetupResult.Success
        
        // Check video authorization status. Video access is required and audio access is optional.
        // If audio access is denied, audio is not recorded during movie recording.
        switch AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) {
        case .Authorized:
            // The user has previously granted access to the camera.
            break
        case .NotDetermined:
            // The user has not yet been presented with the option to grant video access.
            // We suspend the session queue to delay session setup until the access request has completed to avoid
            // asking the user for audio access if video access is denied.
            // Note that audio access will be implicitly requested when we create an AVCaptureDeviceInput for audio during session setup.
            dispatch_suspend(self.sessionQueue)
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo) {granted in
                if !granted {
                    self.setupResult = AVCamSetupResult.CameraNotAuthorized
                }
                dispatch_resume(self.sessionQueue)
            }
        default:
            // The user has previously denied access.
            self.setupResult = AVCamSetupResult.CameraNotAuthorized
        }
        
        // Setup the capture session.
        // In general it is not safe to mutate an AVCaptureSession or any of its inputs, outputs, or connections from multiple threads at the same time.
        // Why not do all of this on the main queue?
        // Because -[AVCaptureSession startRunning] is a blocking call which can take a long time. We dispatch session setup to the sessionQueue
        // so that the main queue isn't blocked, which keeps the UI responsive.
        dispatch_async(self.sessionQueue) {
            guard self.setupResult == AVCamSetupResult.Success else {
                return
            }
            
            self.backgroundRecordingID = UIBackgroundTaskInvalid
            
            let videoDevice = RecordController.deviceWithMediaType(AVMediaTypeVideo, preferringPosition: AVCaptureDevicePosition.Back)
            let videoDeviceInput: AVCaptureDeviceInput!
            do {
                videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
                
            } catch let error as NSError {
                videoDeviceInput = nil
                NSLog("Could not create video device input: %@", error)
            } catch _ {
                fatalError()
            }
            
            self.session.beginConfiguration()
            
            if self.session.canAddInput(videoDeviceInput) {
                self.session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
                
                dispatch_async(dispatch_get_main_queue()) {
                    // Why are we dispatching this to the main queue?
                    // Because AVCaptureVideoPreviewLayer is the backing layer for AAPLPreviewView and UIView
                    // can only be manipulated on the main thread.
                    // Note: As an exception to the above rule, it is not necessary to serialize video orientation changes
                    // on the AVCaptureVideoPreviewLayer’s connection with other session manipulation.
                    
                    // Use the status bar orientation as the initial video orientation. Subsequent orientation changes are handled by
                    // -[viewWillTransitionToSize:withTransitionCoordinator:].
                    let statusBarOrientation = UIApplication.sharedApplication().statusBarOrientation
                    var initialVideoOrientation = AVCaptureVideoOrientation.Portrait
                    if statusBarOrientation != UIInterfaceOrientation.Unknown {
                        initialVideoOrientation = AVCaptureVideoOrientation(rawValue: statusBarOrientation.rawValue)!
                    }
                    
                    let previewLayer = self.previewView.layer as! AVCaptureVideoPreviewLayer
                    previewLayer.connection.videoOrientation = initialVideoOrientation
                }
            } else {
                NSLog("Could not add video device input to the session")
                self.setupResult = AVCamSetupResult.SessionConfigurationFailed
            }
            
            let audioDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
            let audioDeviceInput: AVCaptureDeviceInput!
            do {
                audioDeviceInput = try AVCaptureDeviceInput(device: audioDevice)
                
            } catch let error as NSError {
                audioDeviceInput = nil
                NSLog("Could not create audio device input: %@", error)
            } catch _ {
                fatalError()
            }
            
            if self.session.canAddInput(audioDeviceInput) {
                self.session.addInput(audioDeviceInput)
            } else {
                NSLog("Could not add audio device input to the session")
            }
            
            let movieFileOutput = AVCaptureMovieFileOutput()
            if self.session.canAddOutput(movieFileOutput) {
                self.session.addOutput(movieFileOutput)
                let connection = movieFileOutput.connectionWithMediaType(AVMediaTypeVideo)
                if connection?.supportsVideoStabilization ?? false {
                    connection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationMode.Auto
                }
                self.movieFileOutput = movieFileOutput
            } else {
                NSLog("Could not add movie file output to the session")
                self.setupResult = AVCamSetupResult.SessionConfigurationFailed
            }
            
            
            self.session.commitConfiguration()
        }
    }
    
    func removeSession()
    {
        dispatch_async(self.sessionQueue) {
            if self.setupResult == AVCamSetupResult.Success {
                self.session.stopRunning()
                self.removeObservers()
            }
        }
    }
    
    //MARK: Main Methods
    func record()
    {
        dispatch_async(self.sessionQueue) {
            if !self.movieFileOutput.recording {
                if UIDevice.currentDevice().multitaskingSupported {
                    // Setup background task. This is needed because the -[captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error:]
                    // callback is not received until AVCam returns to the foreground unless you request background execution time.
                    // This also ensures that there will be time to write the file to the photo library when AVCam is backgrounded.
                    // To conclude this background execution, -endBackgroundTask is called in
                    // -[captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error:] after the recorded file has been saved.
                    self.backgroundRecordingID = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler(nil)
                }
                
                // Update the orientation on the movie file output video connection before starting recording.
                let connection = self.movieFileOutput.connectionWithMediaType(AVMediaTypeVideo)
                let previewLayer = self.previewView.layer as! AVCaptureVideoPreviewLayer
                connection.videoOrientation = previewLayer.connection.videoOrientation
                
                // Turn OFF flash for video recording.
                RecordController.setFlashMode(AVCaptureFlashMode.Off, forDevice: self.videoDeviceInput.device)
                
                // Start recording to a temporary file.
                let outputFileName = NSProcessInfo.processInfo().globallyUniqueString as NSString
                let outputFilePath = (NSTemporaryDirectory() as NSString).stringByAppendingPathComponent(outputFileName.stringByAppendingPathExtension("mov")!)
                self.movieFileOutput.startRecordingToOutputFileURL(NSURL(fileURLWithPath: outputFilePath), recordingDelegate: self)
            } else {
                self.movieFileOutput.stopRecording()
            }
        }

    }
    
    func changeCamera()
    {
        dispatch_async(self.sessionQueue) {
            let currentVideoDevice = self.videoDeviceInput.device
            var preferredPosition = AVCaptureDevicePosition.Unspecified
            let currentPosition = currentVideoDevice.position
            
            switch currentPosition {
            case AVCaptureDevicePosition.Unspecified, AVCaptureDevicePosition.Front:
                preferredPosition = AVCaptureDevicePosition.Back
            case AVCaptureDevicePosition.Back:
                preferredPosition = AVCaptureDevicePosition.Front
            }
            
            let videoDevice = RecordController.deviceWithMediaType(AVMediaTypeVideo,  preferringPosition: preferredPosition)
            let videoDeviceInput: AVCaptureDeviceInput!
            do {
                videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            } catch _ {
                videoDeviceInput = nil
            }
            
            self.session.beginConfiguration()
            
            // Remove the existing device input first, since using the front and back camera simultaneously is not supported.
            self.session.removeInput(self.videoDeviceInput)
            
            if self.session.canAddInput(videoDeviceInput) {
                NSNotificationCenter.defaultCenter().removeObserver(self, name: AVCaptureDeviceSubjectAreaDidChangeNotification, object: currentVideoDevice)
                
                RecordController.setFlashMode(AVCaptureFlashMode.Auto, forDevice: videoDevice!)
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "subjectAreaDidChange:",  name: AVCaptureDeviceSubjectAreaDidChangeNotification, object: videoDevice)
                
                self.session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
            } else {
                self.session.addInput(self.videoDeviceInput)
            }
            
            let connection = self.movieFileOutput.connectionWithMediaType(AVMediaTypeVideo)
            if connection.supportsVideoStabilization {
                connection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationMode.Auto
            }
            
            self.session.commitConfiguration()
            
            dispatch_async(dispatch_get_main_queue()) {
                self.cameraButton.enabled = true
                self.recordButton.enabled = true
            }
        }

    }
    
    
    //MARK: KVO and Notifications
    func addObservers() {
        self.session.addObserver(self, forKeyPath: "running", options: NSKeyValueObservingOptions.New, context: SessionRunningContext)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "subjectAreaDidChange:", name: AVCaptureDeviceSubjectAreaDidChangeNotification, object: self.videoDeviceInput.device)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "sessionRuntimeError:", name: AVCaptureSessionRuntimeErrorNotification, object: self.session)
        // A session can only run when the app is full screen. It will be interrupted in a multi-app layout, introduced in iOS 9,
        // see also the documentation of AVCaptureSessionInterruptionReason. Add observers to handle these session interruptions
        // and show a preview is paused message. See the documentation of AVCaptureSessionWasInterruptedNotification for other
        // interruption reasons.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "sessionWasInterrupted:", name: AVCaptureSessionWasInterruptedNotification, object: self.session)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "sessionInterruptionEnded:", name: AVCaptureSessionInterruptionEndedNotification, object: self.session)
    }
    
    func removeObservers() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        self.session.removeObserver(self, forKeyPath: "running", context: SessionRunningContext)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        switch context {
            
        case SessionRunningContext:
            let isSessionRunning = change![NSKeyValueChangeNewKey]! as! Bool
            
            dispatch_async(dispatch_get_main_queue()) {
                // Only enable the ability to change camera if the device has more than one camera.
                self.cameraButton.enabled = isSessionRunning && (AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo).count > 1)
                self.recordButton.enabled = isSessionRunning
            }
        default:
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    func subjectAreaDidChange(notification: NSNotification) {
        let devicePoint = CGPointMake(0.5, 0.5)
        self.focusWithMode(AVCaptureFocusMode.ContinuousAutoFocus, exposeWithMode: AVCaptureExposureMode.ContinuousAutoExposure, atDevicePoint: devicePoint, monitorSubjectAreaChange: false)
    }
    
    func sessionRuntimeError(notification: NSNotification) {
        let error = notification.userInfo![AVCaptureSessionErrorKey]! as! NSError
        NSLog("Capture session runtime error: %@", error)
        
        // Automatically try to restart the session running if media services were reset and the last start running succeeded.
        // Otherwise, enable the user to try to resume the session running.
        if error.code == AVError.MediaServicesWereReset.rawValue {
            dispatch_async(self.sessionQueue) {
                if self.sessionRunning {
                    self.session.startRunning()
                    self.sessionRunning = self.session.running
                } else {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.resumeButton.hidden = false
                    }
                }
            }
        } else {
            self.resumeButton.hidden = false
        }
    }
    
    func sessionWasInterrupted(notification: NSNotification) {
        // In some scenarios we want to enable the user to resume the session running.
        // For example, if music playback is initiated via control center while using AVCam,
        // then the user can let AVCam resume the session running, which will stop music playback.
        // Note that stopping music playback in control center will not automatically resume the session running.
        // Also note that it is not always possible to resume, see -[resumeInterruptedSession:].
        var showResumeButton = false
        
        // In iOS 9 and later, the userInfo dictionary contains information on why the session was interrupted.
        if #available(iOS 9.0, *) {
            let reason = notification.userInfo![AVCaptureSessionInterruptionReasonKey]! as! Int
            NSLog("Capture session was interrupted with reason %ld", reason)
            
            if reason == AVCaptureSessionInterruptionReason.AudioDeviceInUseByAnotherClient.rawValue ||
                reason == AVCaptureSessionInterruptionReason.VideoDeviceInUseByAnotherClient.rawValue {
                    showResumeButton = true
            } else if reason == AVCaptureSessionInterruptionReason.VideoDeviceNotAvailableWithMultipleForegroundApps.rawValue {
                // Simply fade-in a label to inform the user that the camera is unavailable.
                self.cameraUnavailableLabel.hidden = false
                self.cameraUnavailableLabel.alpha = 0.0
                UIView.animateWithDuration(0.25) {
                    self.cameraUnavailableLabel.alpha = 1.0
                }
            }
        } else {
            NSLog("Capture session was interrupted")
            showResumeButton = (UIApplication.sharedApplication().applicationState == UIApplicationState.Inactive)
        }
        
        if showResumeButton {
            // Simply fade-in a button to enable the user to try to resume the session running.
            self.resumeButton.hidden = false
            self.resumeButton.alpha = 0.0
            UIView.animateWithDuration(0.25) {
                self.resumeButton.alpha = 1.0
            }
        }
    }
    
    func sessionInterruptionEnded(notification: NSNotification) {
        NSLog("Capture session interruption ended")
        
        if !self.resumeButton.hidden {
            UIView.animateWithDuration(0.25, animations: {
                self.resumeButton.alpha = 0.0
                }, completion: {finished in
                    self.resumeButton.hidden = true
            })
        }
        if !self.cameraUnavailableLabel.hidden {
            UIView.animateWithDuration(0.25, animations: {
                self.cameraUnavailableLabel.alpha = 0.0
                }, completion: {finished in
                    self.cameraUnavailableLabel.hidden = true
            })
        }
    }
    
    //MARK: File Output Recording Delegate
    func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {
        // Enable the Record button to let the user stop the recording.
        dispatch_async( dispatch_get_main_queue()) {
            self.recordButton.enabled = true
        }
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        // Note that currentBackgroundRecordingID is used to end the background task associated with this recording.
        // This allows a new recording to be started, associated with a new UIBackgroundTaskIdentifier, once the movie file output's isRecording property
        // is back to NO — which happens sometime after this method returns.
        // Note: Since we use a unique file path for each recording, a new recording will not overwrite a recording currently being saved.
        let currentBackgroundRecordingID = self.backgroundRecordingID
        self.backgroundRecordingID = UIBackgroundTaskInvalid
        
        let cleanup: dispatch_block_t = {
            do {
                try NSFileManager.defaultManager().removeItemAtURL(outputFileURL)
            } catch _ {}
            if currentBackgroundRecordingID != UIBackgroundTaskInvalid {
                UIApplication.sharedApplication().endBackgroundTask(currentBackgroundRecordingID)
            }
        }
        
        var success = true
        
        if error != nil {
            NSLog("Movie file finishing error: %@", error!)
            success = error!.userInfo[AVErrorRecordingSuccessfullyFinishedKey] as! Bool? ?? false
        }
        if success {
            // Check authorization status.
            PHPhotoLibrary.requestAuthorization {status in
                guard status == PHAuthorizationStatus.Authorized else {
                    cleanup()
                    return
                }
                // Save the movie file to the photo library and cleanup.
                PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                    // In iOS 9 and later, it's possible to move the file into the photo library without duplicating the file data.
                    // This avoids using double the disk space during save, which can make a difference on devices with limited free disk space.
                    if #available(iOS 9.0, *) {
                        let options = PHAssetResourceCreationOptions()
                        options.shouldMoveFile = true
                        let changeRequest = PHAssetCreationRequest.creationRequestForAsset()
                        changeRequest.addResourceWithType(PHAssetResourceType.Video, fileURL: outputFileURL, options: options)
                    } else {
                        PHAssetChangeRequest.creationRequestForAssetFromVideoAtFileURL(outputFileURL)
                    }
                    }, completionHandler: {success, error in
                        if !success {
                            NSLog("Could not save movie to photo library: %@", error!)
                        }
                        cleanup()
                })
            }
        } else {
            cleanup()
        }
        
        // Enable the Camera and Record buttons to let the user switch camera and start another recording.
        dispatch_async( dispatch_get_main_queue()) {
            // Only enable the ability to change camera if the device has more than one camera.
            self.cameraButton.enabled = (AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo).count > 1)
            self.recordButton.enabled = true
        }
    }
    
    //MARK: Device Configuration
    func focusWithMode(focusMode: AVCaptureFocusMode, exposeWithMode exposureMode: AVCaptureExposureMode, atDevicePoint point:CGPoint, monitorSubjectAreaChange: Bool) {
        dispatch_async(self.sessionQueue) {
            let device = self.videoDeviceInput.device
            do {
                try device.lockForConfiguration()
                defer {device.unlockForConfiguration()}
                // Setting (focus/exposure)PointOfInterest alone does not initiate a (focus/exposure) operation.
                // Call -set(Focus/Exposure)Mode: to apply the new point of interest.
                if device.focusPointOfInterestSupported && device.isFocusModeSupported(focusMode) {
                    device.focusPointOfInterest = point
                    device.focusMode = focusMode
                }
                
                if device.exposurePointOfInterestSupported && device.isExposureModeSupported(exposureMode) {
                    device.exposurePointOfInterest = point
                    device.exposureMode = exposureMode
                }
                
                device.subjectAreaChangeMonitoringEnabled = monitorSubjectAreaChange
            } catch let error as NSError {
                NSLog("Could not lock device for configuration: %@", error)
            } catch _ {}
        }
    }
    
    class func setFlashMode(flashMode: AVCaptureFlashMode, forDevice device: AVCaptureDevice) {
        if device.hasFlash && device.isFlashModeSupported(flashMode) {
            do {
                try device.lockForConfiguration()
                defer {device.unlockForConfiguration()}
                device.flashMode = flashMode
            } catch let error as NSError {
                NSLog("Could not lock device for configuration: %@", error)
            }
        }
    }
    
    class func deviceWithMediaType(mediaType: String, preferringPosition position: AVCaptureDevicePosition) -> AVCaptureDevice? {
        let devices = AVCaptureDevice.devicesWithMediaType(mediaType)
        var captureDevice = devices.first as! AVCaptureDevice?
        
        for device in devices as! [AVCaptureDevice] {
            if device.position == position {
                captureDevice = device
                break
            }
        }
        
        return captureDevice
    }
    
    
    
}