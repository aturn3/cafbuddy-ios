//
//  User.swift
//  CafBuddy
//
//  Copyright © 2016 CafBuddy. All rights reserved.
//

import Foundation
import Locksmith

protocol UserAPICallback {
    // MARK: - Methods
    
    func createAccountUserAPICallback(success: Bool, errorMessage: String) -> Void
    func loginAccountUserAPICallback(success: Bool, errorMessage: String) -> Void
}

extension UserAPICallback {
    func createAccountUserAPICallback(success: Bool, errorMessage: String) -> Void {
        // Default implementation
    }
    func loginAccountUserAPICallback(success: Bool, errorMessage: String) -> Void {
        // Default implementation
    }
}

class User: NSObject {
    // MARK: - Properties
    
    var firstName = String()
    var lastName = String()
    var emailAddress = String()
    var authenticationToken = String()
    
    var userCallback: UserAPICallback?
    
    // MARK: - Initializers
    
    override init() {}
    
    init(firstName: String, lastName: String, emailAddress: String, authenticationToken: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.authenticationToken = authenticationToken
    }
    
    // MARK: - Methods
    
    func isLoggedIn() -> Bool {
        // Check if user is saved as logged in
        if NSUserDefaults.standardUserDefaults().boolForKey("isLoggedIn") {
            return true
        }
        else {
            return false
        }
    }
    
    func loadUserFromKeychain() {
        let firstNameDictionary = Locksmith.loadDataForUserAccount(USER_FIRST_NAME_KEY)
        let lastNameDictionary = Locksmith.loadDataForUserAccount(USER_LAST_NAME_KEY)
        let emailAddressDictionary = Locksmith.loadDataForUserAccount(USER_EMAIL_ADDRESS_KEY)
        let authenticationTokenDictionary = Locksmith.loadDataForUserAccount(USER_AUTHENTICATION_TOKEN_KEY)
        
        if firstNameDictionary != nil && lastNameDictionary != nil && emailAddressDictionary != nil && authenticationTokenDictionary != nil {
            self.firstName = firstNameDictionary?[USER_FIRST_NAME_KEY] as! String
            self.lastName = lastNameDictionary?[USER_LAST_NAME_KEY] as! String
            self.emailAddress = emailAddressDictionary?[USER_EMAIL_ADDRESS_KEY] as! String
            self.authenticationToken = authenticationTokenDictionary?[USER_AUTHENTICATION_TOKEN_KEY] as! String
        }
    }
    
    func deleteUserFromKeychain() {
        do {
            try Locksmith.deleteDataForUserAccount(USER_FIRST_NAME_KEY)
            try Locksmith.deleteDataForUserAccount(USER_LAST_NAME_KEY)
            try Locksmith.deleteDataForUserAccount(USER_EMAIL_ADDRESS_KEY)
            try Locksmith.deleteDataForUserAccount(USER_AUTHENTICATION_TOKEN_KEY)
        } catch _ {
            // this is where it could fail.. do something on failure
        }
    }
    
    func createAccount(firstAndLastName: String!, emailAddress: String!, password: String!) {
        // Build regular expression for emails
        let emailRegularExpressionPattern = "([a-zA-Z0-9]+@[a-zA-Z0-9]+[.][a-zA-Z0-9]+)"
        let emailRegex = try! NSRegularExpression(pattern: emailRegularExpressionPattern, options: [])
        
        // Extract first name and last name from firstAndLastName
        let fullNameArray = firstAndLastName.componentsSeparatedByString(" ")
        let firstName = fullNameArray[0]
        let lastName = fullNameArray.count > 1 ? fullNameArray[1] : String()
        
        // Check if firstName, lastName, emailAddress, or password is blank
        if firstName.isEmpty || lastName.isEmpty {
            self.userCallback?.createAccountUserAPICallback(false, errorMessage: "Please enter a first and last name")
        }
            
        else if emailAddress.isEmpty || password.isEmpty {
            self.userCallback?.createAccountUserAPICallback(false, errorMessage: "All fields are required")
        }
        
        // Check validity of email
        else if emailRegex.numberOfMatchesInString(emailAddress, options: [], range: NSMakeRange(0, emailAddress.characters.count)) == 0 {
            self.userCallback?.createAccountUserAPICallback(false, errorMessage: "Please enter a valid email address")
        }
        
        // Email is valid and password is not blank
        else {
            // Create User Service Object
            let userServiceObject = createUserServiceObject()
            
            // Create User Service Request Message
            let userMessage = GTLUserServiceApisUserApiSignUpUserRequestMessage()
            userMessage.emailAddress = emailAddress
            userMessage.firstName = firstName
            userMessage.lastName = lastName
            userMessage.password = password
            
            // Create User Service Query
            let query: GTLQueryUserService = GTLQueryUserService.queryForSignupUserWithObject(userMessage)
            
            // Call API with query
            //var ticket = GTLServiceTicket()
            userServiceObject!.executeQuery(query, completionHandler: { (ticket: GTLServiceTicket!, object: AnyObject!, error: NSError!) -> Void in
                
                let response: GTLUserServiceApisUserApiSignUpUserResponseMessage = object as! GTLUserServiceApisUserApiSignUpUserResponseMessage
                
                // API call successful
                if response.errorNumber == 200 {
                    // Store username and authenticationToken in keychain
                    do {
                        try Locksmith.updateData([USER_FIRST_NAME_KEY: firstName], forUserAccount: USER_FIRST_NAME_KEY)
                        try Locksmith.updateData([USER_LAST_NAME_KEY: lastName], forUserAccount: USER_LAST_NAME_KEY)
                        try Locksmith.updateData([USER_EMAIL_ADDRESS_KEY: emailAddress], forUserAccount: USER_EMAIL_ADDRESS_KEY)
                        try Locksmith.updateData([USER_AUTHENTICATION_TOKEN_KEY: response.authToken], forUserAccount: USER_AUTHENTICATION_TOKEN_KEY)
                    } catch _ {
                        // this is where it could fail.. do something on failure
                    }
                    
                    // Save user as logged in
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isLoggedIn")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    // Store emailAddress and authenticationToken in User object
                    self.emailAddress = emailAddress
                    self.authenticationToken = response.authToken
                    
                    self.userCallback?.createAccountUserAPICallback(true, errorMessage: "Succcessfully registered! Please confirm your registration via email.")
                }

                // API call unsuccessful
                else if response.errorNumber == -2 {
                    self.userCallback?.createAccountUserAPICallback(false, errorMessage: response.errorMessage)
                }
                
                // API call unsuccessful
                else if response.errorNumber == -3 {
                    self.userCallback?.createAccountUserAPICallback(false, errorMessage: response.errorMessage)
                }
                
                // API call unsuccessful
                else if response.errorNumber == -4 {
                    self.userCallback?.createAccountUserAPICallback(false, errorMessage: response.errorMessage)
                }
                
                // API call unsuccessful
                else {
                    self.userCallback?.createAccountUserAPICallback(false, errorMessage: APPLICATION_ERROR_OR_NETWORK_PROBLEM)
                }
            })
        }
    }
    
    func login(emailAddress: String!, password: String!) {
        // Build regular expression for emails
        let emailRegularExpressionPattern = "([a-zA-Z0-9]+@[a-zA-Z0-9]+[.][a-zA-Z0-9]+)"
        let emailRegex = try! NSRegularExpression(pattern: emailRegularExpressionPattern, options: [])
            
        if emailAddress.isEmpty || password.isEmpty {
            self.userCallback?.loginAccountUserAPICallback(false, errorMessage: "All fields are required")
        }
            
        // Check validity of email
        else if emailRegex.numberOfMatchesInString(emailAddress, options: [], range: NSMakeRange(0, emailAddress.characters.count)) == 0 {
            self.userCallback?.loginAccountUserAPICallback(false, errorMessage: "Please enter a valid email address")
        }
            
        // Email is valid and password is not blank
        else {
            // Create User Service Object
            let userServiceObject = createUserServiceObject()
            
            // Create User Service Request Message
            let userMessage = GTLUserServiceApisUserApiLogInUserRequestMessage()
            userMessage.emailAddress = emailAddress
            userMessage.password = password
            
            // Create User Service Query
            let query: GTLQueryUserService = GTLQueryUserService.queryForLoginUserWithObject(userMessage)
            
            // Call API with query
            //var ticket = GTLServiceTicket()
            userServiceObject!.executeQuery(query, completionHandler: { (ticket: GTLServiceTicket!, object: AnyObject!, error: NSError!) -> Void in
                
                let response: GTLUserServiceApisUserApiLogInUserResponseMessage = object as! GTLUserServiceApisUserApiLogInUserResponseMessage
                
                // API call successful
                if response.errorNumber == 200 {
                    // Store username and authenticationToken in keychain
                    do {
                        try Locksmith.updateData([USER_FIRST_NAME_KEY: response.firstName], forUserAccount: USER_FIRST_NAME_KEY)
                        try Locksmith.updateData([USER_LAST_NAME_KEY: response.lastName], forUserAccount: USER_LAST_NAME_KEY)
                        try Locksmith.updateData([USER_EMAIL_ADDRESS_KEY: emailAddress], forUserAccount: USER_EMAIL_ADDRESS_KEY)
                        try Locksmith.updateData([USER_AUTHENTICATION_TOKEN_KEY: response.authToken], forUserAccount: USER_AUTHENTICATION_TOKEN_KEY)
                    } catch _ {
                        // this is where it could fail.. do something on failure
                    }
                    
                    // Save user as logged in
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isLoggedIn")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    // Store emailAddress and authenticationToken in User object
                    self.emailAddress = emailAddress
                    self.authenticationToken = response.authToken
                    
                    self.userCallback?.loginAccountUserAPICallback(true, errorMessage: "Login successful")
                }
                    
                // API call unsuccessful
                else if response.errorNumber == -1 {
                    self.userCallback?.loginAccountUserAPICallback(false, errorMessage: response.errorMessage)
                }
                    
                // API call unsuccessful
                else if response.errorNumber == -3 {
                    self.userCallback?.loginAccountUserAPICallback(false, errorMessage: response.errorMessage)
                }
                    
                // API call unsuccessful
                else {
                    self.userCallback?.loginAccountUserAPICallback(false, errorMessage: APPLICATION_ERROR_OR_NETWORK_PROBLEM)
                }
            })
        }
    }
    
    func logout() {
        // Save user as logged out
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isLoggedIn")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}