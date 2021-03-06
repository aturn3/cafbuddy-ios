/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLQueryUserService.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   userService/v1.0
// Description:
//   API for working with a User
// Classes:
//   GTLQueryUserService (11 custom class methods, 1 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLQuery.h"
#else
  #import "GTLQuery.h"
#endif

@class GTLUserServiceApisUserApiAddComplimentRequestMessage;
@class GTLUserServiceApisUserApiAddReportToUserRequestMessage;
@class GTLUserServiceApisUserApiGetComplimentsGivenByUserRequestMessage;
@class GTLUserServiceApisUserApiGetComplimentsGivenToUserRequestMessage;
@class GTLUserServiceApisUserApiIncrementNegativeRatingRequestMessage;
@class GTLUserServiceApisUserApiIncrementPositiveRatingRequestMessage;
@class GTLUserServiceApisUserApiLogInUserRequestMessage;
@class GTLUserServiceApisUserApiLogOutUserRequestMessage;
@class GTLUserServiceApisUserApiSendNewEmailVerificationRequestMessage;
@class GTLUserServiceApisUserApiSignUpUserRequestMessage;
@class GTLUserServiceApisUserApiValidateUserRequestMessage;

@interface GTLQueryUserService : GTLQuery

//
// Parameters valid on all methods.
//

// Selector specifying which fields to include in a partial response.
@property (nonatomic, copy) NSString *fields;

#pragma mark - Service level methods
// These create a GTLQueryUserService object.

// Method: userService.addCompliment
//  Authorization scope(s):
//   kGTLAuthScopeUserServiceUserinfoEmail
// Fetches a GTLUserServiceApisUserApiAddComplimentResponseMessage.
+ (instancetype)queryForAddComplimentWithObject:(GTLUserServiceApisUserApiAddComplimentRequestMessage *)object;

// Method: userService.addReportToUser
//  Authorization scope(s):
//   kGTLAuthScopeUserServiceUserinfoEmail
// Fetches a GTLUserServiceApisUserApiAddReportToUserResponseMessage.
+ (instancetype)queryForAddReportToUserWithObject:(GTLUserServiceApisUserApiAddReportToUserRequestMessage *)object;

// Method: userService.getComplimentsGivenByUser
//  Authorization scope(s):
//   kGTLAuthScopeUserServiceUserinfoEmail
// Fetches a GTLUserServiceApisUserApiGetComplimentsGivenByUserResponseMessage.
+ (instancetype)queryForGetComplimentsGivenByUserWithObject:(GTLUserServiceApisUserApiGetComplimentsGivenByUserRequestMessage *)object;

// Method: userService.getComplimentsGivenToUser
//  Authorization scope(s):
//   kGTLAuthScopeUserServiceUserinfoEmail
// Fetches a GTLUserServiceApisUserApiGetComplimentsGivenToUserResponseMessage.
+ (instancetype)queryForGetComplimentsGivenToUserWithObject:(GTLUserServiceApisUserApiGetComplimentsGivenToUserRequestMessage *)object;

// Method: userService.incrementNegativeRating
//  Authorization scope(s):
//   kGTLAuthScopeUserServiceUserinfoEmail
// Fetches a GTLUserServiceApisUserApiIncrementNegativeRatingResponseMessage.
+ (instancetype)queryForIncrementNegativeRatingWithObject:(GTLUserServiceApisUserApiIncrementNegativeRatingRequestMessage *)object;

// Method: userService.incrementPositiveRating
//  Authorization scope(s):
//   kGTLAuthScopeUserServiceUserinfoEmail
// Fetches a GTLUserServiceApisUserApiIncrementPositiveRatingResponseMessage.
+ (instancetype)queryForIncrementPositiveRatingWithObject:(GTLUserServiceApisUserApiIncrementPositiveRatingRequestMessage *)object;

// Method: userService.loginUser
//  Authorization scope(s):
//   kGTLAuthScopeUserServiceUserinfoEmail
// Fetches a GTLUserServiceApisUserApiLogInUserResponseMessage.
+ (instancetype)queryForLoginUserWithObject:(GTLUserServiceApisUserApiLogInUserRequestMessage *)object;

// Method: userService.logoutUser
//  Authorization scope(s):
//   kGTLAuthScopeUserServiceUserinfoEmail
// Fetches a GTLUserServiceApisUserApiLogOutUserResponseMessage.
+ (instancetype)queryForLogoutUserWithObject:(GTLUserServiceApisUserApiLogOutUserRequestMessage *)object;

// Method: userService.sendNewEmailVerification
//  Authorization scope(s):
//   kGTLAuthScopeUserServiceUserinfoEmail
// Fetches a GTLUserServiceApisUserApiSendNewEmailVerificationResponseMessage.
+ (instancetype)queryForSendNewEmailVerificationWithObject:(GTLUserServiceApisUserApiSendNewEmailVerificationRequestMessage *)object;

// Method: userService.signupUser
//  Authorization scope(s):
//   kGTLAuthScopeUserServiceUserinfoEmail
// Fetches a GTLUserServiceApisUserApiSignUpUserResponseMessage.
+ (instancetype)queryForSignupUserWithObject:(GTLUserServiceApisUserApiSignUpUserRequestMessage *)object;

// Method: userService.validateUser
//  Authorization scope(s):
//   kGTLAuthScopeUserServiceUserinfoEmail
// Fetches a GTLUserServiceApisUserApiValidateUserResponseMessage.
+ (instancetype)queryForValidateUserWithObject:(GTLUserServiceApisUserApiValidateUserRequestMessage *)object;

@end
