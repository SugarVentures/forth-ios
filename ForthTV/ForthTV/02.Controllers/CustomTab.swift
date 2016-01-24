//
//  CustomTab.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/24/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

class CustomTab: UIButton {

    
    // MARK: Methods
    func setTabSelected(selected:Bool) {
        
        if selected
        {
            setBackgroundImage(UIImage(named: "icon_selectedTab"), forState: .Normal)
        }
        else
        {
            
            setBackgroundImage(UIImage(named: "icon_unselectedTab"), forState: .Normal)
        }
        
        
    }
    
}
