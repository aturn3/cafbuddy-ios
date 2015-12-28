//
//  LoginViewController.swift
//  CafBuddy
//
//  Created by Andrew Turnblad on 12/26/15.
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = COLOR_BLUE
        
        // Login Button
        let loginButton = UIButton(type: UIButtonType.System) as UIButton
        loginButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        loginButton.setTitle("Login", forState: UIControlState.Normal)
        loginButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        loginButton.backgroundColor = COLOR_RED
        loginButton.layer.cornerRadius = 10
        loginButton.frame = CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2, 200, 50)
        self.view.addSubview(loginButton)
        
        // Goto Register Button
        let registerButton = UIButton(type: UIButtonType.System) as UIButton
        registerButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        registerButton.setTitle("Don't have an account? Register", forState: UIControlState.Normal)
        registerButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        registerButton.backgroundColor = COLOR_RED
        registerButton.layer.cornerRadius = 10
        registerButton.frame = CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2 + 60, 200, 50)
        registerButton.addTarget(self, action: "gotoRegisterPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(registerButton)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Goto Register Button Action
    @IBAction func gotoRegisterPressed(sender: UIButton) {
        self.performSegueWithIdentifier("toRegisterFromLogin", sender: nil)
    }
    
}