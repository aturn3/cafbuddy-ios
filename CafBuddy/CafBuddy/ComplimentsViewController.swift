//
//  ComplimentsViewController
//  CafBuddy
//
//  Copyright © 2016 CafBuddy. All rights reserved.
//

import UIKit

class ComplimentsViewController: MainScreenViewController {
    
    var webViewMain = UIWebView()
    
    var navigationTitle : String?
    var webViewURL : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set the title of the navigation bar if it has been provided
        navigationItem.title = "Your Complements"
        
        initInterface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initInterface() {
        webViewMain.frame = CGRectMake(0,0, screenSize.width, screenSize.height)
        
        self.view.addSubview(webViewMain)
        
        refreshWebView()
    }
    
    func refreshWebView() {
        if (webViewURL != nil) {
            webViewMain.loadRequest(NSURLRequest(URL: NSURL(string: webViewURL!)!))
        }
    }
    
}