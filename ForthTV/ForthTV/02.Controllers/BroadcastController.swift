//
//  BroadcastController.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/6/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

class BroadcastController: BaseController {
    
    // MARK: Properties
    @IBOutlet weak var videoTitle: UITextField!
    @IBOutlet weak var privateStream: UILabel!
    @IBOutlet weak var matureContent: UILabel!
    @IBOutlet weak var privateStreamSwitch: UISwitch!
    @IBOutlet weak var matureContentSwitch: UISwitch!
    @IBOutlet weak var btnBroadcast: UIButton!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // configure for beginning
        self.configureForBeginning()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func privateSwitchChanged(sender: AnyObject) {
        
    }
    
    @IBAction func matureContentChanged(sender: AnyObject) {
        
    }
    
    @IBAction func broacastTapped(sender: AnyObject) {
        
    }
    
    // MARK: Methods
    
    func configureForBeginning(){
        
        // for Title
        self.title = navigationTitleText
        
        // for videoTitle
        videoTitle.textColor = THEME_DARK_GRAY
        videoTitle.placeholder = videoTitleText
        
        // for privateStream
        privateStream.textColor = THEME_LIGHT_GRAY
        privateStream.text = streamInPrivateText
        
        // for matureContent
        matureContent.textColor = THEME_LIGHT_GRAY
        matureContent.text = matureContentText
        
        // for privateStreamSwitch
        privateStreamSwitch.onTintColor = THEME_YELLOW_COLOR
        
        // for privateStreamSwitch
        matureContentSwitch.onTintColor = THEME_YELLOW_COLOR
        
        // for btnBroadcast
        btnBroadcast.titleLabel?.text = broacastNowText
        btnBroadcast.backgroundColor = THEME_RED_COLOR
        btnBroadcast.titleLabel?.textColor = UIColor.whiteColor()
        btnBroadcast.layer.cornerRadius = 2.0
    }
    
    
    
}
