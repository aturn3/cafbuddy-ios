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
    func deleteUnMatchedMealAPICallback(success: Bool, errorMessage: String, mealKeyDeleted: String) -> Void
    func createMealAPICallback(success: Bool, errorMessage: String) -> Void
    func getMatchedMealsInRangeAPICallback(success: Bool, errorMessage: String, matchedMeals: [MatchedMeal]) -> Void
}

extension MealAPICallback {
    func getAllUpcomingMealsAPICallback(success: Bool, errorMessage: String, unMatchedMeals: [UnMatchedMeal], matchedMeals: [MatchedMeal]) -> Void {
        //nothing happens in default implementation
    }
    func deleteUnMatchedMealAPICallback(success: Bool, errorMessage: String, mealKeyDeleted: String) -> Void {
        //nothing happens in default implmentation
    }
    func createMealAPICallback(success: Bool, errorMessage: String) -> Void {
        // Default implementation
    }
    func getMatchedMealsInRangeAPICallback(success: Bool, errorMessage: String, matchedMeals: [MatchedMeal]) -> Void {
        // Default implementation
    }
}

enum MealType: Int {
    case Breakfast = 0, Lunch = 1, Dinner = 2, Coffee = 3
}
let MealTypeStrings = ["Breakfast", "Lunch", "Dinner", "Coffee"]

enum MealStatus: Int {
    case Matched = 0, UnMatched = 1
}

var firstName = String()
var lastName = String()
var emailAddress = String()
var authenticationToken = String()

var userCallback: UserAPICallback?

class UnMatchedMeal {
    var created : NSDate? //  the date the meal was created
    var startRange : NSDate? // the starting range of when the user is available
    var endRange : NSDate? // the ending range of when the user is available
    var creatorKey : String? // the key for the creator the meal
    var mealType : MealType? // the type of the meal
    var numPeople : Int? // the number of people who are request in the meal (including the creator)
    var mealKey : String? // the unique identifier of the UnMatchedMeal in the backend database
}

class MatchedMeal {
    var matchedDate : NSDate? // the date and time that the meals were matched
    var startTime : NSDate? // the date and time that the meal is supposed to start
    var numPeople : Int? // the number of people attending the meal total
    var mealType : MealType? // the type of the meal
    var people = [MealUser]() // the keys / names of all the people in the meal
    var mealKey : String? // the unique identifier of the MatchedMeal in the backend database
}

class MealUser { // modified user with only limited information abou the user as returned in the meal API
    var userKey : String? // the key of the user in the database
    var firstName : String? // the first name of the user
    var lastName : String? // the last name of the user
}

class Meal: NSObject {
    // MARK: - Properties
    
    
    var mealCallback: MealAPICallback?
    
    // MARK: - Initializers
    
    override init() {}
    
    // MARK: - API Call Methods
    
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
                var theUnMatchedMeals = [UnMatchedMeal]()
                var theMatchedMeals = [MatchedMeal]()
                if (response.matchedMeals != nil) {
                    theMatchedMeals = self.convertAPIMatchedMealsArrayToClientMatchedMealsArray(response.matchedMeals)
                }
                if (response.unMatchedMeals != nil) {
                    theUnMatchedMeals = self.convertAPIUnMatchedMealsArrayToClientUnMatchedMealsArray(response.unMatchedMeals)
                }

                self.mealCallback?.getAllUpcomingMealsAPICallback(true, errorMessage: "Success", unMatchedMeals: theUnMatchedMeals, matchedMeals: theMatchedMeals)
            }
                
                // API call unsuccessful
            else if response.errorNumber == -100 {
                self.mealCallback?.getAllUpcomingMealsAPICallback(false, errorMessage: response.errorMessage, unMatchedMeals: [UnMatchedMeal](), matchedMeals: [MatchedMeal]())
            }
                
                // API call unsuccessful
            else {
                self.mealCallback?.getAllUpcomingMealsAPICallback(false, errorMessage: APPLICATION_ERROR_OR_NETWORK_PROBLEM, unMatchedMeals: [UnMatchedMeal](), matchedMeals: [MatchedMeal]())
            }
        })

    }
    
    func getMatchedMealsInRange(emailAddress: String, authToken: String, startRange: NSDate, endRange: NSDate) {
        // Create Meal Service Object
        let mealServiceObject = createMealServiceObject()
        
        //first, just do a quick sanity check
        if (endRange.isBeforeDate(startRange)) {
            self.mealCallback?.getMatchedMealsInRangeAPICallback(false, errorMessage: "The end range can not be before the start range.", matchedMeals: [MatchedMeal]())
        }
        
        // Create User Service Request Message
        let mealMessage = GTLMealServiceApisMealApiGetMatchedMealsInRangeRequestMessage()
        mealMessage.emailAddress = emailAddress
        mealMessage.authToken = authToken
        mealMessage.startRange = startRange.toDatabaseString()
        mealMessage.endRange = endRange.toDatabaseString()
        
        // Create User Service Query
        let query: GTLQueryMealService = GTLQueryMealService.queryForGetMatchedMealsInRangeWithObject(mealMessage)
        
        // Call API with query
        mealServiceObject!.executeQuery(query, completionHandler: { (ticket: GTLServiceTicket!, object: AnyObject!, error: NSError!) -> Void in
            
            let response: GTLMealServiceApisMealApiGetMatchedMealsInRangeResponseMessage = object as! GTLMealServiceApisMealApiGetMatchedMealsInRangeResponseMessage
            
            // API call successful
            if response.errorNumber == 200 {
                //test if the matched meals are nil (means there were no meals in that range)
                var theMatchedMeals = [MatchedMeal]()
                if (response.matchedMeals != nil) {
                    theMatchedMeals = self.convertAPIMatchedMealsArrayToClientMatchedMealsArray(response.matchedMeals)
                }
                
                self.mealCallback?.getMatchedMealsInRangeAPICallback(true, errorMessage: "Success", matchedMeals: theMatchedMeals)
            }
                
                // API call unsuccessful
            else if (response.errorNumber == -100 || response.errorNumber == -5) {
                self.mealCallback?.getMatchedMealsInRangeAPICallback(false, errorMessage: response.errorMessage, matchedMeals: [MatchedMeal]())
            }
                
                // API call unsuccessful
            else {
                self.mealCallback?.getMatchedMealsInRangeAPICallback(false, errorMessage: APPLICATION_ERROR_OR_NETWORK_PROBLEM, matchedMeals: [MatchedMeal]())
            }
        })

    }
    
    func deleteUnMatchedMeal(emailAddress: String, authToken: String, mealKey: String) {
        // Create Meal Service Object
        let mealServiceObject = createMealServiceObject()
        
        // Create User Service Request Message
        let mealMessage = GTLMealServiceApisMealApiDeleteUnMatchedMealRequestMessage()
        mealMessage.emailAddress = emailAddress
        mealMessage.authToken = authToken
        if (mealKey.characters.count > 0) {
            mealMessage.mealKey = mealKey
        }
        
        // Create User Service Query
        let query: GTLQueryMealService = GTLQueryMealService.queryForDeleteUnMatchedMealWithObject(mealMessage)
        
        // Call API with query
        mealServiceObject!.executeQuery(query, completionHandler: { (ticket: GTLServiceTicket!, object: AnyObject!, error: NSError!) -> Void in
            
            let response: GTLMealServiceApisMealApiDeleteUnMatchedMealResponseMessage = object as! GTLMealServiceApisMealApiDeleteUnMatchedMealResponseMessage
            
            // API call successful
            if response.errorNumber == 200 {
                self.mealCallback?.deleteUnMatchedMealAPICallback(true, errorMessage: "Success", mealKeyDeleted: mealKey)
            }
                
                // API call unsuccessful
            else if (response.errorNumber == -100) {
                self.mealCallback?.deleteUnMatchedMealAPICallback(false, errorMessage: response.errorMessage, mealKeyDeleted: "")
            }
                
                // API call unsuccessful
            else {
                self.mealCallback?.deleteUnMatchedMealAPICallback(false, errorMessage: APPLICATION_ERROR_OR_NETWORK_PROBLEM, mealKeyDeleted: "")
            }
        })

    }
    
    func createMeal(emailAddress: String, authenticationToken: String, day: NSDate, startRange: NSDate, endRange: NSDate, numberOfPeople: Int) {
        var startRange = startRange
        var endRange = endRange
        
        // Change day of startRange and endRange based on day chosen for meal
        let chosenDay = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: day)
        let startRangeDay = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: startRange)
        let dayDifference = chosenDay.day - startRangeDay.day
        
        startRange = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: dayDifference, toDate: startRange, options: NSCalendarOptions(rawValue: 0))!
        endRange = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: dayDifference, toDate: endRange, options: NSCalendarOptions(rawValue: 0))!
        
        // Account for user in total number of people for the meal
        let numberOfPeopleTotal = numberOfPeople + 1
        
        // Get Meal Type
        let endDateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: endRange)
        var mealType = MealType(rawValue: 0)
        
        if endDateComponents.minute < 11 {
            mealType = MealType.Breakfast
        }
        else if endDateComponents.minute > 11 && endDateComponents.minute < 16 {
            mealType = MealType.Lunch
        }
        else {
            // Dinner
            mealType = MealType.Dinner
        }
        
        // Create Meal Service Object
        let mealServiceObject = createMealServiceObject()
        
        // Create User Service Request Message
        let mealObject = GTLMealServiceApisMealApiCreateNewMealRequestMessage()
        mealObject.emailAddress = emailAddress
        mealObject.authToken = authenticationToken
        mealObject.mealType = mealType?.rawValue
        mealObject.startRange = startRange.toDatabaseString()
        mealObject.endRange = endRange.toDatabaseString()
        mealObject.numPeople = numberOfPeopleTotal
        
        // Create Meal Service Query
        let query: GTLQueryMealService = GTLQueryMealService.queryForCreateNewMealWithObject(mealObject)
        
        // Call API with query
        mealServiceObject!.executeQuery(query, completionHandler: { (ticket: GTLServiceTicket!, object: AnyObject!, error: NSError!) -> Void in
            
            let response: GTLMealServiceApisMealApiCreateNewMealResponseMessage = object as! GTLMealServiceApisMealApiCreateNewMealResponseMessage
            
            // API call successful
            if response.errorNumber == 200 {
                self.mealCallback?.createMealAPICallback(true, errorMessage: "Meal created!")
            }
                
            // API call unsuccessful
            else if response.errorNumber == -1 || response.errorNumber == -3 {
                self.mealCallback?.createMealAPICallback(false, errorMessage: response.errorMessage)
            }
                
            // API call unsuccessful
            else {
                self.mealCallback?.createMealAPICallback(false, errorMessage: APPLICATION_ERROR_OR_NETWORK_PROBLEM)
            }
        })
    }
    
    
    // MARK: - Helper Methods
    
    func convertAPIMatchedMealsArrayToClientMatchedMealsArray(matchedMealsAPI: NSArray) -> [MatchedMeal] {
        var matchedMeals = [MatchedMeal]()
        for theMatchedMeal in matchedMealsAPI {
            matchedMeals.append(convertAPIMatchedMealToClientMatchedMeal(theMatchedMeal as! GTLMealServiceApisMealApiMatchedMealMessage))
        }
        return matchedMeals
    }

    func convertAPIUnMatchedMealsArrayToClientUnMatchedMealsArray(unMatchedMealsAPI: NSArray) -> [UnMatchedMeal] {
        var unMatchedMeals = [UnMatchedMeal]()
        for theUnMatchedMeal in unMatchedMealsAPI {
            unMatchedMeals.append(convertAPIUnMatchedMealToClientUnMatchedMeal(theUnMatchedMeal as! GTLMealServiceApisMealApiUnMatchedMealMessage))
        }
        return unMatchedMeals
    }
    
    func convertAPIMatchedMealToClientMatchedMeal(matchedMealAPI : GTLMealServiceApisMealApiMatchedMealMessage) -> MatchedMeal {
        let theMatchedMeal = MatchedMeal()
        theMatchedMeal.matchedDate = matchedMealAPI.matchedDate?.fromDatabaseStringToNSDate()
        theMatchedMeal.startTime = matchedMealAPI.startTime?.fromDatabaseStringToNSDate()
        theMatchedMeal.numPeople = matchedMealAPI.numPeople as Int
        theMatchedMeal.mealType = MealType(rawValue: matchedMealAPI.mealType as Int)
        theMatchedMeal.mealKey = matchedMealAPI.mealKey

        var mealUsers = [MealUser]()
        for userMessage in matchedMealAPI.people {
            let theUserMessage = userMessage as! GTLMealServiceApisMealApiUserMessage
            let theMealUser = MealUser()
            if (userMessage.userKey != nil) { theMealUser.userKey = theUserMessage.userKey }
            if (userMessage.firstName != nil) { theMealUser.firstName = theUserMessage.firstName }
            if (userMessage.lastName != nil) { theMealUser.lastName = theUserMessage.lastName }
            mealUsers.append(theMealUser)
        }
        theMatchedMeal.people = mealUsers
        
        return theMatchedMeal
    }
    
    func convertAPIUnMatchedMealToClientUnMatchedMeal(unMatchedMealApi : GTLMealServiceApisMealApiUnMatchedMealMessage) -> UnMatchedMeal {
        let theUnMatchedMeal = UnMatchedMeal()
        theUnMatchedMeal.created = unMatchedMealApi.created?.fromDatabaseStringToNSDate()
        theUnMatchedMeal.startRange = unMatchedMealApi.startRange?.fromDatabaseStringToNSDate()
        theUnMatchedMeal.endRange = unMatchedMealApi.endRange?.fromDatabaseStringToNSDate()
        theUnMatchedMeal.numPeople = unMatchedMealApi.numPeople as Int
        theUnMatchedMeal.creatorKey = unMatchedMealApi.creatorKey
        theUnMatchedMeal.mealType = MealType(rawValue: unMatchedMealApi.mealType as Int)
        theUnMatchedMeal.mealKey = unMatchedMealApi.mealKey
        return theUnMatchedMeal
    }
}