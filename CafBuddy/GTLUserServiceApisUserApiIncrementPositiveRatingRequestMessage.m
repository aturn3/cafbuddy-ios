/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLUserServiceApisUserApiIncrementPositiveRatingRequestMessage.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   userService/v1.0
// Description:
//   API for working with a User
// Classes:
//   GTLUserServiceApisUserApiIncrementPositiveRatingRequestMessage (0 custom class methods, 5 custom properties)

#import "GTLUserServiceApisUserApiIncrementPositiveRatingRequestMessage.h"

// ----------------------------------------------------------------------------
//
//   GTLUserServiceApisUserApiIncrementPositiveRatingRequestMessage
//

@implementation GTLUserServiceApisUserApiIncrementPositiveRatingRequestMessage
@dynamic authToken, emailAddress, fromUserKey, mealKey, userKeys;

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map = @{
    @"userKeys" : [NSString class]
  };
  return map;
}

@end
