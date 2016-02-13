//
//  WebViewViewController.swift
//  CafBuddy
//
//  Copyright © 2016 CafBuddy. All rights reserved.
//

import UIKit

class WebViewViewController: MainScreenViewController {
    
    var webViewMain = UIWebView()
    
    var navigationTitle : String?
    var webViewURL : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set the title of the navigation bar if it has been provided
        if (navigationTitle != nil) {
            navigationItem.title = navigationTitle!
        }

        initInterface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initInterface() {
        self.view.backgroundColor = COLOR_NEUTRAL_BACKGROUND
        
        webViewMain.frame = CGRectMake(0,0, screenSize.width, screenSize.height - STATUS_BAR_HEIGHT - NAV_BAR_HEIGHT - TAB_BAR_HEIGHT)
        
        self.view.addSubview(webViewMain)
        
        refreshWebView()
    }
    
    func refreshWebView() {
        if (webViewURL != nil) {
            webViewMain.loadRequest(NSURLRequest(URL: NSURL(string: webViewURL!)!))
        }
    }

}