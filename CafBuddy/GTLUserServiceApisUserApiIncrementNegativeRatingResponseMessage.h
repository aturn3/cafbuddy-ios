/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLUserServiceApisUserApiIncrementNegativeRatingResponseMessage.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   userService/v1.0
// Description:
//   API for working with a User
// Classes:
//   GTLUserServiceApisUserApiIncrementNegativeRatingResponseMessage (0 custom class methods, 2 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLUserServiceApisUserApiIncrementNegativeRatingResponseMessage
//

@interface GTLUserServiceApisUserApiIncrementNegativeRatingResponseMessage : GTLObject
@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, retain) NSNumber *errorNumber;  // longLongValue
@end
