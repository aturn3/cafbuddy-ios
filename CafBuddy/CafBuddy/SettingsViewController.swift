//
//  ProfileViewController
//  CafBuddy
//
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import UIKit

class SettingsViewController: MainScreenViewController, UITableViewDelegate, UITableViewDataSource {
    
    var scrollViewMain = UIScrollView()
    var tableViewMainOptions = UITableView()
    let settingsOptions = [
        ["Your Compliments"],
        ["How CafBuddy Works", "Terms of Service", "Privacy Policy", "Credits"],
        ["Log Out"]
    ]
    var rowHeight = CGFloat(50)
    
    var webViewTitle : String?
    var webViewURL : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Set the title of the navigation bar
        navigationItem.title = "Settings"
        
        initInterface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initInterface() {
        // based on whatever the row height is, it will leave the margin at what is if the user already has to scroll
        // otherwise it will increase the margin above the table (where the image goes) if there should be extra space
        // there so that the last button is at the bottom of the screen
        var marginTopTable = CGFloat(150)
        var totalSpaces = 0
        for optionsList in settingsOptions {
            totalSpaces += optionsList.count + 1
        }
        totalSpaces -= 1 // account for last space not being there since last section
        
        let spaceAvailable = screenSize.height - STATUS_BAR_HEIGHT - TAB_BAR_HEIGHT - NAV_BAR_HEIGHT
        let currentSpaceTaken = (CGFloat(totalSpaces) * rowHeight) + marginTopTable
        if (currentSpaceTaken < spaceAvailable){
            marginTopTable += (spaceAvailable - currentSpaceTaken)
        }
        let newSpaceTaken = (CGFloat(totalSpaces) * rowHeight) + marginTopTable

        scrollViewMain.frame = CGRectMake(0, 0, screenSize.width, spaceAvailable)
        scrollViewMain.contentSize = CGSizeMake(screenSize.width, newSpaceTaken)
        scrollViewMain.scrollEnabled = true
        scrollViewMain.delegate = self
        scrollViewMain.backgroundColor = COLOR_NEUTRAL_BACKGROUND
        
        tableViewMainOptions.delegate = self
        tableViewMainOptions.dataSource = self
        tableViewMainOptions.scrollEnabled = false
        tableViewMainOptions.rowHeight = rowHeight
        tableViewMainOptions.frame = CGRectMake(0, marginTopTable, screenSize.width, screenSize.height)
        tableViewMainOptions.backgroundColor = COLOR_NEUTRAL_BACKGROUND
        tableViewMainOptions.registerClass(UITableViewCell.self, forCellReuseIdentifier: "settingsCell")
        tableViewMainOptions.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "footerView")
        
        
        self.view.addSubview(scrollViewMain)
        scrollViewMain.addSubview(tableViewMainOptions)
    }
    
    
    //MARK: - Action Methods
    
    func toWebView(url: String, title: String) {
        webViewURL = url
        webViewTitle = title
        self.performSegueWithIdentifier("toWebViewFromSettings", sender: self)
    }
    
    func toLogIn() {
        self.performSegueWithIdentifier("toLoginFromSettings", sender: self)
    }
    
    func toComplementsView() {
        self.performSegueWithIdentifier("toComplementsFromSettings", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // before going to the webview screen, need to set the url that the webview should load to
        // and what the title of the page should be
        if segue.identifier == "toWebViewFromSettings" {
            let destinationController = segue.destinationViewController as! WebViewViewController
            destinationController.navigationTitle = webViewTitle
            destinationController.webViewURL = webViewURL
            webViewTitle = nil
            webViewURL = nil
        }
    }
    
    
    //MARK: - Table View Delegate Methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let settingsCell = tableView.dequeueReusableCellWithIdentifier("settingsCell", forIndexPath: indexPath)
        
        settingsCell.textLabel?.text = settingsOptions[indexPath.section][indexPath.row]
        settingsCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return settingsCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsOptions[section].count
    }

    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterViewWithIdentifier("footerView")
        return footer
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // all footers should be 50 in size except last shouldn't have a footer since at bottom
        if (section != settingsOptions.count - 1) {
            return rowHeight
        }
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return settingsOptions.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // first we have to unselect the chosen row so that it doesn't stay highlighted
        tableViewMainOptions.deselectRowAtIndexPath(indexPath, animated: true)
        
        // profile actions
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                toComplementsView()
            }
            
        }
        // content sections about CafBuddy
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                toWebView("https://cafbuddy.appspot.com/howitworks", title: "How Cafbuddy Works")
            }
            else if (indexPath.row == 1) {
                toWebView("https://cafbuddy.appspot.com/termsofservice", title: "Terms Of Service")
            }
            else if (indexPath.row == 2) {
                toWebView("https://cafbuddy.appspot.com/privacypolicy", title: "Privacy Policy")
            }
            else if (indexPath.row == 3) {
                toWebView("https://cafbuddy.appspot.com/credits", title: "Credits")
            }
        }
        // actions (log out)
        else if (indexPath.section == 2){
            let curUser = getCurrentUser()
            curUser.logout()
            toLogIn()
        }
    }
    
}