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
        initializeButtonsAndImage(1, shouldShowImage: true)
    }
    //just needed to initialize the parent cell
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeHistoryMealCellContents(mealType : MealType, people: [MealUser], startTime: NSDate, curUser: User) {
        
        decorateButton(withIndex: 0, title: "Leave Feedback", icon: UIImage(named: "feedbackIcon"))
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

        totalStringArr.append(" on ")

        // get the meal date string
        totalStringArr.append(startTime.toReadableDateOnlyStringLong())

        totalStringArr.append("\nwith ")
        
        // get the number of buddies string
        totalStringArr.append(convertIntToWordEquivalent(people.count - 1))
        if (people.count - 1 < 2) { totalStringArr.append(" other buddy:") }
        else { totalStringArr.append(" other buddies:") }

        var first = true
        for person in people {
            // if the perso is not the actual user themself, then we should display them
            if (!(person.firstName == curUser.firstName && person.lastName == curUser.lastName)) {
                // if its the first person, add a new line, otherwise just add a comma
                if (first){
                    totalStringArr.append("\n" + person.firstName! + " " + person.lastName!)
                    first = false
                }
                else {
                    totalStringArr.append(", " + person.firstName! + " " + person.lastName!)
                }
            }
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
            // if its a part that should be bolded (odd index of array since starts out with meal type) or it is a name, then it should be bolded
            if (index%2 == 0 && index < 6) {
                mealText.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(CGFloat(15)), range: NSRange(location: curIndx, length: stringPart.characters.count))
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
    
//        resizeMealCellToText()
    }
    
    // resize the whole cell based on the amount of space that the text cell takes up
    private func resizeMealCellToText() {
        // 10 is the margin above the text field
        let yValueBottomText = labelMealText.frame.height + 10
//        let heightOfCellAboveButton = self.frame.height - self.buttons[0].frame.height
//        let newHeight = yValueBottomText + 10
        self.frame = CGRectMake(self.frame.minX,self.frame.minY, self.frame.size.width, yValueBottomText + 10 + self.buttons[0].frame.height)
        
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
    
    
    // basically can have a little word in the top left denoting the sections.. split the sections by month and year but only display the year if the month is not in the current year
    // on each cell we can just say Breakfast on January 7th 2016..
    // with NAMES OF ALL THE PEOPLE...
    // no need for times since that is no longer relevant for them
    // have a How did it go? button - this bring you to a new screen where you can have a smiley face or a frowny face
    
}
