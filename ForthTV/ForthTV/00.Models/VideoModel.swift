//
//  VideoModel.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/13/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import Foundation

class VideoModel: NSObject {
    
    // MARK: Properties
    var videoThumbnail: String?
    var isLiveStreaming: Bool?
    var channelTitle: String?
    var channelOwner:String?
    var gameTitle: String?
    var numberOfViews: String?
    var numberOfLikes: String?
    
    override init() {
        videoThumbnail =  ""
        isLiveStreaming = false
        channelTitle = ""
        channelOwner = ""
        gameTitle = ""
        numberOfViews = ""
        numberOfLikes = ""
    }

    
}