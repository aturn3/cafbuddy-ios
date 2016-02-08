//
//  HistoryMealListingCell
//  Caf Buddy
//
//  Copyright (c) 2015 Caf Buddy. All rights reserved.


import Foundation
import UIKit


class HistoryMealListingCell : MealCollectionCellTemplate {
    
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
        
        decorateButtons(mealStatus)
        setMealImage(mealType)
        
        // set up the label that will hold all of the text
        labelMealText.font = UIFont.systemFontOfSize(15)
        labelMealText.textAlignment = NSTextAlignment.Left
        labelMealText.frame = CGRectMake(15, 10, contentView.frame.size.width, contentView.frame.size.height)
        // next two lines allow the label to wrap on the text at a newline character
        labelMealText.lineBreakMode = NSLineBreakMode.ByWordWrapping
        labelMealText.numberOfLines = 0
        
        // these are all the parts of the string that will ultimately be displayed - building up as an array so can bold certain parts and change font sizes
        var totalStringArr = [String]()
        
        // get the meal type string
        totalStringArr.append(MealTypeStrings[mealType.rawValue])
        
        totalStringArr.append("\nwith ")
        
        // get the number of buddies string
        totalStringArr.append(convertIntToWordEquivalent(numBuddies - 1))
        
        if (numBuddies - 1 < 2) { totalStringArr.append(" other buddy\non ") }
        else { totalStringArr.append(" other buddies\non ") }
        
        // get the meal date string
        totalStringArr.append(startTime.toReadableDateOnlyStringShort())
        
        if (mealStatus == MealStatus.UnMatched) {
            totalStringArr.append("\nbetween ")
        }
        else {
            totalStringArr.append("\nat ")
        }
        
        // get the meal start time (if matched) or range (if unmatched)
        totalStringArr.append(startTime.toReadableTimeOnlyString())
        if (mealStatus == MealStatus.UnMatched && endTime != nil) {
            totalStringArr.append(" and ")
            totalStringArr.append(endTime!.toReadableTimeOnlyString())
        }
        
        // first go through once to build up the string
        var totalMealTextString = String()
        for stringPart in totalStringArr {
            totalMealTextString += stringPart
        }
        
        // now initialize the string as all normal font
        let mealText = NSMutableAttributedString(string: totalMealTextString,attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15)])
        var curIndx = 0
        // now go through and bold the appropriate parts of the array
        for (index, stringPart) in totalStringArr.enumerate() {
            // if its a part that should be bolded (odd index of array since starts out with meal type)
            var fontSize = CGFloat(15)
            if (index%2 == 0) {
                if (index == 0) { fontSize = CGFloat(17) }
                mealText.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(fontSize), range: NSRange(location: curIndx, length: stringPart.characters.count))
            }
            curIndx += stringPart.characters.count
        }
        
        // now lets space out the lines a bit more..
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        mealText.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, mealText.length))
        
        labelMealText.attributedText = mealText
        labelMealText.sizeToFit() // resizes the label to as small as possible in upper left of the cell
        
        self.contentView.addSubview(labelMealText)
    }
    
    private func decorateButtons(mealStatus : MealStatus) {
        // in this case there are two buttons
        if (mealStatus == MealStatus.Matched) {
            decorateButton(withIndex: 0, title: "Save The Date", icon: UIImage(named: "addCalendarIcon"))
            decorateButton(withIndex: 1, title: "Chat", icon: UIImage(named: "chatIcon"))
        }
            // in this case there is only one button
        else {
            decorateButton(withIndex: 0, title: "Cancel Plan", color: COLOR_ACCENT_TWO)
            decorateButton(withIndex: 1, title: "Edit Plan", icon: UIImage(named: "timeIcon"))
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
}
