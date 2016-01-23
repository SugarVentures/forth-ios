//
//  VideoDetailController.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/6/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

class VideoDetailController: BaseController {
    
    //MARK: Properties
    
    @IBOutlet weak var videoView: UIView!
   
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var gameChannel: UILabel!
    
    
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var emotionButton: UIButton!
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    @IBAction func likeTapped(sender: AnyObject) {
    }
    
    @IBAction func sendMessageTapped(sender: AnyObject) {
    }
    
    @IBAction func emotionTapped(sender: AnyObject) {
    }
    
    
}
