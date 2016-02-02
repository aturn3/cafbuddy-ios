/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLMealServiceApisMealApiUnMatchedMealMessage.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   mealService/v1.0
// Description:
//   API for dealing with meals
// Classes:
//   GTLMealServiceApisMealApiUnMatchedMealMessage (0 custom class methods, 6 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLMealServiceApisMealApiUnMatchedMealMessage
//

@interface GTLMealServiceApisMealApiUnMatchedMealMessage : GTLObject
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *creatorKey;
@property (nonatomic, copy) NSString *endRange;
@property (nonatomic, retain) NSNumber *mealType;  // longLongValue
@property (nonatomic, retain) NSNumber *numPeople;  // longLongValue
@property (nonatomic, copy) NSString *startRange;
@end
