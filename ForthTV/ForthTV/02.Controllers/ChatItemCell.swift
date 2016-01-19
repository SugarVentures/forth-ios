//
//  ChatItemCell.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/19/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

class ChatItemCell: UITableViewCell {
    
    // UI
    @IBOutlet weak var chatItemContent: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var chatContent: UILabel!
    
    // Properties
    var conversationModel: ConversationModel?
    
    // MARK: Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        createUI()
    }
    
    // MARK: Methods
    func displayData() {
        
        //for avatar
        avatar.image = UIImage(named: (self.conversationModel?.imageURL)!)
        
        // for chat content
        chatContent.text = self.conversationModel?.chatContent
        chatContent.sizeToFit()
        
    }
    
    func createUI() {
        
        // for cell
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = .None
        
        // for chatContent
        chatContent.backgroundColor = UIColor.clearColor()
        chatContent.textColor = THEME_DARK_GRAY
        
        // for avatar
        avatar.layer.cornerRadius = 6.0
        
        //for chatItemContent
        chatItemContent.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
        chatItemContent.layer.cornerRadius = 4.0
        
    }


}
