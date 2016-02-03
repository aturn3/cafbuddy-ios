//
//  Utilities.swift
//  CafBuddy
//
//  Created by Andrew Turnblad on 12/27/15.
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import Foundation
import UIKit

// MARK: - String Constants

let APPLICATION_ERROR_OR_NETWORK_PROBLEM = "Servers unavailable. Please try again later"

// MARK: - User Keychain Constants

let USER_FIRST_NAME_KEY = "userFirstName"
let USER_LAST_NAME_KEY = "userLastName"
let USER_EMAIL_ADDRESS_KEY = "userEmailAddress"
let USER_AUTHENTICATION_TOKEN_KEY = "userAuthenticationToken"

// MARK: - Colors

// credit to @Luca Torella and @Mike Milla http://stackoverflow.com/a/33397427
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

let COLOR_MAIN = UIColor(hexString: "#0bbedf")
let COLOR_ACCENT_ONE = UIColor(hexString: "##0bdf96")
let COLOR_NEUTRAL_BACKGROUND = UIColor(hexString: "#eaeaea")

let COLOR_BLACK = UIColor(hexString: "#000000")
let COLOR_WHITE = UIColor(hexString: "#FFFFFF")
let COLOR_RED = UIColor(hexString: "#FF0000")
let COLOR_ORANGE = UIColor(hexString: "#FFA500")
let COLOR_YELLOW = UIColor(hexString: "FFFF00")
let COLOR_GREEN = UIColor(hexString: "#00FF00")
let COLOR_BLUE = UIColor(hexString: "#0000FF")
let COLOR_PURPLE = UIColor(hexString: "#800080")

// MARK: - UI Size Constants

let SCREEN_SIZE = UIScreen.mainScreen().bounds
let SCREEN_WIDTH = SCREEN_SIZE.width
let SCREEN_HEIGHT = SCREEN_SIZE.height
let STATUS_BAR_HEIGHT = 20 as CGFloat
let NAV_BAR_HEIGHT = 44 as CGFloat
let TAB_BAR_HEIGHT = 49 as CGFloat

// MARK: - General Functions

func createAlert(title: String, message: String, actionMessage: String) -> UIAlertController {
    let alertView = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let action = UIAlertAction(title: actionMessage, style: .Default, handler: nil)
    alertView.addAction(action)
    
    return alertView
}

// MARK: - Service Object Methods

func createUserServiceObject() -> GTLServiceUserService? {
    var userServiceObject: GTLServiceUserService? = nil
    if userServiceObject == nil {
        userServiceObject = GTLServiceUserService()
        userServiceObject?.retryEnabled = true
    }
    
    return userServiceObject
}

func createMealServiceObject() -> GTLServiceMealService? {
    var mealServiceObject: GTLServiceMealService? = nil
    if mealServiceObject == nil {
        mealServiceObject = GTLServiceMealService()
        mealServiceObject?.retryEnabled = true
    }
    
    return mealServiceObject
}
