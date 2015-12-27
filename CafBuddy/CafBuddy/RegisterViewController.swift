//
//  RegisterViewController.swift
//  CafBuddy
//
//  Created by Andrew Turnblad on 12/26/15.
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Login
    @IBAction func LoginAction(sender: UIButton) {
        // Goto LoginViewController
        self.performSegueWithIdentifier("loginSegueIdentifier", sender: nil)
    }
    
    //Register
    @IBAction func RegisterAction(sender: UIButton) {
        // Call up login for cloud
        
        // Success
        self.performSegueWithIdentifier("registerSuccessfulSegueIdentifier", sender: nil)
    }
    
    
}