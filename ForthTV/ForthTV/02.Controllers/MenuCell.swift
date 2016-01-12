//
//  MenuCell.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/12/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    // MARK: Properties
    var menuSelected: Bool;
    
    // MARK: UI
    @IBOutlet weak var selectedLine: UIView!
    @IBOutlet weak var menuTitle: UILabel!
    
    // MARK: Life Cyle
    
    required init?(coder aDecoder: NSCoder) {
        
        menuSelected = false
        super.init(coder: aDecoder)
    }
    
    // MARK: Methods
    func selected(selected: Bool){
        
        if (selected)
        {
            // selectedLine
            selectedLine.hidden = false
            selectedLine.backgroundColor = THEME_YELLOW_COLOR
            
            // menuTitle
            menuTitle.textColor = THEME_YELLOW_COLOR
            
            // update Bool Variable
            menuSelected = true
        }
        else
        {
            // selectedLine
            selectedLine.hidden = true
            
            // menuTitle
            menuTitle.textColor = UIColor.whiteColor()
            
            // update Bool Variable
            menuSelected = false
        }
        
    }
    
    func createStyle(){
        
        let selectedView: UIView = UIView(frame: self.bounds)
        selectedView.backgroundColor = UIColor.clearColor()
        
        self.backgroundColor = UIColor.clearColor()
        self.selectedBackgroundView = selectedView
        
        // selectedLine
        selectedLine.hidden = true
        
        // menuTitle
        menuTitle.textColor = UIColor.whiteColor()
        menuTitle.backgroundColor = UIColor.clearColor()
    }
    
    func setTextContent(text:String){
        menuTitle.text = text
   
    }
}


