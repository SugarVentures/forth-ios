//
//  MenuController.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/6/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

class MenuController: BaseController, UITableViewDelegate, UITableViewDataSource {
    
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
        
        // create menu
        let cell : MenuCell = UIView.fromNib()
        cell.createStyle()
        cell.setTextContent(MENU_ARRAY[indexPath.row])
        
        return cell
    }
    
    // MARK:
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
   
        // style for cell
        let menuCell: MenuCell = tableView.cellForRowAtIndexPath(indexPath) as! MenuCell
        menuCell.selected(true)
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let menuCell: MenuCell = tableView.cellForRowAtIndexPath(indexPath) as! MenuCell
        menuCell.selected(false)
        
    }

}
