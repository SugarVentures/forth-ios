//
//  MenuController.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/6/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

class MenuController: BaseController,
                      UITableViewDelegate,
                      UITableViewDataSource,
                      MenuHeaderDelegate
{
    
    // MARK: UI
    @IBOutlet weak var menuTable: UITableView!
    
    // MARK: Properties
    var mainViewController: UIViewController!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureForBeginning()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Internal methods
    func configureForBeginning() {
        // set page color
        self.view.backgroundColor =  THEME_DARK_GRAY
        
        // for menuTable
        menuTable.backgroundColor = UIColor.clearColor()
        menuTable.scrollEnabled = false
        menuTable.separatorStyle = .None
        
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MENU_ARRAY.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellID = "MenuCell"
        var cell : MenuCell? = tableView .dequeueReusableCellWithIdentifier(cellID) as? MenuCell
        
        if cell == nil {
            // create menu
            cell  = UIView.fromNib()
            cell!.createStyle()
            cell!.setTextContent(MENU_ARRAY[indexPath.row])
        }

        return cell!
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
   
        // style for cell
        let menuCell: MenuCell = tableView.cellForRowAtIndexPath(indexPath) as! MenuCell
        menuCell.selected(true)
        
        // close menu
        kAppDelegate.slideController.closeLeft()
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
         // style for cell
        let menuCell: MenuCell = tableView.cellForRowAtIndexPath(indexPath) as! MenuCell
        menuCell.selected(false)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        // not login
        let menuHeaderID = "MenuHeader"
        var menuHeader: MenuHeader? = tableView.dequeueReusableHeaderFooterViewWithIdentifier(menuHeaderID) as? MenuHeader
           
        if menuHeader == nil {
            
            menuHeader = UIView.fromNib()

        }
        menuHeader?.delegate = self
        
        return menuHeader
        
        
//        //logged
//        let menuHeaderLoggedID = "MenuHeaderLogined"
//        var menuHeaderLogged: MenuHeaderLogined? = tableView.dequeueReusableHeaderFooterViewWithIdentifier(menuHeaderLoggedID) as? MenuHeaderLogined
//        
//        if menuHeaderLogged == nil {
//            
//            menuHeaderLogged = UIView.fromNib()
//            
//        }
//        return menuHeaderLogged
        
    }
    
    // MARK: MenuHeaderDelegate
    func buttonTapped(buttonType: HEADER_BUTTON_TYPE) {
        
        if buttonType == .LOGIN {
            
            Master.sharedInstance.pushController(.ACCOUNT, animated: true, object: ACCOUNT_VIEW_TYPE.LOGIN)
        }
        else {
            
             Master.sharedInstance.pushController(.ACCOUNT, animated: true, object: ACCOUNT_VIEW_TYPE.REGISTER)
        }
        
    }
}
