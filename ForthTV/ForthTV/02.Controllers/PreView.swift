//
//  PreView.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/19/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit
import AVFoundation

@objc (PreView)
class PreView: UIView {

    var _session: AVCaptureSession?
    
    override class func layerClass() -> AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var session: AVCaptureSession! {
        get {
            let previewLayer = self.layer as! AVCaptureVideoPreviewLayer
            return previewLayer.session
        }
        
        set(session) {
            let previewLayer = self.layer as! AVCaptureVideoPreviewLayer
            previewLayer.session = session
        }
    }

}
