//
//  MenuHeaderLogined.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/12/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

class MenuHeaderLogined: UITableViewHeaderFooterView {

    // MARK: UI
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    // MARK : Methods
    func createHeaderUI(){
        
        // for imgAvatar
        imgAvatar.layer.cornerRadius = 0.5 * imgAvatar.bounds.size.width
    }
    
}
