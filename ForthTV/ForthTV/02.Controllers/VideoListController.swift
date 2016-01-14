//
//  VideoListController.swift
//  ForthTV
//
//  Created by Hanh Vo on 1/6/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

class VideoListController: BaseController, UITableViewDelegate, UITableViewDataSource {

    // MARK: UI
    @IBOutlet weak var videoListTable: UITableView!
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //configure for beginning
        self.configureForBeginning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods:
    func configureForBeginning() {
        
        // for videoListTable
        videoListTable.separatorStyle = .None
        
    }
   
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellID = "VideoCell"
        var cell : VideoCell? = tableView .dequeueReusableCellWithIdentifier(cellID) as? VideoCell
        
        if cell == nil {
            // create menu
            cell  = UIView.fromNib()
            cell!.videoModel = VideoModel()
            
            cell!.displayData(VIDEO_DATA_STATUS.LOADING)
        }
        
        return cell!
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
}
