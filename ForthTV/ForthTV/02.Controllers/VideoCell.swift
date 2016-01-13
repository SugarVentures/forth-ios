//
//  VideoCell.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/13/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

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
    
    
    // MARK: Methods
    func setLoadingStatus (dataStatus:VIDEO_DATA_STATUS) {
        
        if dataStatus == .LOADING
        {
            self.createDefaultUI()
        }
        else
        {
            self.createloadedCaseUI()
        }
        
    }
    
    private func createDefaultUI() {
        
        // show onlythumbmail image && hide all
        self.getDefaultData()
        
        
    }
    
    private func createloadedCaseUI() {
        
        // show onlythumbmail image && hide all
    }
    private func displayData(videoModel:VideoModel, videoStatus:VIDEO_DATA_STATUS) {
        
        videoThumbnail.image = UIImage(named: <#T##String#>)
        
//        @IBOutlet weak var mainView: UIView!
//        @IBOutlet weak var videoThumbnail: UIImageView!
//        @IBOutlet weak var liveIcon: UIImageView!
//        
//        @IBOutlet weak var bottomView: UIView!
//        @IBOutlet weak var channelTitle: UILabel!
//        @IBOutlet weak var channelOwner: UILabel!
//        @IBOutlet weak var gameTitle: UILabel!
//        @IBOutlet weak var countOfViews: UILabel!
//        @IBOutlet weak var countOfLikes: UILabel!
        
        
    }
    
    private func getDefaultData() {
        
        let videoModel: VideoModel = VideoModel ();
        videoModel.videoThumbnail = "loading_video"
        videoModel.isLiveStreaming = false
        
        self.videoModel = videoModel
    }
    
    


}
