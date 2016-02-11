/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLMealServiceApisMealApiMatchedMealMessage.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   mealService/v1.0
// Description:
//   API for dealing with meals
// Classes:
//   GTLMealServiceApisMealApiMatchedMealMessage (0 custom class methods, 6 custom properties)

#import "GTLMealServiceApisMealApiMatchedMealMessage.h"

#import "GTLMealServiceApisMealApiUserMessage.h"

// ----------------------------------------------------------------------------
//
//   GTLMealServiceApisMealApiMatchedMealMessage
//

@implementation GTLMealServiceApisMealApiMatchedMealMessage
@dynamic matchedDate, mealKey, mealType, numPeople, people, startTime;

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map = @{
    @"people" : [GTLMealServiceApisMealApiUserMessage class]
  };
  return map;
}

@end
