//
//  BaseController.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/7/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

public class BaseController: UIViewController {
    
    // MARK: Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override public func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: Method
    
    public func setObject(object:NSObject){}
}
