//
//  LoginViewController.swift
//  CafBuddy
//
//  Created by Andrew Turnblad on 12/26/15.
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, UserAPICallback {
    
    // MARK: - Properties
    
    let user = User()
    
    let registerButton = UIButton(type: UIButtonType.System)
    let loginButton = UIButton(type: UIButtonType.System)
    
    let emailAddressField = UITextField()
    let passwordField = UITextField()
    let reEnterPasswordField = UITextField()
    
    var emailAddressFieldConstraintLeft = NSLayoutConstraint()
    var emailAddressFieldConstraintRight = NSLayoutConstraint()
    var emailAddressFieldConstraintTop = NSLayoutConstraint()
    var emailAddressFieldConstraintBottom = NSLayoutConstraint()
    
    var passwordFieldConstraintLeft = NSLayoutConstraint()
    var passwordFieldConstraintRight = NSLayoutConstraint()
    var passwordFieldConstraintTop = NSLayoutConstraint()
    var passwordFieldConstraintBottom = NSLayoutConstraint()
    
    var loginButtonConstraintLeft = NSLayoutConstraint()
    var loginButtonConstraintRight = NSLayoutConstraint()
    var loginButtonConstraintTop = NSLayoutConstraint()
    var loginButtonConstraintBottom = NSLayoutConstraint()
    
    var registerButtonConstraintLeft = NSLayoutConstraint()
    var registerButtonConstraintRight = NSLayoutConstraint()
    var registerButtonConstraintTop = NSLayoutConstraint()
    var registerButtonConstraintBottom = NSLayoutConstraint()
    
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
    
    override func viewDidAppear(animated: Bool) {
        if self.user.isLoggedIn() {
            self.user.loadUser()
            
            self.gotoMealScene()
        }
    }
    
    func initInterface() {
        view.backgroundColor = COLOR_BLUE
        
        // Email Field
        self.emailAddressField.placeholder = "Email Address"
        self.emailAddressField.font = UIFont.systemFontOfSize(12)
        self.emailAddressField.borderStyle = UITextBorderStyle.RoundedRect
        self.emailAddressField.autocorrectionType = UITextAutocorrectionType.No
        self.emailAddressField.autocapitalizationType = UITextAutocapitalizationType.None
        self.emailAddressField.keyboardType = UIKeyboardType.Default
        self.emailAddressField.returnKeyType = UIReturnKeyType.Done
        self.emailAddressField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        self.emailAddressField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        self.emailAddressField.returnKeyType = UIReturnKeyType.Next
        self.emailAddressField.delegate = self
        self.emailAddressField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.emailAddressField)
        
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
        self.passwordField.returnKeyType = UIReturnKeyType.Default
        self.passwordField.delegate = self
        self.passwordField.secureTextEntry = true
        self.passwordField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.passwordField)
        
        // Login Button
        self.loginButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        self.loginButton.setTitle("Login", forState: UIControlState.Normal)
        self.loginButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        self.loginButton.backgroundColor = COLOR_RED
        self.loginButton.layer.cornerRadius = 10
        self.loginButton.addTarget(self, action: "loginButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.loginButton)
        
        // Goto Register Button
        self.registerButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        self.registerButton.setTitle("Don't have an account? Register", forState: UIControlState.Normal)
        self.registerButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        self.registerButton.backgroundColor = COLOR_RED
        self.registerButton.layer.cornerRadius = 10
        self.registerButton.addTarget(self, action: "gotoRegisterButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.registerButton)

        // MARK: - Constraints
        
        // Email Field
        self.emailAddressFieldConstraintLeft = NSLayoutConstraint(item: emailAddressField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (1/6)*SCREEN_WIDTH)
        self.emailAddressFieldConstraintRight = NSLayoutConstraint(item: emailAddressField, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-1/6)*SCREEN_WIDTH)
        self.emailAddressFieldConstraintTop = NSLayoutConstraint(item: emailAddressField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: (1/3)*SCREEN_HEIGHT)
        self.emailAddressFieldConstraintBottom = NSLayoutConstraint(item: emailAddressField, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.emailAddressField, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // Password Field
        self.passwordFieldConstraintLeft = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.emailAddressField, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        self.passwordFieldConstraintRight = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.emailAddressField, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
        self.passwordFieldConstraintTop = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.emailAddressField, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.passwordFieldConstraintBottom = NSLayoutConstraint(item: passwordField, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.passwordField, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // Login Button
        self.loginButtonConstraintLeft = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.emailAddressField, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        self.loginButtonConstraintRight = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.emailAddressField, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
        self.loginButtonConstraintTop = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.passwordField, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.loginButtonConstraintBottom = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.loginButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // Goto Register Button
        self.registerButtonConstraintLeft = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.emailAddressField, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        self.registerButtonConstraintRight = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.emailAddressField, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
        self.registerButtonConstraintTop = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.loginButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.registerButtonConstraintBottom = NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.registerButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // Activate all constraints
        NSLayoutConstraint.activateConstraints([self.emailAddressFieldConstraintLeft, self.emailAddressFieldConstraintRight, self.emailAddressFieldConstraintTop, self.emailAddressFieldConstraintBottom, self.passwordFieldConstraintLeft, self.passwordFieldConstraintRight, self.passwordFieldConstraintTop, self.passwordFieldConstraintBottom, self.loginButtonConstraintLeft, self.loginButtonConstraintRight, self.loginButtonConstraintTop, self.loginButtonConstraintBottom, self.registerButtonConstraintLeft, self.registerButtonConstraintRight, self.registerButtonConstraintTop, self.registerButtonConstraintBottom])
    }
    
    // MARK: - Action Methods
    
    // Goto Register Button Action
    func gotoRegisterButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("toRegisterFromLogin", sender: self)
    }
    
    // Login Button Action
    func loginButtonPressed(sender: UIButton) {
        let emailAddress = self.emailAddressField.text
        let password = self.passwordField.text
        
        self.user.userCallback = self;
        self.user.login(emailAddress, password: password)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "loginSuccessfulSegue" {
            let destinationViewController = TabBarViewController()
            destinationViewController.user = self.user
        }
            
        else if segue.identifier == "toRegisterFromLogin" {
            let destinationViewController = LoginViewController()
            
            // In case user has typed in their info and then realizes they need to login
            destinationViewController.emailAddressField.text = self.emailAddressField.text
            destinationViewController.passwordField.text = self.passwordField.text
        }
    }
    
    // Goto Meal Scene
    func gotoMealScene() {
        self.performSegueWithIdentifier("loginSuccessfulSegue", sender: self)
    }
    
    // MARK: - Text Field Delegate Methods
    
//    func keyboardWillShow(notification: NSNotification) {
//        let info = notification.userInfo!
//        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
//        
//        print("before", self.emailFieldConstraintTop)
//        
//        UIView.animateWithDuration(0.1, animations: { () -> Void in
//            self.emailFieldConstraintTop.constant = keyboardFrame.size.height + 55
//        })
//        
//        print("after", self.emailFieldConstraintTop)
//    }
//    
//    func keyboardWillHide(sender: NSNotification) {
//        let userInfo: [NSObject : AnyObject] = sender.userInfo!
//        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
//        self.view.frame.origin.y += keyboardSize.height
//    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Go from emailField to passwordField
        if (textField == emailAddressField) {
            emailAddressField.resignFirstResponder()
            passwordField.becomeFirstResponder()
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
    
    // MARK: - API Callback
    func loginAccountUserAPICallback(success: Bool, errorMessage: String) {
        if success {
            self.gotoMealScene()
        }
        else {
            let alertView = createAlert("Error", message: errorMessage, actionMessage: "Ok")
            self.presentViewController(alertView, animated: true, completion: nil)
        }
    }
}