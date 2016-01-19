//
//  ChatModel.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/19/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import Foundation

class ConversationModel: NSObject {
    var imageURL: String?
    var chatContent: String?
    
    override init() {
        imageURL = ""
        chatContent = ""
    }
}