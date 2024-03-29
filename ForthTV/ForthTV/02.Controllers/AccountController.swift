//
//  AccountController.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/4/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

enum ACCOUNT_VIEW_TYPE {
    case LOGIN
    case REGISTER
}

class AccountController: BaseController,
                         LoginViewDelegate,
                         RegisterViewDelegate{

    // MARK: UI
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var signinButton: CustomTab!
    @IBOutlet weak var registerButton: CustomTab!
    
    // MARK: Properties
    var loginView: LoginView?
    var registerView: RegisterView?
    var accountViewType: ACCOUNT_VIEW_TYPE?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // configure for beginning
        configureForBeginning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Add Logo
        self.setLogo()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // call login or register view
        changeToView ()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setObject(object: Any?) {
        accountViewType = object as? ACCOUNT_VIEW_TYPE
    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            
          Master.sharedInstance.openMenu()
        }
    }
    
    // MARK: Methods
    private func configureForBeginning() {
        
        // for view
        self.view.backgroundColor = THEME_BLUE_COLOR
        
        // for mainView
        mainView.backgroundColor = THEME_BLUE_COLOR
        
        // for signinButton
        signinButton.backgroundColor = UIColor.clearColor()
        signinButton.tintColor = UIColor.whiteColor()
        
        // for registerButton
        registerButton.backgroundColor = UIColor.clearColor()
        registerButton.tintColor = UIColor.whiteColor()
        
        // for loginView
        loginView = UIView.fromNib()
        loginView?.delegate = self
        loginView?.backgroundColor = THEME_BLUE_COLOR
        mainView.addSubview(loginView!)
        
        // for registerView
        registerView = UIView.fromNib()
        registerView?.delegate = self
        registerView?.backgroundColor = THEME_BLUE_COLOR
        mainView.addSubview(registerView!)
        
    }
    
    private func changeToView() {
        
        layoutforTabs()
        layoutForViews()
    }
    
    private func layoutForViews() {
        
        if self.accountViewType ==  .LOGIN
        {
            Master.sharedInstance.flip(registerView!, toView: loginView!)
        }
        else
        {
            Master.sharedInstance.flip(loginView!, toView: registerView!)
        }
    }
    
    private func layoutforTabs() {
        
        if accountViewType ==  .LOGIN
        {
            // change signinButton -> true
            signinButton.setTabSelected(true)
            
            // change registerButton -> false
            registerButton.setTabSelected(false)
        }
        else
        {
            // change registerButton -> true
            registerButton.setTabSelected(true)
            
            // change signinButton -> false
            signinButton.setTabSelected(false)
        }
    }
    
    // MARK: Actions
    @IBAction func signinTapped(sender: AnyObject) {
       
        // change to loginView
        accountViewType = .LOGIN
        changeToView()
        
    }
    
    @IBAction func registerTapped(sender: AnyObject) {
      
        // change to registerView
        accountViewType = .REGISTER
        changeToView()
        
    }
    
    // MARK: LoginViewDelegate
    func loginViewButtonTapped(buttonType: LOGINVIEW_BUTTON_TYPE) {
        
    }
    
    // MARK: RegisterViewDelegate
    func registerViewButtonTapped(buttonType: REGISTER_BUTTON_TYPE) {
        
    }
    
}
