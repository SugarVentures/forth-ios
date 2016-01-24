//
//  MasterController.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/6/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

enum PageType{
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

class Master: NSObject {
    
    //MARK: Properties
    static let sharedInstance: Master = {
        let instance = Master()
        // setup code
        return instance
    }()

    //MARK: Master's Methods
    
    func presentController(currentController:UIViewController, pageType:PageType, animated:Bool, object:Any?)
    {
        let controller = self.getController(pageType)
        controller.setObject(object)
        currentController.presentViewController(controller, animated: animated, completion: nil)
    }
    
    func pushController(currentController:UIViewController, pageType:PageType, animated:Bool, object:Any?)
    {
        let controller = self.getController(pageType)
        controller.setObject(object)
        currentController.navigationController?.pushViewController(controller, animated: animated)
    }
    
    func pushController(pageType:PageType, animated:Bool, object:Any?)
    {
        let controller = self.getController(pageType)
        controller.setObject(object)
        kAppDelegate.slideController.closeLeft()
        kAppDelegate.navigationController?.pushViewController(controller, animated: animated)
    }
    func openMenu ()
    {
        kAppDelegate.slideController.openLeft()
    }
    
    func getController(pageType:PageType)-> BaseController
    {
        var storyboardName:String;
        
        switch (pageType){

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
        
        let storyboard: UIStoryboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
        return  storyboard.instantiateViewControllerWithIdentifier(storyboardName) as! BaseController
        
    }
    
    //MARK: Animation Methods
    func flip(fromView:UIView, toView: UIView) {
        let transitionOptions: UIViewAnimationOptions = [.TransitionFlipFromRight, .ShowHideTransitionViews]
        
        UIView.transitionWithView(fromView, duration: 0.75, options: transitionOptions, animations: {
            fromView.hidden = true
            }, completion: nil)
        
        UIView.transitionWithView(toView, duration: 0.75, options: transitionOptions, animations: {
            toView.hidden = false
            }, completion: nil)
    }

}
