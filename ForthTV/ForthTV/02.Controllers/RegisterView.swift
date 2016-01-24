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

class RegisterView: UIView ,
                    UITextFieldDelegate
{
   
    // MARK: UI
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var dateOfBirthTextfield: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: Properties
    var delegate: RegisterViewDelegate?
    
    // MARK: Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureForBeginning ()
        
    }
    
    // MARK: Actions
    @IBAction func registerTapped(sender: AnyObject) {
        
        delegate!.registerViewButtonTapped(.REGISTER_BUTTON)
    }
    
    @IBAction func dobEdingChange(sender: UITextField) {
        
        // Create datepicker
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        datePickerView.setValue(THEME_DARK_GRAY, forKeyPath: "textColor")
        datePickerView.backgroundColor = UIColor.whiteColor()
        
        // Add Picker to inputview
        sender.inputView = datePickerView as UIView
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    // MARK: Methods
    func configureForBeginning() {
        
        // for userNameTextfield
        userNameTextfield.leftView = UIImageView(image: UIImage(named: "icon_username"))
        userNameTextfield.leftViewMode = .Always
        userNameTextfield.backgroundColor = UIColor.whiteColor()
        userNameTextfield.textColor = THEME_DARK_GRAY
        userNameTextfield.layer.cornerRadius = 4.0
        userNameTextfield.placeholder = "USER NAME"
        
        // for emailTextfield
        emailTextfield.leftView = UIImageView(image: UIImage(named: "icon_email"))
        emailTextfield.leftViewMode = .Always
        emailTextfield.keyboardType = .EmailAddress
        emailTextfield.backgroundColor = UIColor.whiteColor()
        emailTextfield.textColor = THEME_DARK_GRAY
        emailTextfield.layer.cornerRadius = 4.0
        emailTextfield.placeholder = "EMAIL"
        
        // for passwordTextfield
        passwordTextfield.leftView = UIImageView(image: UIImage(named: "icon_password"))
        passwordTextfield.leftViewMode = .Always
        passwordTextfield.secureTextEntry = true
        passwordTextfield.backgroundColor = UIColor.whiteColor()
        passwordTextfield.textColor = THEME_DARK_GRAY
        passwordTextfield.layer.cornerRadius = 4.0
        passwordTextfield.placeholder = "PASSWORD"
        
        // for dateOfBirthTextfield
        dateOfBirthTextfield.leftView = UIImageView(image: UIImage(named: "icon_birthday"))
        dateOfBirthTextfield.leftViewMode = .Always
        dateOfBirthTextfield.backgroundColor = UIColor.whiteColor()
        dateOfBirthTextfield.textColor = THEME_DARK_GRAY
        dateOfBirthTextfield.layer.cornerRadius = 4.0
        dateOfBirthTextfield.placeholder = "DATE OF BIRTH"
        
        // for registerButton
        registerButton.titleLabel?.textColor = UIColor.whiteColor()
        registerButton.backgroundColor = THEME_YELLOW_COLOR
        registerButton.layer.cornerRadius = 4.0
        registerButton.titleLabel?.text = "REGISTER"
       
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        // Get date from picker
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        // Asign to dateOfBirthTextfield
        dateOfBirthTextfield.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
}
