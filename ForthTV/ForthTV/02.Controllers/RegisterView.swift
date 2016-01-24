//
//  RegisterController.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/6/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

enum REGISTER_BUTTON_TYPE{
    case REGISTER_BUTTON
}

protocol RegisterViewDelegate {
    
    func registerViewButtonTapped(buttonType: REGISTER_BUTTON_TYPE)
}

class RegisterView: UIView {
   
    // MARK: UI
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var dateOfBirthTextfield: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: Properties
    var delegate: RegisterViewDelegate?
    
    // MARK: Actions
    @IBAction func registerTapped(sender: AnyObject) {
        
        delegate!.registerViewButtonTapped(.REGISTER_BUTTON)
    }
}
