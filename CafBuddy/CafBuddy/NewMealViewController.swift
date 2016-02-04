//
//  NewMealViewController.swift
//  CafBuddy
//
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import UIKit

class NewMealViewController: UIViewController {
    
    // MARK: - Properties
    
    let whenLabel = UILabel()
    
    let newMealButton = UIButton()
    
    var newMealButtonConstraintLeft = NSLayoutConstraint()
    var newMealButtonConstraintRight = NSLayoutConstraint()
    var newMealButtonConstraintTop = NSLayoutConstraint()
    var newMealButtonConstraintBottom = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initInterface()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initInterface() {
        
        
        // New Meal Button
        self.newMealButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        self.newMealButton.setTitle("Create Meal!", forState: UIControlState.Normal)
        self.newMealButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        self.newMealButton.backgroundColor = COLOR_RED
        self.newMealButton.layer.cornerRadius = 10
        self.newMealButton.addTarget(self, action: "newMealButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.newMealButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.newMealButton)
        
        // MARK: - Constraints
        
        // New Meal Button
        self.newMealButtonConstraintLeft = NSLayoutConstraint(item: newMealButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (1/6)*SCREEN_WIDTH)
        self.newMealButtonConstraintRight = NSLayoutConstraint(item: newMealButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-1/6)*SCREEN_WIDTH)
        self.newMealButtonConstraintTop = NSLayoutConstraint(item: newMealButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: (5/6)*SCREEN_HEIGHT)
        self.newMealButtonConstraintBottom = NSLayoutConstraint(item: newMealButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.newMealButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 50.0)
        
        // Activate all constraints
        NSLayoutConstraint.activateConstraints([self.newMealButtonConstraintLeft, self.newMealButtonConstraintRight, self.newMealButtonConstraintTop, self.newMealButtonConstraintBottom])
        
        print("newMealButton:", newMealButton.frame)
    }
}

