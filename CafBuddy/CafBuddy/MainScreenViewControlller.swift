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
    
    // MARK: - Helper Methods
    func getCurrentUser() -> User {
        let dataController = self.tabBarController as! TabBarController
        return dataController.user
    }
}