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
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Username Field
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
        self.usernameField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.usernameField)
        
        // Password Field
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
        self.passwordField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.passwordField)
        
        // Re-enter Password Field
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
        self.reEnterPasswordField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.reEnterPasswordField)
        
        // Register Button
        self.registerButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        self.registerButton.setTitle("Register", forState: UIControlState.Normal)
        self.registerButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        self.registerButton.backgroundColor = COLOR_RED
        self.registerButton.layer.cornerRadius = 10
        self.registerButton.addTarget(self, action: "registerButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.registerButton)
        
        // Goto Login Button
        self.loginButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        self.loginButton.setTitle("Already have an account? Login", forState: UIControlState.Normal)
        self.loginButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        self.loginButton.backgroundColor = COLOR_RED
        self.loginButton.layer.cornerRadius = 10
        self.loginButton.addTarget(self, action: "gotoLoginButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.loginButton)
        
        // MARK: - Constraints
        
        // Username Field
        let usernameFieldConstraintLeft = NSLayoutConstraint(item: usernameField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (1/6)*SCREEN_WIDTH)
        let usernameFieldConstraintRight = NSLayoutConstraint(item: usernameField, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-1/6)*SCREEN_WIDTH)
        let usernameFieldConstraintTop = NSLayoutConstraint(item: usernameField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: (1/3)*SCREEN_HEIGHT)
        let usernameFieldConstraintBottom = NSLayoutConstraint(item: usernameField, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // Password Field
        let passwordFieldConstraintLeft = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        let passwordFieldConstraintRight = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
        let passwordFieldConstraintTop = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        let passwordFieldConstraintBottom = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.passwordField, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // ReEnter Password Field
        let reEnterPasswordFieldConstraintLeft = NSLayoutConstraint(item: reEnterPasswordField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        let reEnterPasswordFieldConstraintRight = NSLayoutConstraint(item: reEnterPasswordField, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
        let reEnterPasswordFieldConstraintTop = NSLayoutConstraint(item: reEnterPasswordField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.passwordField, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        let reEnterPasswordFieldConstraintBottom = NSLayoutConstraint(item: reEnterPasswordField, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.reEnterPasswordField, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // Register Button
        let registerButtonConstraintLeft = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        let registerButtonConstraintRight = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
        let registerButtonConstraintTop = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.reEnterPasswordField, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        let registerButtonConstraintBottom = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.registerButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // Goto Login Button
        let loginButtonConstraintLeft = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        let loginButtonConstraintRight = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
        let loginButtonConstraintTop = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.registerButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        let loginButtonConstraintBottom = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.loginButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        
        // Activate all constraints
        NSLayoutConstraint.activateConstraints([usernameFieldConstraintLeft, usernameFieldConstraintRight, usernameFieldConstraintTop, usernameFieldConstraintBottom, passwordFieldConstraintLeft, passwordFieldConstraintRight, passwordFieldConstraintTop, passwordFieldConstraintBottom, reEnterPasswordFieldConstraintLeft, reEnterPasswordFieldConstraintRight, reEnterPasswordFieldConstraintTop, reEnterPasswordFieldConstraintBottom, registerButtonConstraintLeft, registerButtonConstraintRight, registerButtonConstraintTop, registerButtonConstraintBottom, loginButtonConstraintLeft, loginButtonConstraintRight, loginButtonConstraintTop, loginButtonConstraintBottom])
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