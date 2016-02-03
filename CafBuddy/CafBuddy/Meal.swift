//
//  Meal.swift
//  CafBuddy
//
//  Copyright © 2016 CafBuddy. All rights reserved.
//

import Foundation

@objc protocol MealAPICallback {
    // MARK: - Methods
    
    optional func getAllUpcomingMealsAPICallback(success: Bool, errorMessage: String, unMatchedMeals: [GTLMealServiceApisMealApiUnMatchedMealMessage], matchedMeals: [GTLMealServiceApisMealApiMatchedMealMessage]) -> Void
}

class UnMatchedMeal {
}

class MatchedMeal {
    
}

class Meal: NSObject {
    // MARK: - Properties
    
    
    var mealCallback: MealAPICallback?
    
    // MARK: - Initializers
    
    override init() {}
    
    // MARK: - Methods
    
    func getAllUpcomingMeals(emailAddress: String, authToken: String) {
        // Create Meal Service Object
        let mealServiceObject = createMealServiceObject()
        
        // Create User Service Request Message
        let mealMessage = GTLMealServiceApisMealApiGetAllUpcomingMealsRequestMessage()
        mealMessage.emailAddress = emailAddress
        mealMessage.authToken = authToken
        
        // Create User Service Query
        let query: GTLQueryMealService = GTLQueryMealService.queryForGetAllUpcomingMealsWithObject(mealMessage)
        
        // Call API with query
        mealServiceObject!.executeQuery(query, completionHandler: { (ticket: GTLServiceTicket!, object: AnyObject!, error: NSError!) -> Void in
            
            let response: GTLMealServiceApisMealApiGetAllUpcomingMealsResponseMessage = object as! GTLMealServiceApisMealApiGetAllUpcomingMealsResponseMessage
            
            // API call successful
            if response.errorNumber == 200 {
                //test if either of the lists are nil (means they are empty) and actually make them empty arrays if so
                var theUnMatchedMeals = [GTLMealServiceApisMealApiUnMatchedMealMessage]()
                var theMatchedMeals = [GTLMealServiceApisMealApiMatchedMealMessage]()
                if (response.matchedMeals != nil) {
                    self.convertAPIMatchedMealsArrayToMatchedMealsArray(response.matchedMeals)
                }
                if (response.unMatchedMeals != nil) {
//                    theUnMatchedMeals = response.unMatchedMeals
                }
                
                self.mealCallback?.getAllUpcomingMealsAPICallback?(false, errorMessage: "Success", unMatchedMeals: theUnMatchedMeals, matchedMeals: theMatchedMeals)
            }
                
                // API call unsuccessful
            else if response.errorNumber == -100 {
                self.mealCallback?.getAllUpcomingMealsAPICallback?(false, errorMessage: response.errorMessage, unMatchedMeals: [GTLMealServiceApisMealApiUnMatchedMealMessage](), matchedMeals: [GTLMealServiceApisMealApiMatchedMealMessage]())
            }
                
                // API call unsuccessful
            else {
                self.mealCallback?.getAllUpcomingMealsAPICallback?(false, errorMessage: APPLICATION_ERROR_OR_NETWORK_PROBLEM, unMatchedMeals: [GTLMealServiceApisMealApiUnMatchedMealMessage](), matchedMeals: [GTLMealServiceApisMealApiMatchedMealMessage]())
            }
        })

    }
    
    
    func convertAPIMatchedMealsArrayToMatchedMealsArray(matchedMealsFromAPI: NSArray) -> [MatchedMeal] {
        for theMatchedMeal in matchedMealsFromAPI {
            print(theMatchedMeal.startTime)
        }
        return [MatchedMeal]()
    }
    
    func convertAPIUnMatchedMealsArrayToUnMatchedMealsArray() -> [UnMatchedMeal] {
        return [UnMatchedMeal]()
    }
}