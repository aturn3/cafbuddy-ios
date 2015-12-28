//
//  RegisterViewController.swift
//  CafBuddy
//
//  Created by Andrew Turnblad on 12/26/15.
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    let registerButton = UIButton(type: UIButtonType.System)
    let loginButton = UIButton(type: UIButtonType.System)
    
    let usernameField = UITextField()
    let passwordField = UITextField()
    let reEnterPasswordField = UITextField()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initInterface()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initInterface() {
        view.backgroundColor = COLOR_BLUE
        
        // Username Field
        self.usernameField.frame = CGRectMake(SCREEN_WIDTH/2 - 125, SCREEN_HEIGHT/3, 250, 50)
        self.usernameField.placeholder = "Username"
        self.usernameField.font = UIFont.systemFontOfSize(12)
        self.usernameField.borderStyle = UITextBorderStyle.RoundedRect
        self.usernameField.autocorrectionType = UITextAutocorrectionType.No
        self.usernameField.autocapitalizationType = UITextAutocapitalizationType.None
        self.usernameField.keyboardType = UIKeyboardType.Default
        self.usernameField.returnKeyType = UIReturnKeyType.Done
        self.usernameField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        self.usernameField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        self.usernameField.returnKeyType = UIReturnKeyType.Next
        self.usernameField.delegate = self
        self.view.addSubview(self.usernameField)
        
        // Password Field
        self.passwordField.frame = CGRectMake(SCREEN_WIDTH/2 - 125, SCREEN_HEIGHT/3 + 60, 250, 50)
        self.passwordField.placeholder = "Password"
        self.passwordField.font = UIFont.systemFontOfSize(12)
        self.passwordField.borderStyle = UITextBorderStyle.RoundedRect
        self.passwordField.autocorrectionType = UITextAutocorrectionType.No
        self.passwordField.autocapitalizationType = UITextAutocapitalizationType.None
        self.passwordField.keyboardType = UIKeyboardType.Default
        self.passwordField.returnKeyType = UIReturnKeyType.Done
        self.passwordField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        self.passwordField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        self.passwordField.returnKeyType = UIReturnKeyType.Next
        self.passwordField.delegate = self
        self.passwordField.secureTextEntry = true
        self.view.addSubview(self.passwordField)
        
        // Re-enter Password Field
        self.reEnterPasswordField.frame = CGRectMake(SCREEN_WIDTH/2 - 125, SCREEN_HEIGHT/3 + 120, 250, 50)
        self.reEnterPasswordField.placeholder = "Re-Enter Password"
        self.reEnterPasswordField.font = UIFont.systemFontOfSize(12)
        self.reEnterPasswordField.borderStyle = UITextBorderStyle.RoundedRect
        self.reEnterPasswordField.autocorrectionType = UITextAutocorrectionType.No
        self.reEnterPasswordField.autocapitalizationType = UITextAutocapitalizationType.None
        self.reEnterPasswordField.keyboardType = UIKeyboardType.Default
        self.reEnterPasswordField.returnKeyType = UIReturnKeyType.Done
        self.reEnterPasswordField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        self.reEnterPasswordField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        self.reEnterPasswordField.returnKeyType = UIReturnKeyType.Default
        self.reEnterPasswordField.delegate = self
        self.reEnterPasswordField.secureTextEntry = true
        self.view.addSubview(self.reEnterPasswordField)
        
        // Register Button
        self.registerButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        self.registerButton.setTitle("Register", forState: UIControlState.Normal)
        self.registerButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        self.registerButton.backgroundColor = COLOR_RED
        self.registerButton.layer.cornerRadius = 10
        self.registerButton.frame = CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2 + 100, 200, 50)
        self.registerButton.addTarget(self, action: "registerButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.registerButton)
        
        // Goto Login Button
        self.loginButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        self.loginButton.setTitle("Already have an account? Login", forState: UIControlState.Normal)
        self.loginButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        self.loginButton.backgroundColor = COLOR_RED
        self.loginButton.layer.cornerRadius = 10
        self.loginButton.frame = CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2 + 160, 200, 50)
        self.loginButton.addTarget(self, action: "gotoLoginButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.loginButton)
    }
    
    // MARK: - Action Methods
    
    // Goto Login Button Action
    func gotoLoginButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("toLoginFromRegister", sender: nil)
    }
    
    // MARK: - Text Field Delegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Go from usernameField to passwordField
        if (textField == usernameField) {
            usernameField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        }
        // Go from passwordField to reEnterPasswordField
        else if (textField == passwordField) {
            passwordField.resignFirstResponder()
            reEnterPasswordField.becomeFirstResponder()
        }
        // Resign text field when "return" button is pressed
        else {
            textField.resignFirstResponder()
        }

        return true
    }
    
    // Check for single or multiple taps on view to dismiss keyboard - resign all text fields
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.resignFirstResponder()
        view.endEditing(true)
    }
    
}