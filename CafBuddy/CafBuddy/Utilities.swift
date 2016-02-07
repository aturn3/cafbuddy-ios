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

let COLOR_MAIN = UIColor(hexString: "#0bbedf") // currently an aqua blue color
let COLOR_MAIN_DARK = UIColor(hexString: "#1FB1C3")
let COLOR_ACCENT_ONE = UIColor(hexString: "#0bdf96") // color a green color
let COLOR_ACCENT_ONE_DARK = UIColor(hexString: "#0dd480")
let COLOR_ACCENT_TWO = UIColor(hexString: "#e53b76")//"#DF0B54") // currently a red color

let COLOR_LIGHT_GRAY = UIColor(hexString: "#f4f4f4")
let COLOR_DARK_GRAY = UIColor(hexString: "#e7e7e7")

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
let MAIN_VIEW_HEIGHT = SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NAV_BAR_HEIGHT - TAB_BAR_HEIGHT

// MARK: Image Functions

// modifies the given image to be filled with the given color
func filledImageFrom(source : UIImage, color : UIColor) -> UIImage {
    // begin a new image context, to draw our colored image onto with the right scale
    UIGraphicsBeginImageContextWithOptions(source.size, false, UIScreen.mainScreen().scale)
    // get a reference to that context we created
    let context : CGContextRef = UIGraphicsGetCurrentContext()!
    // set the fill color
    color.setFill()
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, source.size.height)
    CGContextScaleCTM(context, 1.0, -1.0)
    CGContextSetBlendMode(context, CGBlendMode.ColorBurn)
    let rect : CGRect = CGRectMake(0, 0, source.size.width, source.size.height)
    CGContextDrawImage(context, rect, source.CGImage)
    CGContextSetBlendMode(context, CGBlendMode.SourceIn)
    CGContextAddRect(context, rect)
    CGContextDrawPath(context, CGPathDrawingMode.Fill)
    // generate a new UIImage from the graphics context we drew onto
    let coloredImg : UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    //return the color-burned image
    return coloredImg;
}

// creates an image of the specified size as a block of the specified color
func getImageWithColor(color: UIColor, width: CGFloat, height: CGFloat) -> UIImage {
    let rect = CGRectMake(0, 0, width, height)
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}

// credit to @Paul Lynch http://stackoverflow.com/a/2658801/2580204 (converted to swift compatible)
func scaledImage(image : UIImage, scaledToSize newSize:CGSize) -> UIImage {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
    image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext();
    return newImage;
}

// MARK: - General Functions

func createAlert(title: String, message: String, actionMessage: String) -> UIAlertController {
    let alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alertView.addAction(UIAlertAction(title: actionMessage, style: UIAlertActionStyle.Default, handler: nil))
    return alertView
}

func convertIntToWordEquivalent(theNum : Int) -> String {
    let theNumNSNumber = NSNumber(integer: theNum)
    let numberFormatter = NSNumberFormatter()
    numberFormatter.numberStyle = NSNumberFormatterStyle.SpellOutStyle
    return numberFormatter.stringFromNumber(theNumNSNumber)!
}

//MARK: - Extensions Dealing With Dates

extension NSDate {
    // converts it into a string of the format (in UTC instead of local)
    // 'Month Day Year Hour(24):Minute:Second' (e.g. 'January 03 2016 00:43:58') as used by the database
    func toDatabaseString() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        dateFormatter.dateFormat = "MMMM dd yyyy HH:mm:ss"
        return dateFormatter.stringFromDate(self)
    }
    
    // returns a string of the date in database representation
    // but in local time instead of UTC as used by the database
    func toReadableStringInDatabaseRepresentation() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = "MMMM dd yyyy HH:mm:ss"
        return dateFormatter.stringFromDate(self)
    }
    
    // returns a string of only the time in local time in AM/PM form
    // Format: "hour:minute AM/PM" e.g. "2:36 PM"
    func toReadableTimeOnlyString() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.stringFromDate(self)
    }
    
    // returns a string of only the date in local time in short format
    // Format: "Weekday abr, month abr date" if more than a week away or past e.g. "Mon, Feb 15"
    //         "Weekday long" if less than a week away or past e.g. "Monday"
    func toReadableDateOnlyStringShort() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        
        //get a date for a week ago
        let dateComponentsPast = NSDateComponents()
        dateComponentsPast.setValue(-1, forComponent: NSCalendarUnit.WeekOfYear);
        let weekPast = NSCalendar.currentCalendar().dateByAddingComponents(dateComponentsPast, toDate: NSDate(), options:NSCalendarOptions(rawValue: 0))
        
        //get a date for a week in the future
        let dateComponentsFuture = NSDateComponents()
        dateComponentsFuture.setValue(1, forComponent: NSCalendarUnit.WeekOfYear);
        let weekFuture = NSCalendar.currentCalendar().dateByAddingComponents(dateComponentsFuture, toDate: NSDate(), options:NSCalendarOptions(rawValue: 0))
        
        if (self.isBetweenDates(weekPast!, endDate: weekFuture!)) {
            dateFormatter.dateFormat = "EEEE"
        }
        else {
            dateFormatter.dateFormat = "EE, MMM d"
        }
        
        return dateFormatter.stringFromDate(self)
    }
    
    // returns a string of only the date in local time in long format
    // Format: "Weekday, month date year"  if not this year e.g. "Monday, February 15 2017"
    //         "Weekday, month date" if this year e.g. "Monday, February 15"
    func toReadableDateOnlyStringLong() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        
        //get the current year
        dateFormatter.dateFormat = "yyyy"
        let currentYearString = dateFormatter.stringFromDate(NSDate())
        
        //get dates for the beginnig and end of current year
        dateFormatter.dateFormat = "MMMM dd yyyy HH:mm:ss"
        let beginningOfYear = dateFormatter.dateFromString("January 01 " + currentYearString + " 00:00:00")
        let endOfYear = dateFormatter.dateFromString("December 31 " + currentYearString + " 23:59:59")
        
        if (self.isBetweenDates(beginningOfYear!, endDate: endOfYear!)) {
            dateFormatter.dateFormat = "EEE, MMMM d"
        }
        else {
            dateFormatter.dateFormat = "EEEE, MMMM d yyyy"
        }
        
        return dateFormatter.stringFromDate(self)
    }

    func isBetweenDates(beginDate: NSDate, endDate: NSDate) -> Bool {
        if (self.compare(beginDate) == NSComparisonResult.OrderedAscending) {
            return false
        }
        if (self.compare(endDate) == NSComparisonResult.OrderedDescending) {
            return false
        }
        return true
    }
    
    // returns true if the given date comes after the date we are calling this on
    // if the dates are equal, it returns true
    func isBeforeDate(theLaterDate : NSDate) -> Bool {
        return (self.compare(theLaterDate) != NSComparisonResult.OrderedDescending)
    }
}

extension String {
    // converts string of the format 'Month Day Year Hour(24):Minute:Second' (e.g. 'January 03 2016 00:43:58') from the database
    // and converts it to a NSDate in UTC time (just like the database)
    func fromDatabaseStringToNSDate() -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        dateFormatter.dateFormat = "MMMM dd yyyy HH:mm:ss"
        return dateFormatter.dateFromString(self)!
    }
}

func getCurrentTime() -> NSDateComponents {
    // get the current date and time
    let currentDateTime = NSDate()
    
    // get the user's calendar
    let userCalendar = NSCalendar.currentCalendar()
    
    // choose which date and time components are needed
    let requestedComponents: NSCalendarUnit = [
        NSCalendarUnit.Year,
        NSCalendarUnit.Month,
        NSCalendarUnit.Day,
        NSCalendarUnit.Hour,
        NSCalendarUnit.Minute,
        NSCalendarUnit.Second,
        NSCalendarUnit.Nanosecond
    ]
    
    // get the components
    let dateTimeComponents = userCalendar.components(requestedComponents, fromDate: currentDateTime)
    
    return dateTimeComponents
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
