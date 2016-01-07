//
//  MasterController.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/6/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

enum PageType{
    case WELCOME
    case MASTER
    case MENU
    case VIDEO_LIST
    case SLIDE_CONTAINER
    case ACCOUNT
    case LOGIN
    case REGISTER
    case VIDEO_DETAIL
    case CHATTING
    case BROADCAST
    case RECORD
    case USER_PROFLE
    case VISITTER_PROFILE
}

class MasterController: BaseController {
      

    //MARK: Life Cycle Methods
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Master's Methods
    
    func presentController(currentController:UIViewController, pageType:PageType, animated:Bool, object:NSObject)
    {
        let controller = self.getController(pageType)
        controller.setObject(object)
        currentController.presentViewController(controller, animated: animated, completion: nil)
    }
    
    func pushController(currentController:UIViewController, pageType:PageType, animated:Bool, object:NSObject)
    {
        let controller = self.getController(pageType)
        controller.setObject(object)
        currentController.navigationController?.pushViewController(controller, animated: animated)
    }
    
    func getController(pageType:PageType)-> BaseController
    {
        var storyboardName:String;
        
        switch (pageType){
        case .WELCOME:
            storyboardName = WELCOME_PAGE_STORYBOARD
            break
        case .MASTER:
             storyboardName = MASTER_PAGE_STORYBOARD
            break
        case .MENU:
            storyboardName = MENU_PAGE_STORYBOARD
            break
        case .VIDEO_LIST:
            storyboardName = VIDEO_LIST_STORYBOARD
            break
        case .SLIDE_CONTAINER:
            storyboardName = SLIDE_CONTAINER_STORYBOARD
            break
        case .ACCOUNT:
            storyboardName = ACCOUNT_STORYBOARD
            break
        case .LOGIN:
            storyboardName = LOGIN_STORYBOARD
            break
        case .REGISTER:
            storyboardName = REGISTER_STORYBOARD
            break
        case .VIDEO_DETAIL:
            storyboardName = VIDEO_DETAIL_STORYBOARD
            break
        case .CHATTING:
            storyboardName = CHATTING_STORYBOARD
            break
        case .BROADCAST:
            storyboardName = BROACAST_STORYBOARD
            break
        case .RECORD:
            storyboardName = RECORD_STORYBOARD
            break
        case .USER_PROFLE:
            storyboardName = USER_PROFILE_STORYBOARD
            break
        case .VISITTER_PROFILE:
            storyboardName = VISITTER_PROFILE_STORYBOARD
            break
            
        }
        
        return  self.storyboard!.instantiateViewControllerWithIdentifier(storyboardName) as! BaseController
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
