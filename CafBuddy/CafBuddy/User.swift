//
//  User.swift
//  CafBuddy
//
//  Created by Andrew Turnblad on 1/28/16.
//  Copyright © 2016 CafBuddy. All rights reserved.
//

import Foundation

@objc protocol APICallback {
    // MARK: - Methods
    
    optional func createAccountAPICallback(success: Bool, errorMessage: String)
}

class User: NSObject {
    // MARK: - Properties
    
    var firstName: String? = String()
    var lastName: String? = String()
    var emailAddress: String? = String()
    var authenticationToken: String? = String()
    
    // MARK: - Initializers
    
    override init() {
        self.firstName = nil
        self.lastName = nil
        self.emailAddress = nil
        self.authenticationToken = nil
    }
    
    init(firstAndLastName: String, emailAddress: String, authenticationToken: String) {
        // Extract first name and last name from firstAndLastName
        let fullNameArray = firstAndLastName.componentsSeparatedByString(" ")
        
        self.firstName = fullNameArray[0]
        self.lastName = fullNameArray[1]
        self.emailAddress = emailAddress
        self.authenticationToken = authenticationToken
    }
    
    // MARK: - Methods
    
    func createAccount(firstAndLastName: String, emailAddress: String, password: String) {
        // Build regular expression for emails
        let emailRegularExpressionPattern = "([a-zA-Z0-9]+@[a-zA-Z0-9]+[.][a-zA-Z0-9]+)"
        let emailRegex = try! NSRegularExpression(pattern: emailRegularExpressionPattern, options: [])
        
        // Extract first name and last name from firstAndLastName
        let fullNameArray = firstAndLastName.componentsSeparatedByString(" ")
        let firstName = fullNameArray[0]
        let lastName = fullNameArray[1]
        
        // Check if firstName, lastName, emailAddress, or password is blank
        if firstName.isEmpty || lastName.isEmpty || emailAddress.isEmpty || password.isEmpty {
            
        }
        
        // Check validity of email
        else if emailRegex.numberOfMatchesInString(emailAddress, options: [], range: NSMakeRange(0, emailAddress.characters.count)) == 0 {
            
        }
        
        // Email is valid and password is not blank
        else {
            // Create User Service Object
            let userServiceObject = GTLServiceUserService()
            
            // Create User Service Request Message
            
            let userMessage = GTLUserServiceApisUserApiSignUpUserRequestMessage()
            userMessage.setProperty(emailAddress, forKey: userMessage.emailAddress)
            userMessage.setProperty(firstName, forKey: userMessage.firstName)
            userMessage.setProperty(lastName, forKey: userMessage.lastName)
            userMessage.setProperty(password, forKey: userMessage.password)
            
            // Create User Service Query
            let query = GTLQueryUserService.queryForSignupUserWithObject(userMessage)
            
            // Call API with query
            var ticket = GTLServiceTicket()
            ticket = userServiceObject.executeQuery(query, completionHandler: { (ticket: GTLServiceTicket!, object: AnyObject!, error: NSError!) -> Void in
                
                let response = object as! GTLUserServiceApisUserApiSignUpUserResponseMessage
                
                // Check error number to see if call was successful
                if response.errorNumber == 200 {
                    //
                }

                // API call unsuccessful
                else if response.errorNumber == 12 {
                    
                }
                
                else {
                    
                }
                
            })
        }
    }
}