//
//  RecordController.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/6/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit
import AVFoundation
import Photos



public var SessionRunningContext = UnsafeMutablePointer<Void>.alloc(1)

public  enum AVCamSetupResult: Int {
    case Success
    case CameraNotAuthorized
    case SessionConfigurationFailed
}



class RecordController: BaseController,
                        AVCaptureFileOutputRecordingDelegate,
                        UITableViewDelegate,
                        UITableViewDataSource
{

    // MARK: UI
    // Top
    @IBOutlet weak var liveIcon: UIImageView!
    @IBOutlet weak var recordingTime: UILabel!
    
    // Preview
    @IBOutlet weak var previewView: PreView!
    
    // Chat Table
    @IBOutlet weak var chatTable: UITableView!
    
    // Bottom
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!
    
    //TODO: will remove and change the logic
    @IBOutlet weak var cameraUnavailableLabel: UILabel!
    @IBOutlet weak var resumeButton: UIButton!
 
    
    // Session management.
    var sessionQueue: dispatch_queue_t!
    var session: AVCaptureSession!
    var videoDeviceInput: AVCaptureDeviceInput!
    var movieFileOutput: AVCaptureMovieFileOutput!
    
    // Utilities.
    var setupResult: AVCamSetupResult = .Success
    var sessionRunning: Bool = false
    var backgroundRecordingID: UIBackgroundTaskIdentifier = 0
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable UI. The UI is enabled if and only if the session starts running.
        self.cameraButton.enabled = false
        self.recordButton.enabled = false
        
        // configure for beginning
        configureForBeginning()
        
        // set up session
        setupForSesion()
        
       
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
         //create session
         createSession()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        // remove session
        removeSession()
        
        super.viewDidDisappear(animated)
    }
    
    //MARK: Orientation
    override func shouldAutorotate() -> Bool {
        // Disable autorotation of the interface when recording is in progress.
        return !(self.movieFileOutput?.recording ?? false)
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.All
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        // Note that the app delegate controls the device orientation notifications required to use the device orientation.
        let deviceOrientation = UIDevice.currentDevice().orientation
        if UIDeviceOrientationIsPortrait(deviceOrientation) || UIDeviceOrientationIsLandscape(deviceOrientation) {
            let previewLayer = self.previewView.layer as! AVCaptureVideoPreviewLayer
            previewLayer.connection.videoOrientation = AVCaptureVideoOrientation(rawValue: deviceOrientation.rawValue)!
        }
    }

    //MARK: Actions
    @IBAction func toggleMovieRecording(_: AnyObject) {
        // Disable the Camera button until recording finishes, and disable the Record button until recording starts or finishes. See the
        // AVCaptureFileOutputRecordingDelegate methods.
        self.cameraButton.enabled = false
        self.recordButton.enabled = false
        
        // call record
        record()
        
    }
    
    @IBAction func changeCamera(_: AnyObject) {
        self.cameraButton.enabled = false
        self.recordButton.enabled = false
        
        // change camera
        changeCamera ()
        
    }
    
    @IBAction func chatTapped(sender: AnyObject) {
        
    }
    
    @IBAction func cancelController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Methods
    func configureForBeginning() {
        // for chatTable
        chatTable.backgroundColor = UIColor.clearColor()
        chatTable.separatorStyle = .None
        
        // for recordingTime
        recordingTime.textColor = UIColor.whiteColor()
        
        // for likeLabel
        likeLabel.textColor = UIColor.whiteColor()
        viewLabel.textColor = UIColor.whiteColor()
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return RECORDING_PAGE_CHATTABLE_ROWS
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellID = "ChatItemCell"
        var cell : ChatItemCell? = tableView .dequeueReusableCellWithIdentifier(cellID) as? ChatItemCell
        
        if cell == nil {
             //TODO: Will remove
            let conversation: ConversationModel = ConversationModel()
            conversation.imageURL = "avatar_small"
            conversation.chatContent = "Hello world Hello world Hello world Hello world"
            
            // create conversation
            cell  = UIView.fromNib()
            cell!.conversationModel = conversation
            
            cell!.displayData()
        }
        
        return cell!
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //TODO: Will remove
        return 100.0
    }
}
