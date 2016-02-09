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
        
        
        //BUTTON THUMBS UP
        // New Meal Button
        buttonThumbsDown.titleLabel!.font = UIFont.systemFontOfSize(24)
        buttonThumbsDown.setTitle("", forState: UIControlState.Normal)
        buttonThumbsDown.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        buttonThumbsDown.backgroundColor = COLOR_RED
        buttonThumbsDown.layer.cornerRadius = 10
        buttonThumbsDown.addTarget(self, action: "thumbsDownButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        
        
        self.view.addSubview(buttonThumbsDown)
        self.view.addSubview(buttonThumbsUp)
        self.view.addSubview(labelMealHeader)
        self.view.addSubview(labelHowWasMeal)
    }
    
    
}