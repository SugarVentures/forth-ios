//
//  MenuHeader.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/12/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

enum HEADER_BUTTON_TYPE{
    case LOGIN
    case REGISTER
}

protocol MenuHeaderDelegate {
    
    func buttonTapped(buttonType: HEADER_BUTTON_TYPE)
}

class MenuHeader: UITableViewHeaderFooterView {
    
    // MARK:Properties
    var delegate: MenuHeaderDelegate?
   
    
    // MARK:Actions
    @IBAction func loginTapped(sender: AnyObject) {
        
    self.delegate!.buttonTapped(HEADER_BUTTON_TYPE.LOGIN)
        
    }
    
    @IBAction func registerTapped(sender: AnyObject) {
         self.delegate!.buttonTapped(HEADER_BUTTON_TYPE.REGISTER)
    }
}
