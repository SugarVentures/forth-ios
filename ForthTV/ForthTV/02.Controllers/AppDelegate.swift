//
//  AppDelegate.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/4/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    var videoListController: VideoListController!
    var menuController: MenuController!
    var slideController: SlideContainerController!
    var broadcastController:BroadcastController!

    // MARK: App default method
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.createMenuView();
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: Internal Methods
    private func createMenuView() {
        
        // center
        videoListController = Master.sharedInstance.getController(PageType.VIDEO_LIST) as! VideoListController;
        
        // left
        menuController = Master.sharedInstance.getController(PageType.MENU) as! MenuController
        
        // right
        broadcastController = Master.sharedInstance.getController(PageType.BROADCAST) as! BroadcastController

        // main
        navigationController = UINavigationController(rootViewController: videoListController)
        navigationController?.navigationBar.barTintColor = THEME_BLUE_COLOR
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        menuController.mainViewController = navigationController
        
        // slider menu
        slideController =  SlideContainerController(mainViewController: navigationController!, leftMenuViewController: menuController, rightMenuViewController: broadcastController)
        slideController.automaticallyAdjustsScrollViewInsets = true
        
        // window
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideController
        self.window?.makeKeyAndVisible()
    }


}

