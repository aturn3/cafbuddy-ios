/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2015 Google Inc.
 */

//
//  GTLServiceUserService.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   userService/v1.011
// Description:
//   API for working with a User
// Classes:
//   GTLServiceUserService (0 custom class methods, 0 custom properties)

#import "GTLUserService.h"

@implementation GTLServiceUserService

#if DEBUG
// Method compiled in debug builds just to check that all the needed support
// classes are present at link time.
+ (NSArray *)checkClasses {
  NSArray *classes = @[
    [GTLQueryUserService class],
    [GTLUserServiceApisUserApiLogInUserRequestMessage class],
    [GTLUserServiceApisUserApiLogInUserResponseMessage class],
    [GTLUserServiceApisUserApiLogOutUserRequestMessage class],
    [GTLUserServiceApisUserApiLogOutUserResponseMessage class],
    [GTLUserServiceApisUserApiSendNewEmailVerificationRequestMessage class],
    [GTLUserServiceApisUserApiSendNewEmailVerificationResponseMessage class],
    [GTLUserServiceApisUserApiSignUpUserRequestMessage class],
    [GTLUserServiceApisUserApiSignUpUserResponseMessage class],
    [GTLUserServiceApisUserApiValidateUserRequestMessage class],
    [GTLUserServiceApisUserApiValidateUserResponseMessage class]
  ];
  return classes;
}
#endif  // DEBUG

- (instancetype)init {
  self = [super init];
  if (self) {
    // Version from discovery.
    self.apiVersion = @"v1.011";

    // From discovery.  Where to send JSON-RPC.
    // Turn off prettyPrint for this service to save bandwidth (especially on
    // mobile). The fetcher logging will pretty print.
    self.rpcURL = [NSURL URLWithString:@"https://cafbuddy.appspot.com/_ah/api/rpc?prettyPrint=false"];
  }
  return self;
}

@end