//
//  VideoCell.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/13/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit
import QuartzCore

enum VIDEO_DATA_STATUS {
    case LOADING
    case LOADED
}

class VideoCell: UITableViewCell {

  
    // MARK: UI
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var videoThumbnail: UIImageView!
    @IBOutlet weak var liveIcon: UIImageView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var channelOwner: UILabel!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var countOfViews: UILabel!
    @IBOutlet weak var countOfLikes: UILabel!
    
    // MARK: Properties
    var videoModel: VideoModel?
    
    //MARK: Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // create default UI
        self.createDefaultUI()
    }
    
    
    // MARK: Methods
    func displayData(videoStatus:VIDEO_DATA_STATUS) {
        
        liveIcon.hidden = self.videoModel!.isLiveStreaming!
        
        if videoStatus == .LOADING
        {
            videoThumbnail.image = UIImage(named: "loadingvideo")
            bottomView.hidden = false
            
        }
        else
        {
            
            bottomView.hidden = false
            
            // set data from model
            channelTitle.text = self.videoModel!.channelTitle
            channelOwner.text = self.videoModel!.channelOwner
            gameTitle.text = self.videoModel!.gameTitle
            countOfViews.text = self.videoModel!.numberOfViews
            countOfLikes.text = self.videoModel!.numberOfLikes
            
            // thumbnail will loading from service

        }
        
    }
    
    private func createDefaultUI() {
        
        mainView.layer.cornerRadius = 6.0
        mainView.layer.masksToBounds = true
        
        videoThumbnail.layer.cornerRadius = 6.0
        videoThumbnail.layer.masksToBounds = true
        
    }
    
}
