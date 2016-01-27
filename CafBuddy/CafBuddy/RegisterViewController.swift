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
    
    var usernameFieldConstraintLeft = NSLayoutConstraint()
    var usernameFieldConstraintRight = NSLayoutConstraint()
    var usernameFieldConstraintTop = NSLayoutConstraint()
    var usernameFieldConstraintBottom = NSLayoutConstraint()
    
    var passwordFieldConstraintLeft = NSLayoutConstraint()
    var passwordFieldConstraintRight = NSLayoutConstraint()
    var passwordFieldConstraintTop = NSLayoutConstraint()
    var passwordFieldConstraintBottom = NSLayoutConstraint()
    
    var reEnterPasswordFieldConstraintLeft = NSLayoutConstraint()
    var reEnterPasswordFieldConstraintRight = NSLayoutConstraint()
    var reEnterPasswordFieldConstraintTop = NSLayoutConstraint()
    var reEnterPasswordFieldConstraintBottom = NSLayoutConstraint()
    
    var registerButtonConstraintLeft = NSLayoutConstraint()
    var registerButtonConstraintRight = NSLayoutConstraint()
    var registerButtonConstraintTop = NSLayoutConstraint()
    var registerButtonConstraintBottom = NSLayoutConstraint()
    
    var loginButtonConstraintLeft = NSLayoutConstraint()
    var loginButtonConstraintRight = NSLayoutConstraint()
    var loginButtonConstraintTop = NSLayoutConstraint()
    var loginButtonConstraintBottom = NSLayoutConstraint()
    
    var keyboardShowing = false
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initInterface()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initInterface() {
        view.backgroundColor = COLOR_BLUE
        
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
        self.usernameFieldConstraintLeft = NSLayoutConstraint(item: usernameField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (1/6)*SCREEN_WIDTH)
        self.usernameFieldConstraintRight = NSLayoutConstraint(item: usernameField, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-1/6)*SCREEN_WIDTH)
        self.usernameFieldConstraintTop = NSLayoutConstraint(item: usernameField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: (1/3)*SCREEN_HEIGHT)
        self.usernameFieldConstraintBottom = NSLayoutConstraint(item: usernameField, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // Password Field
        self.passwordFieldConstraintLeft = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        self.passwordFieldConstraintRight = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
        self.passwordFieldConstraintTop = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.passwordFieldConstraintBottom = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.passwordField, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // ReEnter Password Field
        self.reEnterPasswordFieldConstraintLeft = NSLayoutConstraint(item: reEnterPasswordField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        self.reEnterPasswordFieldConstraintRight = NSLayoutConstraint(item: reEnterPasswordField, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
        self.reEnterPasswordFieldConstraintTop = NSLayoutConstraint(item: reEnterPasswordField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.passwordField, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.reEnterPasswordFieldConstraintBottom = NSLayoutConstraint(item: reEnterPasswordField, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.reEnterPasswordField, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // Register Button
        self.registerButtonConstraintLeft = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        self.registerButtonConstraintRight = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
        self.registerButtonConstraintTop = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.reEnterPasswordField, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.registerButtonConstraintBottom = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.registerButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // Goto Login Button
        self.loginButtonConstraintLeft = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        self.loginButtonConstraintRight = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.usernameField, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
        self.loginButtonConstraintTop = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.registerButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.loginButtonConstraintBottom = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.loginButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        
        // Activate all constraints
        NSLayoutConstraint.activateConstraints([self.usernameFieldConstraintLeft, self.usernameFieldConstraintRight, self.usernameFieldConstraintTop, self.usernameFieldConstraintBottom, self.passwordFieldConstraintLeft, self.passwordFieldConstraintRight, self.passwordFieldConstraintTop, self.passwordFieldConstraintBottom, self.reEnterPasswordFieldConstraintLeft, self.reEnterPasswordFieldConstraintRight, self.reEnterPasswordFieldConstraintTop, self.reEnterPasswordFieldConstraintBottom, self.registerButtonConstraintLeft, self.registerButtonConstraintRight, self.registerButtonConstraintTop, self.registerButtonConstraintBottom, self.loginButtonConstraintLeft, self.loginButtonConstraintRight, self.loginButtonConstraintTop, self.loginButtonConstraintBottom])
    }
    
    // MARK: - Action Methods
    
    // Goto Login Button Action
    func gotoLoginButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("toLoginFromRegister", sender: self)
    }
    
    // MARK: - Text Field Delegate Methods
    
    func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        print("before", self.usernameFieldConstraintTop)
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.usernameFieldConstraintTop.constant = keyboardFrame.size.height + 55
        })
        
        print("after", self.usernameFieldConstraintTop)
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        self.view.frame.origin.y += keyboardSize.height
    }
    
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
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
}