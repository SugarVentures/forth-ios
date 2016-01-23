//
//  VideoDetailController.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/6/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

class VideoDetailController: BaseController,
                             UITableViewDelegate,
                             UITableViewDataSource{
    
    //MARK: Properties
    
    @IBOutlet weak var videoView: UIView!
   
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var gameChannel: UILabel!
    
    
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var chatControl: UIView!
    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var emotionButton: UIButton!
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure for Beginning
        configureForBeginning()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
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
    
    //MARK: Methods
    func configureForBeginning() {
        
        // for videoView
        videoView.backgroundColor = UIColor.clearColor()
        
        // for titleView
        titleView.backgroundColor = UIColor.clearColor()
        
        // for gameChannel
        gameChannel.textColor = THEME_DARK_GRAY
        
        // for centerView
        centerView.backgroundColor = THEME_YELLOW_COLOR
        
        // for viewLabel
        viewLabel.textColor = UIColor.whiteColor()
        
        // for likeLabel
        likeLabel.textColor = UIColor.whiteColor()
        
        // for likeButton
        likeButton.layer.cornerRadius = 4.0
        likeButton.backgroundColor = UIColor.whiteColor()
        likeButton.setTitleColor(THEME_YELLOW_COLOR, forState: .Normal)
        
        // for chatView
        chatView.backgroundColor = UIColor.clearColor()
        
        // for chatControl
        chatControl.backgroundColor = UIColor.clearColor()
        chatControl.layer.cornerRadius = 4
        chatControl.layer.borderWidth = 1.0
        chatControl.layer.borderColor = THEME_LIGHT_GRAY.CGColor
        
        // for chatTable
        chatTable.backgroundColor = UIColor.clearColor()
        
        // for messageTextfield
        messageTextfield.textColor = THEME_LIGHT_GRAY
        
    }
    
    //MARK: Actions
    @IBAction func likeTapped(sender: AnyObject) {
    }
    
    @IBAction func sendMessageTapped(sender: AnyObject) {
    }
    
    @IBAction func emotionTapped(sender: AnyObject) {
    }
    
    
    
    
}
