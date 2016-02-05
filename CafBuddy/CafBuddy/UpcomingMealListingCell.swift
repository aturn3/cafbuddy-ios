//
//  MealListingCell.swift
//  Caf Buddy
//
//  Created by Jacob Forster on 2/26/15.
//  Copyright (c) 2015 St. Olaf Acm. All rights reserved.
//
//
//import Foundation
//import UIKit
//


class UpcomingMealListingCell : MealCollectionCellTemplate {
    
    var labelMealText = UILabel()
    
    
    //initializes everything in the cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeButtonsAndImage(2, shouldShowImage: true)
    }
    //just needed to initialize the parent cell
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func initializeUpcomingMealCellContents(mealStatus : MealStatus, mealType : MealType, numBuddies: Int, startTime: NSDate, endTime: NSDate? = nil) {
        self.backgroundColor = COLOR_WHITE
        
        decorateButtons(mealStatus)
        setMealImage(mealType)
    
        // b{Breakfast}
        // with b{1} other person
        // on b{Monday}
        // between b{11:00 AM} and b{12:00 PM}
        
        //this is the string that will ultimately be displayed.. lets build it up from this point
        var totalMealTextString = String()
        
        if (mealType == MealType.Breakfast) {
            totalMealTextString = "Breakfast"
        }
        else if (mealType == MealType.Lunch) {
            totalMealTextString = "Lunch"
        }
        else {
            totalMealTextString = "Dinner"
        }
        
        totalMealTextString += "\nwith "
        
        let numBuddiesNSNumber = NSNumber(integer: numBuddies - 1)
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.SpellOutStyle
        totalMealTextString += numberFormatter.stringFromNumber(numBuddiesNSNumber)!
        
        if (numBuddies - 1 < 2) { totalMealTextString += " other buddy\non" }
        else { totalMealTextString += " other buddies\non" }
        
        totalMealTextString += startTime.toReadableDateOnlyStringShort()
        
        totalMealTextString += "\nbetween "
        
        totalMealTextString += startTime.toReadableTimeOnlyString() + " and " + endTime!.toReadableTimeOnlyString()
        
        
        /*additional meal details needed*/
        labelMealText.font = UIFont.systemFontOfSize(15)
        labelMealText.textAlignment = NSTextAlignment.Left
//        labelMealText.textColor = colorWithHexString()
        labelMealText.frame = CGRectMake(15, 10, contentView.frame.size.width, contentView.frame.size.height)
        labelMealText.lineBreakMode = NSLineBreakMode.ByWordWrapping
        labelMealText.numberOfLines = 0
        
        let mealText = NSMutableAttributedString(string: totalMealTextString,attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15)])
        mealText.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(17), range: NSRange(location: 0, length: 9))

        
        
        labelMealText.attributedText = mealText
        labelMealText.sizeToFit()
//
//        labelMealTime.font = UIFont.systemFontOfSize(15)
//        labelMealTime.textAlignment = NSTextAlignment.Center
        //labelMealType.textColor = colorWithHexString()
//    labelMealTime.frame = CGRectMake(0, labelMealDate.frame.origin.y + labelMealDate.frame.height + 5, contentView.frame.size.width, 20)

        
        self.contentView.addSubview(labelMealText)
//        self.contentView.addSubview(labelMealTime)
//
    }
    
    private func decorateButtons(mealStatus : MealStatus) {
        // in this case there are two buttons
        if (mealStatus == MealStatus.Matched) {
            decorateButton(withIndex: 0, title: "Save The Date", icon: UIImage(named: "addCalendarIcon"))
            decorateButton(withIndex: 1, title: "Chat", icon: UIImage(named: "chatIcon"))
        }
        // in this case there is only one button
        else {
            decorateButton(withIndex: 0, title: "Cancel Meal", color: COLOR_ACCENT_TWO)
            decorateButton(withIndex: 1, title: "Edit Time", icon: UIImage(named: "timeIcon"))
        }
    }
    
    private func setMealImage(theMealType : MealType) {
        if (theMealType == MealType.Dinner) {
            decorateImage(withImage: UIImage(named: "dinnerIcon")!, coloredAs: COLOR_MAIN_DARK)
        }
        else if (theMealType == MealType.Lunch){
            decorateImage(withImage: UIImage(named: "lunchIcon")!, coloredAs: COLOR_MAIN_DARK)
        }
        else {
            decorateImage(withImage: UIImage(named: "breakfastIcon")!, coloredAs: COLOR_MAIN_DARK)
        }
    }
    
//
//    func setMealDetails(theMealType : MealType, theMealStatus : MealStatus) {
//        
//        
//        if (theMealStatus == MealStatus.Confirmed) {
//            
//            buttonFullBottom.hidden = true
//            buttonHalfBottomLeft.hidden = false
//            buttonHalfBottomRight.hidden = false
//            
//            buttonHalfBottomRight.setTitle("Chat W/ Buddy", forState: UIControlState.Normal)
//            buttonHalfBottomRight.setImage(filledImageFrom(UIImage(named: "chat2")!, colorWithHexString(COLOR_ACCENT_GREEN)), forState: UIControlState.Normal)
//            buttonHalfBottomRight.enabled = true
//            
//            buttonHalfBottomLeft.setTitle("Add To Calendar", forState: UIControlState.Normal)
//            buttonHalfBottomLeft.setImage(filledImageFrom(UIImage(named: "addCal")!, colorWithHexString(COLOR_ACCENT_GREEN)), forState: UIControlState.Normal)
//            buttonHalfBottomLeft.enabled = true
//        }
//        else {
//            
//            buttonHalfBottomRight.hidden = true
//            buttonHalfBottomLeft.hidden = true
//            buttonFullBottom.hidden = false
//            
//            //put the searching thing as the full button on the bottom of the screen
//            buttonFullBottom.setTitle("Searching For A Buddy...", forState: UIControlState.Normal)
//            buttonFullBottom.setImage(filledImageFrom(UIImage(named: "buddy")!, colorWithHexString(COLOR_ACCENT_GREEN)), forState: UIControlState.Normal)
//            buttonFullBottom.enabled = false
//        }
//        
//        labelMealDate.text = "Wednesday, September 2nd"
//        labelMealTime.text = "At 3:30 PM"
//    }
//    
//    
//    
}