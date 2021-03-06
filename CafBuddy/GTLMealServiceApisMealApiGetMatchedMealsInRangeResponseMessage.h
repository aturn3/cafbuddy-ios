/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLMealServiceApisMealApiGetMatchedMealsInRangeResponseMessage.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   mealService/v1.0
// Description:
//   API for dealing with meals
// Classes:
//   GTLMealServiceApisMealApiGetMatchedMealsInRangeResponseMessage (0 custom class methods, 3 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLMealServiceApisMealApiMatchedMealMessage;

// ----------------------------------------------------------------------------
//
//   GTLMealServiceApisMealApiGetMatchedMealsInRangeResponseMessage
//

@interface GTLMealServiceApisMealApiGetMatchedMealsInRangeResponseMessage : GTLObject
@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, retain) NSNumber *errorNumber;  // longLongValue
@property (nonatomic, retain) NSArray *matchedMeals;  // of GTLMealServiceApisMealApiMatchedMealMessage
@end
