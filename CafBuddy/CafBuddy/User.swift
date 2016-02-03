//
//  User.swift
//  CafBuddy
//
//  Created by Andrew Turnblad on 1/28/16.
//  Copyright © 2016 CafBuddy. All rights reserved.
//

import Foundation
import Locksmith

@objc protocol APICallback {
    // MARK: - Methods
    
    optional func createAccountAPICallback(success: Bool, errorMessage: String) -> Void
    optional func loginAccountAPICallback(success: Bool, errorMessage: String) -> Void
}

class User: NSObject {
    // MARK: - Properties
    
    var firstName = String()
    var lastName = String()
    var emailAddress = String()
    var authenticationToken = String()
    
    var userCallback: APICallback?
    
    // MARK: - Initializers
    
    override init() {}
    
    init(firstAndLastName: String, emailAddress: String, authenticationToken: String) {
        // Extract first name and last name from firstAndLastName
        let fullNameArray = firstAndLastName.componentsSeparatedByString(" ")
        
        self.firstName = fullNameArray[0]
        self.lastName = fullNameArray[1]
        self.emailAddress = emailAddress
        self.authenticationToken = authenticationToken
    }
    
    // MARK: - Methods
    
    func createAccount(firstAndLastName: String!, emailAddress: String!, password: String!) {
        // Build regular expression for emails
        let emailRegularExpressionPattern = "([a-zA-Z0-9]+@[a-zA-Z0-9]+[.][a-zA-Z0-9]+)"
        let emailRegex = try! NSRegularExpression(pattern: emailRegularExpressionPattern, options: [])
        
        // Extract first name and last name from firstAndLastName
        let fullNameArray = firstAndLastName.componentsSeparatedByString(" ")
        let firstName = fullNameArray[0]
        let lastName = fullNameArray[1]
        
        // Check if firstName, lastName, emailAddress, or password is blank
        if firstName.isEmpty || lastName.isEmpty {
            self.userCallback?.createAccountAPICallback?(false, errorMessage: "Please enter a first and last name")
        }
            
        else if emailAddress.isEmpty || password.isEmpty {
            self.userCallback?.createAccountAPICallback?(false, errorMessage: "All fields are required")
        }
        
        // Check validity of email
        else if emailRegex.numberOfMatchesInString(emailAddress, options: [], range: NSMakeRange(0, emailAddress.characters.count)) == 0 {
            self.userCallback?.createAccountAPICallback?(false, errorMessage: "Please enter a valid email address")
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
            userServiceObject!.executeQuery(query, completionHandler: { (ticket: GTLServiceTicket!, object: AnyObject!, error: NSError!) -> Void in
                
                let response: GTLUserServiceApisUserApiSignUpUserResponseMessage = object as! GTLUserServiceApisUserApiSignUpUserResponseMessage
                
                // API call successful
                if response.errorNumber == 200 {
                    // Store username and authenticationToken in keychain
                    do {
                        try Locksmith.updateData(["userEmailAddress": emailAddress], forUserAccount: USER_ACCOUNT)
                        try Locksmith.updateData(["userAuthenticationToken": response.authToken], forUserAccount: USER_ACCOUNT)
                    } catch _ {
                        // this is where it could fail.. do something on failure
                    }
                    
                    // Store emailAddress and authenticationToken in User object
                    self.emailAddress = emailAddress
                    self.authenticationToken = response.authToken
                    
                    self.userCallback?.createAccountAPICallback?(false, errorMessage: "Succcessfully registered! Please confirm your registration via email.")
                }

                // API call unsuccessful
                else if response.errorNumber == -2 {
                    self.userCallback?.createAccountAPICallback?(false, errorMessage: response.errorMessage)
                }
                
                // API call unsuccessful
                else if response.errorNumber == -3 {
                    self.userCallback?.createAccountAPICallback?(false, errorMessage: response.errorMessage)
                }
                
                // API call unsuccessful
                else if response.errorNumber == -4 {
                    self.userCallback?.createAccountAPICallback?(false, errorMessage: response.errorMessage)
                }
                
                // API call unsuccessful
                else {
                    self.userCallback?.createAccountAPICallback?(false, errorMessage: APPLICATION_ERROR_OR_NETWORK_PROBLEM)
                }
            })
        }
    }
    
    func login(emailAddress: String!, password: String!) {
        
    }
}