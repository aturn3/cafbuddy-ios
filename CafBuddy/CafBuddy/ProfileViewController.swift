//
//  ProfileViewController
//  CafBuddy
//
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import UIKit

class ProfileViewController: MainScreenViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableViewMainOptions = UITableView()
//    let
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initInterface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initInterface() {
        
        
        tableViewMainOptions.delegate = self
        tableViewMainOptions.dataSource = self
        tableViewMainOptions.rowHeight = 50
        tableViewMainOptions.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
        tableViewMainOptions.backgroundColor = COLOR_NEUTRAL_BACKGROUND
        tableViewMainOptions.registerClass(UITableViewCell.self, forCellReuseIdentifier: "settingsCell")
        
        
        self.view.addSubview(tableViewMainOptions)
    }
    
    
    //MARK: - Table View Delegate Methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let settingsCell = tableView.dequeueReusableCellWithIdentifier("settingsCell", forIndexPath: indexPath)
        
        if (indexPath.row == 0) {
            settingsCell.textLabel?.text = "FAQ"
        }
        else {
            settingsCell.textLabel?.text = "Terms of Service"
        }
        
        return settingsCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
}