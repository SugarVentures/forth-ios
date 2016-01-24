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
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
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
        
        if accountViewType ==  .LOGIN
        {
            mainView.bringSubviewToFront(loginView!)
        }
        else
        {
             mainView.bringSubviewToFront(registerView!)
        }
        
        
    }
    
    // MARK: Actions
    @IBAction func signinTapped(sender: AnyObject) {
        
        // change signinButton
        
        // change to loginView
        changeToView()
        
    }
    
    @IBAction func registerTapped(sender: AnyObject) {
        
        // change registerButton
        
        // change to registerView
        changeToView()
        
    }
    
    // MARK: LoginViewDelegate
    func loginViewButtonTapped(buttonType: LOGINVIEW_BUTTON_TYPE) {
        
    }
    
    // MARK: RegisterViewDelegate
    func registerViewButtonTapped(buttonType: REGISTER_BUTTON_TYPE) {
        
    }
    
}
