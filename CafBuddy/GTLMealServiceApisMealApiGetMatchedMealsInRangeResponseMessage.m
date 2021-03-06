/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLMealServiceApisMealApiGetMatchedMealsInRangeResponseMessage.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   mealService/v1.0
// Description:
//   API for dealing with meals
// Classes:
//   GTLMealServiceApisMealApiGetMatchedMealsInRangeResponseMessage (0 custom class methods, 3 custom properties)

#import "GTLMealServiceApisMealApiGetMatchedMealsInRangeResponseMessage.h"

#import "GTLMealServiceApisMealApiMatchedMealMessage.h"

// ----------------------------------------------------------------------------
//
//   GTLMealServiceApisMealApiGetMatchedMealsInRangeResponseMessage
//

@implementation GTLMealServiceApisMealApiGetMatchedMealsInRangeResponseMessage
@dynamic errorMessage, errorNumber, matchedMeals;

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map = @{
    @"matchedMeals" : [GTLMealServiceApisMealApiMatchedMealMessage class]
  };
  return map;
}

@end
