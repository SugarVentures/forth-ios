//
//  LoginController.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/6/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

enum LOGINVIEW_BUTTON_TYPE {
    case LOGIN_BUTTON
    case FORGOT_BUTTON
}

protocol LoginViewDelegate {
    
    func loginViewButtonTapped(buttonType: LOGINVIEW_BUTTON_TYPE)
}

class LoginView: UIView {
    
    // MARK: UI
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPassword: UIButton!
    
    // MARK: Properties
    var delegate: LoginViewDelegate?
    
    
    // MARK: Actions
    @IBAction func loginTapped(sender: AnyObject) {
        
        delegate?.loginViewButtonTapped(.LOGIN_BUTTON)
    }
    
    @IBAction func forgotPassword(sender: AnyObject) {
        
        delegate?.loginViewButtonTapped(.FORGOT_BUTTON)
    }
    
}
