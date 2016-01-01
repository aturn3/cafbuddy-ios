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
        
        // Necessary for using auto layout - disables problematic automatic constraints being set
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // Username Field
//        self.usernameField.frame = CGRectMake(SCREEN_WIDTH/2 - 125, SCREEN_HEIGHT/3, 250, 50)
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
//        self.passwordField.frame = CGRectMake(SCREEN_WIDTH/2 - 125, SCREEN_HEIGHT/3 + 60, 250, 50)
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
//        self.reEnterPasswordField.frame = CGRectMake(SCREEN_WIDTH/2 - 125, SCREEN_HEIGHT/3 + 120, 250, 50)
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
//        self.registerButton.frame = CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2 + 100, 200, 50)
        self.registerButton.addTarget(self, action: "registerButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.registerButton)
        
        // Goto Login Button
        self.loginButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        self.loginButton.setTitle("Already have an account? Login", forState: UIControlState.Normal)
        self.loginButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        self.loginButton.backgroundColor = COLOR_RED
        self.loginButton.layer.cornerRadius = 10
//        self.loginButton.frame = CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2 + 160, 200, 50)
        self.loginButton.addTarget(self, action: "gotoLoginButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.loginButton)
        
        // MARK: - Constraints
        
        // Username Field
        let usernameFieldConstraintHeight = NSLayoutConstraint(item: usernameField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        let usernameFieldConstraintWidth = NSLayoutConstraint(item: usernameField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 250.0)
        let usernameFieldConstraintLocationX = NSLayoutConstraint(item: usernameField, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: SCREEN_WIDTH/2)
        let usernameFieldConstraintLocationY = NSLayoutConstraint(item: usernameField, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: SCREEN_HEIGHT/3)
        
        // Password Field
        let passwordFieldConstraintEqualHeightUsernameField = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: usernameField, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0)
        let passwordFieldConstraintEqualWidthUsernameField = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: usernameField, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0.0)
        let passwordFieldConstraintEqualLocationXUsernameField = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: usernameField, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        let passwordFieldConstraintLocationYUsernameField = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: usernameField, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 60.0)
        
        // ReEnter Password Field
        let reEnterPasswordFieldConstraintEqualHeightUsernameField = NSLayoutConstraint(item: reEnterPasswordField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: usernameField, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0)
        let reEnterPasswordFieldConstraintEqualWidthUsernameField = NSLayoutConstraint(item: reEnterPasswordField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: usernameField, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0.0)
        let reEnterPasswordFieldConstraintEqualLocationXUsernameField = NSLayoutConstraint(item: reEnterPasswordField, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: usernameField, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        let reEnterPasswordFieldConstraintLocationYPasswordField = NSLayoutConstraint(item: reEnterPasswordField, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: passwordField, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 60.0)
        
        // Register Button
        let registerButtonConstraintHeight = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        let registerButtonConstraintWidth = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 200.0)
        let registerButtonConstraintLocationX = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: usernameField, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        let registerButtonConstraintLocationYReEnterPasswordField = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: reEnterPasswordField, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 60.0)
        
        
        // Goto Login Button
        let loginButtonConstraintEqualHeightRegisterButton = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: registerButton, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0)
        let loginButtonConstraintEqualWidthRegisterButton = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: registerButton, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0.0)
        let loginButtonConstraintEqualLocationXRegisterButton = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: registerButton, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        let loginButtonConstraintLocationYRegisterButton = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: registerButton, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 60.0)
        
        
        // Activate all constraints
        NSLayoutConstraint.activateConstraints([usernameFieldConstraintHeight, usernameFieldConstraintWidth, usernameFieldConstraintLocationX, usernameFieldConstraintLocationY, passwordFieldConstraintEqualHeightUsernameField, passwordFieldConstraintEqualWidthUsernameField, passwordFieldConstraintEqualLocationXUsernameField, passwordFieldConstraintLocationYUsernameField, reEnterPasswordFieldConstraintEqualHeightUsernameField, reEnterPasswordFieldConstraintEqualWidthUsernameField, reEnterPasswordFieldConstraintEqualLocationXUsernameField, reEnterPasswordFieldConstraintLocationYPasswordField, registerButtonConstraintHeight, registerButtonConstraintWidth, registerButtonConstraintLocationX, registerButtonConstraintLocationYReEnterPasswordField, loginButtonConstraintEqualHeightRegisterButton, loginButtonConstraintEqualWidthRegisterButton, loginButtonConstraintEqualLocationXRegisterButton, loginButtonConstraintLocationYRegisterButton])
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