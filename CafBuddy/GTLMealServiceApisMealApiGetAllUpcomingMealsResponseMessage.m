/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLMealServiceApisMealApiGetAllUpcomingMealsResponseMessage.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   mealService/v1.0
// Description:
//   API for dealing with meals
// Classes:
//   GTLMealServiceApisMealApiGetAllUpcomingMealsResponseMessage (0 custom class methods, 4 custom properties)

#import "GTLMealServiceApisMealApiGetAllUpcomingMealsResponseMessage.h"

#import "GTLMealServiceApisMealApiMatchedMealMessage.h"
#import "GTLMealServiceApisMealApiUnMatchedMealMessage.h"

// ----------------------------------------------------------------------------
//
//   GTLMealServiceApisMealApiGetAllUpcomingMealsResponseMessage
//

@implementation GTLMealServiceApisMealApiGetAllUpcomingMealsResponseMessage
@dynamic errorMessage, errorNumber, matchedMeals, unMatchedMeals;

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map = @{
    @"matchedMeals" : [GTLMealServiceApisMealApiMatchedMealMessage class],
    @"unMatchedMeals" : [GTLMealServiceApisMealApiUnMatchedMealMessage class]
  };
  return map;
}

@end
