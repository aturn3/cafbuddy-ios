//
//  Meal.swift
//  CafBuddy
//
//  Copyright © 2016 CafBuddy. All rights reserved.
//

import Foundation

protocol MealAPICallback {
    // MARK: - Methods
    
    func getAllUpcomingMealsAPICallback(success: Bool, errorMessage: String, unMatchedMeals: [UnMatchedMeal], matchedMeals: [MatchedMeal]) -> Void
}

extension MealAPICallback {
    func getAllUpcomingMealsAPICallback(success: Bool, errorMessage: String, unMatchedMeals: [UnMatchedMeal], matchedMeals: [MatchedMeal]) -> Void {
        //nothing happens in default implementation
    }
}

enum MealType: String {
    case Breakfast, Lunch, Dinner
}

var firstName = String()
var lastName = String()
var emailAddress = String()
var authenticationToken = String()

var userCallback: UserAPICallback?

class UnMatchedMeal {
    var created : NSDate? //  the date the meal was created
    var startRange : NSDate? // the starting range of when the user is available
    var endRate : NSDate? // the ending range of when the user is available
    var creatorKey : String? // the key for the creator the meal
    var mealType : MealType? // the type of the meal
    var numPeople : Int? // the number of people who are request in the meal (including the creator)
}

class MatchedMeal {
    var matchedDate : NSDate? // the date and time that the meals were matched
    var startTime : NSDate? // the date and time that the meal is supposed to start
    var numPeople : Int? // the number of people attending the meal total
    var mealType : MealType? // the type of the meal
    var peopleKeys = [String]() // the keys of all the people in the meal
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
//                var theUnMatchedMeals = [GTLMealServiceApisMealApiUnMatchedMealMessage]()
//                var theMatchedMeals = [GTLMealServiceApisMealApiMatchedMealMessage]()
                if (response.matchedMeals != nil) {
                    self.convertAPIMatchedMealsArrayToMatchedMealsArray(response.matchedMeals)
                }
                if (response.unMatchedMeals != nil) {
//                    theUnMatchedMeals = response.unMatchedMeals
                }
//
//                self.mealCallback?.getAllUpcomingMealsAPICallback(false, errorMessage: "Success", unMatchedMeals: theUnMatchedMeals, matchedMeals: theMatchedMeals)
            }
                
                // API call unsuccessful
            else if response.errorNumber == -100 {
//                self.mealCallback?.getAllUpcomingMealsAPICallback(false, errorMessage: response.errorMessage, unMatchedMeals: [GTLMealServiceApisMealApiUnMatchedMealMessage](), matchedMeals: [GTLMealServiceApisMealApiMatchedMealMessage]())
            }
                
                // API call unsuccessful
            else {
//                self.mealCallback?.getAllUpcomingMealsAPICallback(false, errorMessage: APPLICATION_ERROR_OR_NETWORK_PROBLEM, unMatchedMeals: [GTLMealServiceApisMealApiUnMatchedMealMessage](), matchedMeals: [GTLMealServiceApisMealApiMatchedMealMessage]())
            }
        })

    }
    
    
    func convertAPIMatchedMealsArrayToMatchedMealsArray(matchedMealsFromAPI: NSArray) -> [MatchedMeal] {
//        for theMatchedMeal in matchedMealsFromAPI {
//            
//        }
        return [MatchedMeal]()
    }
    
    func convertAPIUnMatchedMealsArrayToUnMatchedMealsArray() -> [UnMatchedMeal] {
        return [UnMatchedMeal]()
    }
}