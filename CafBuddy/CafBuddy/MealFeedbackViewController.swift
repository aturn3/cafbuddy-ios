//
//  MealFeedbackViewController.swift
//  CafBuddy
//
//  Copyright © 2016 CafBuddy. All rights reserved.
//

import UIKit

class MealFeedbackViewController: MainScreenViewController {
    
    var mealToFeedback : MatchedMeal?
    
    var labelMealHeader = UILabel()
    var labelHowWasMeal = UILabel()
    var buttonThumbsUp = UIButton()
    var buttonThumbsDown = UIButton()
    
    var buttonSubmitFeedback = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Set the title of the navigation bar
        navigationItem.title = "Meal Feedback"
        
        initInterface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initInterface() {
        self.view.backgroundColor = COLOR_NEUTRAL_BACKGROUND
        
        
        //LABEL HEADER FOR THE MEAL
        labelMealHeader.textAlignment = NSTextAlignment.Center
        labelMealHeader.frame = CGRectMake(0, NAV_BAR_HEIGHT + STATUS_BAR_HEIGHT + 10, screenSize.width, 50)
        // next two lines allow the label to wrap on the text at a newline character
        labelMealHeader.lineBreakMode = NSLineBreakMode.ByWordWrapping
        labelMealHeader.numberOfLines = 0
      
        // now create the meal header string
        let mealHeaderAttributedString = NSMutableAttributedString(
            string: MealTypeStrings[mealToFeedback!.mealType!.rawValue] + "\n" + mealToFeedback!.startTime!.toReadableDateOnlyStringLong(),
            attributes: [NSFontAttributeName:UIFont.systemFontOfSize(18)]
        )
        mealHeaderAttributedString.addAttribute(
            NSFontAttributeName,
            value: UIFont.boldSystemFontOfSize(23),
            range: NSRange(location: 0, length: MealTypeStrings[mealToFeedback!.mealType!.rawValue].characters.count)
        )
        labelMealHeader.attributedText = mealHeaderAttributedString
        
        
        //LABEL QUESTION HOW WAS IT?
        labelHowWasMeal.textAlignment = NSTextAlignment.Center
        labelHowWasMeal.lineBreakMode = NSLineBreakMode.ByWordWrapping
        labelHowWasMeal.numberOfLines = 0
        labelHowWasMeal.font = UIFont.systemFontOfSize(CGFloat(15))
        labelHowWasMeal.frame = CGRectMake(0, labelMealHeader.frame.maxY + 25, screenSize.width, 50) // height doesn't really matter
//        var howWasMealQuestion = 
//        let curUser = getCurrentUser()
//        for (indx, person) in mealToFeedback!.people.enumerate() {
//            if (!(curUser.firstName == person.firstName && curUser.lastName == person.lastName)) {
//                howWasMealQuestion += person.firstName! + " " + person.lastName!
//                if (indx < mealToFeedback!.people.count - 2) {
//                    howWasMealQuestion += ", "
//                }
//                else if (indx < mealToFeedback!.people.count - 1) {
//                    howWasMealQuestion += " and "
//                }
//            }
//        }
//        howWasMealQuestion += "?"
        labelHowWasMeal.text = "How was your meal?"
        // get the height of the label and then make it full width again
        labelHowWasMeal.sizeToFit()
        labelHowWasMeal.frame = CGRectMake(0, labelHowWasMeal.frame.minY, screenSize.width, labelHowWasMeal.frame.height)
        
        
        let buttonWidth = CGFloat(125)
        let spacingSideButtons = (screenSize.width - CGFloat(buttonWidth * 2)) / CGFloat(3)
        //BUTTON THUMBS UP
        // New Meal Button
//        buttonThumbsDown.titleLabel!.font = UIFont.systemFontOfSize(15)
//        buttonThumbsDown.setTitle("", forState: UIControlState.Normal)
        buttonThumbsDown.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        buttonThumbsDown.backgroundColor = COLOR_MAIN
        buttonThumbsDown.layer.cornerRadius = 3.0
        buttonThumbsDown.addTarget(self, action: "thumbsDownButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonThumbsDown.frame = CGRectMake(spacingSideButtons, labelHowWasMeal.frame.maxY + 5, buttonWidth, 50)
        buttonThumbsDown.setImage(filledImageFrom(UIImage(named: "thumbsDownIcon")!, color: COLOR_WHITE), forState: UIControlState.Normal)
        buttonThumbsDown.tag = 0 // 0 means not clicked.. tag will be used to track
        
        buttonThumbsUp.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        buttonThumbsUp.backgroundColor = COLOR_MAIN
        buttonThumbsUp.layer.cornerRadius = 3.0
        buttonThumbsUp.addTarget(self, action: "thumbsUpButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonThumbsUp.frame = CGRectMake(buttonThumbsDown.frame.maxX + spacingSideButtons, labelHowWasMeal.frame.maxY + 5, buttonWidth, 50)
        buttonThumbsUp.setImage(filledImageFrom(UIImage(named: "thumbsUpIcon")!, color: COLOR_WHITE), forState: UIControlState.Normal)
        buttonThumbsUp.tag = 0 // 0 means not clicked.. tag will be used to track
        
        self.view.addSubview(buttonThumbsDown)
        self.view.addSubview(buttonThumbsUp)
        self.view.addSubview(labelMealHeader)
        self.view.addSubview(labelHowWasMeal)
    }
    
    func thumbsDownButtonPressed(_ : UIButton!) {
        buttonThumbsDown.setImage(filledImageFrom(UIImage(named: "thumbsDownIcon")!, color: COLOR_DARK_GRAY), forState: UIControlState.Normal)
        buttonThumbsUp.setImage(filledImageFrom(UIImage(named: "thumbsUpIcon")!, color: COLOR_WHITE), forState: UIControlState.Normal)
        
        buttonThumbsDown.tag = 1
        buttonThumbsUp.tag = 0
        
//        hideThumbsUpExtras()
//        showThumbsDownExtras()
    }
    
    func thumbsUpButtonPressed(_ : UIButton!) {
        buttonThumbsUp.setImage(filledImageFrom(UIImage(named: "thumbsUpIcon")!, color: COLOR_DARK_GRAY), forState: UIControlState.Normal)
        buttonThumbsDown.setImage(filledImageFrom(UIImage(named: "thumbsDownIcon")!, color: COLOR_WHITE), forState: UIControlState.Normal)
        
        buttonThumbsDown.tag = 0
        buttonThumbsUp.tag = 1
        
//        hideThumbsDownExtras()
//        showThumbsUpExtras()
    }
    
    
}