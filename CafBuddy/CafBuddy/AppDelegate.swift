//
//  AppDelegate.swift
//  CafBuddy
//
//  Created by Andrew Turnblad on 12/26/15.
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate { //GCMReceiverDelegate, GGLInstanceIDDelegate {

    var window: UIWindow?
    
    var gcmSenderID: String?
    var registrationToken: String?
    var registrationOptions = [String: AnyObject]()
    
    let registrationKey = "onRegistrationCompleted"
    let messageKey = "onMessageReceived"

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //set the text and icon color of the tab bar
        UITabBar.appearance().tintColor = COLOR_MAIN
        
        //set the text color of the navbar
        UINavigationBar.appearance().tintColor = COLOR_WHITE
        
        
        // Configure the Google context: parses the GoogleService-Info.plist, and initializes
        // the services that have entries in the file
//        var configureError:NSError?
//        GGLContext.sharedInstance().configureWithError(&configureError)
//        assert(configureError == nil, "Error configuring Google services: \(configureError)")
//        gcmSenderID = GGLContext.sharedInstance().configuration.gcmSenderID
//        // Register for remote notifications - this only works for iOS 8.0 or above so can never drop below that target
//        let settings: UIUserNotificationSettings =
//        UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
//        application.registerUserNotificationSettings(settings)
//        application.registerForRemoteNotifications()
//        // [END register_for_remote_notifications]
//        // [START start_gcm_service]
//        let gcmConfig = GCMConfig.defaultConfig()
//        gcmConfig.receiverDelegate = self
//        GCMService.sharedInstance().startWithConfig(gcmConfig)
        // [END start_gcm_service]
        return true
    }
//    
//    func application( application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData ) {
//            // [END receive_apns_token]
//            // [START get_gcm_reg_token]
//            // Create a config and set a delegate that implements the GGLInstaceIDDelegate protocol.
//            let instanceIDConfig = GGLInstanceIDConfig.defaultConfig()
//            instanceIDConfig.delegate = self
//            // Start the GGLInstanceID shared instance with that config and request a registration
//            // token to enable reception of notifications
//            GGLInstanceID.sharedInstance().startWithConfig(instanceIDConfig)
//            registrationOptions = [kGGLInstanceIDRegisterAPNSOption:deviceToken,
//                kGGLInstanceIDAPNSServerTypeSandboxOption:true]
//            GGLInstanceID.sharedInstance().tokenWithAuthorizedEntity(gcmSenderID,
//                scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: registrationHandler)
//            // [END get_gcm_reg_token]
//    }
    
    
    // need to change this..
//    func registrationHandler(registrationToken: String!, error: NSError!) {
//        if (registrationToken != nil) {
//            self.registrationToken = registrationToken
//            print("Registration Token: \(registrationToken)")
////            self.subscribeToTopic()
//            let userInfo = ["registrationToken": registrationToken]
//            NSNotificationCenter.defaultCenter().postNotificationName(
//                self.registrationKey, object: nil, userInfo: userInfo)
//        } else {
//            print("Registration to GCM failed with error: \(error.localizedDescription)")
//            let userInfo = ["error": error.localizedDescription]
//            NSNotificationCenter.defaultCenter().postNotificationName(
//                self.registrationKey, object: nil, userInfo: userInfo)
//        }
//    }
    
//    func onTokenRefresh() {
//        // A rotation of the registration tokens is happening, so the app needs to request a new token.
//        print("The GCM registration token needs to be changed.")
//        GGLInstanceID.sharedInstance().tokenWithAuthorizedEntity(gcmSenderID,
//            scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: registrationHandler)
//    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

