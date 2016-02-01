//
//  User.swift
//  CafBuddy
//
//  Created by Andrew Turnblad on 1/28/16.
//  Copyright © 2016 CafBuddy. All rights reserved.
//

import Foundation

class User: NSObject {
    // MARK: - Properties
    
    var firstName = NSString()
    var lastName = NSString()
    var email = NSString()
    var authenticationToken = NSString()
    
    // MARK: - Methods
    
    init(firstName: NSString, lastName: NSString, email: NSString, authenticationToken: NSString) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.authenticationToken = authenticationToken
    }
    
    func createAccount(firstAndLastName: NSString, email: NSString, password: NSString) {
        // Build regular expression for emails
        let emailRegularExpressionPattern = "([a-zA-Z0-9]+@[a-zA-Z0-9]+[.][a-zA-Z0-9]+)"
        let emailRegex = try! NSRegularExpression(pattern: emailRegularExpressionPattern, options: [])
        
        // Extract first name and last name from firstAndLastName
        let nameRegularExpressionPattern = "([a-zA-Z]+)"
        let nameRegex = try! NSRegularExpression(pattern: nameRegularExpressionPattern, options: [])
        let firstName = NSString()
        let lastName = NSString()
        
        // Check if either email or password is blank
        if email.length == 0 || password.length == 0 {
            
        }
        
        // Check validity of email
        else if emailRegex.numberOfMatchesInString(email as String, options: [], range: NSMakeRange(0, email.length)) == 0 {
            
        }
        
        // Email is valid and password is not blank
        else {
            // Create User Service Object
            let userServiceObject = GTLServiceUserService()
            
            // Create User Service Request Message
            
            let userMessage = GTLUserServiceApisUserApiSignUpUserRequestMessage()
            userMessage.setProperty(email, forKey: userMessage.emailAddress)
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