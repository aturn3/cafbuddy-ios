//
//  MainScreenViewControlller.swift
//  CafBuddy
//
//  Copyright © 2016 CafBuddy. All rights reserved.
//

import Foundation
import UIKit

class MainScreenViewController: UIViewController {
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    
    // Just necessary - but never actually called
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set the tint of navbar to be the main color of the app
        navigationController?.navigationBar.barTintColor = COLOR_MAIN
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    // MARK: - Helper Methods
    func getCurrentUser() -> User {
        let dataController = self.tabBarController as! TabBarController
        return dataController.user
    }
}