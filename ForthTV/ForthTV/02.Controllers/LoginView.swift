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
    
    // MARK: Life Cycle
    override func layoutSubviews() {
        configureForBeginning ()
        
        super.layoutSubviews()

    }
    
    
    // MARK: Actions
    @IBAction func loginTapped(sender: AnyObject) {
        
        delegate?.loginViewButtonTapped(.LOGIN_BUTTON)
    }
    
    @IBAction func forgotPassword(sender: AnyObject) {
        
        delegate?.loginViewButtonTapped(.FORGOT_BUTTON)
    }
    
    // MARK: Methods
    func configureForBeginning() {
        
        // for emailTextfield
        emailTextfield.leftView = UIImageView(image: UIImage(named: "icon_email"))
        emailTextfield.leftViewMode = .Always
        emailTextfield.keyboardType = .EmailAddress
        emailTextfield.backgroundColor = UIColor.whiteColor()
        emailTextfield.textColor = THEME_DARK_GRAY
        emailTextfield.layer.cornerRadius = 4.0
        emailTextfield.placeholder = "EMAIL"
      //  emailTextfield.font = FORTH_FONT_17
        
        // for passwordTextfield
        passwordTextfield.leftView = UIImageView(image: UIImage(named: "icon_password"))
        passwordTextfield.leftViewMode = .Always
        passwordTextfield.secureTextEntry = true
        passwordTextfield.backgroundColor = UIColor.whiteColor()
        passwordTextfield.textColor = THEME_DARK_GRAY
        passwordTextfield.layer.cornerRadius = 4.0
        passwordTextfield.placeholder = "PASSWORD"
        
        // for registerButton
        loginButton.titleLabel?.text = "SIGN IN"
        loginButton.titleLabel?.textColor = UIColor.whiteColor()
        loginButton.backgroundColor = THEME_YELLOW_COLOR
        loginButton.layer.cornerRadius = 4.0
       
        //for forgotPassword
        forgotPassword.titleLabel?.text = "FORGOT PASSWORD"
        forgotPassword.titleLabel?.textColor = UIColor.redColor()
        forgotPassword.backgroundColor = UIColor.clearColor()
        
        
    }
    
}
