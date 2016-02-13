//
//  NewMealViewController.swift
//  CafBuddy
//
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import UIKit

class NewMealViewController: MainScreenViewController, MealAPICallback, UIPickerViewDataSource,UIPickerViewDelegate {
    
    // MARK: - Properties
    
    var meal = Meal()
    
    let howManyPeoplePickerData = ["1", "3", "5"]
    
    var mealType = MealType(rawValue: 0)
    
    let mealTypeLabel = UILabel()
    let mealTypeFoodButton = UIButton()
    let mealTypeCoffeeButton = UIButton()
    let whenLabel = UILabel()
    let whenTextField = UITextField()
    let whenDatePicker = UIDatePicker()
    let whatTimeLabel = UILabel()
    let andLabel = UILabel()
    let startTimeTextField = UITextField()
    let endTimeTextField = UITextField()
    let startTimePicker = UIDatePicker()
    let endTimePicker = UIDatePicker()
    let howManyPeopleLabel = UILabel()
    let howManyPeopleTextField = UITextField()
    let howManyPeoplePicker = UIPickerView()
    let newMealButton = UIButton()
    
    var mealTypeLabelConstraintCenterX = NSLayoutConstraint()
    var mealTypeLabelConstraintTop = NSLayoutConstraint()
    
    var mealTypeFoodButtonConstraintLeft = NSLayoutConstraint()
    var mealTypeFoodButtonConstraintRight = NSLayoutConstraint()
    var mealTypeFoodButtonConstraintTop = NSLayoutConstraint()
    var mealTypeFoodButtonConstraintBottom = NSLayoutConstraint()
    
    var mealTypeCoffeeButtonConstraintLeft = NSLayoutConstraint()
    var mealTypeCoffeeButtonConstraintRight = NSLayoutConstraint()
    var mealTypeCoffeeButtonConstraintTop = NSLayoutConstraint()
    var mealTypeCoffeeButtonConstraintBottom = NSLayoutConstraint()
    
    var whenLabelConstraintCenterX = NSLayoutConstraint()
    var whenLabelConstraintTop = NSLayoutConstraint()
    
    var whenTextFieldConstraintCenterX = NSLayoutConstraint()
    var whenTextFieldConstraintLeft = NSLayoutConstraint()
    var whenTextFieldConstraintRight = NSLayoutConstraint()
    var whenTextFieldConstraintTop = NSLayoutConstraint()
    var whenTextFieldConstraintBottom = NSLayoutConstraint()
    
    var whatTimeLabelConstraintCenterX = NSLayoutConstraint()
    var whatTimeLabelConstraintTop = NSLayoutConstraint()
    
    var andLabelConstraintCenterX = NSLayoutConstraint()
    var andLabelConstraintCenterY = NSLayoutConstraint()

    var startTimeTextFieldConstraintLeft = NSLayoutConstraint()
    var startTimeTextFieldConstraintRight = NSLayoutConstraint()
    var startTimeTextFieldConstraintTop = NSLayoutConstraint()
    var startTimeTextFieldConstraintBottom = NSLayoutConstraint()
    var startTimeTextFieldConstraintCenterY = NSLayoutConstraint()
    
    var endTimeTextFieldConstraintLeft = NSLayoutConstraint()
    var endTimeTextFieldConstraintRight = NSLayoutConstraint()
    var endTimeTextFieldConstraintTop = NSLayoutConstraint()
    var endTimeTextFieldConstraintBottom = NSLayoutConstraint()
    var endTimeTextFieldConstraintCenterY = NSLayoutConstraint()
    
    var howManyPeopleLabelConstraintCenterX = NSLayoutConstraint()
    var howManyPeopleLabelConstraintTop = NSLayoutConstraint()
    
    var howManyPeopleTextFieldConstraintCenterX = NSLayoutConstraint()
    var howManyPeopleTextFieldConstraintLeft = NSLayoutConstraint()
    var howManyPeopleTextFieldConstraintRight = NSLayoutConstraint()
    var howManyPeopleTextFieldConstraintTop = NSLayoutConstraint()
    var howManyPeopleTextFieldConstraintBottom = NSLayoutConstraint()
    
    var newMealButtonConstraintLeft = NSLayoutConstraint()
    var newMealButtonConstraintRight = NSLayoutConstraint()
    var newMealButtonConstraintTop = NSLayoutConstraint()
    var newMealButtonConstraintBottom = NSLayoutConstraint()
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the navigation bar title
        navigationItem.title = "Create A Meal"
        
        self.initInterface()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initInterface() {
        
        self.view.backgroundColor = COLOR_NEUTRAL_BACKGROUND
        
        // Meal Type Label
        self.mealTypeLabel.font = UIFont.systemFontOfSize(16)
        self.mealTypeLabel.textAlignment = NSTextAlignment.Center
        self.mealTypeLabel.text = "Meal type?"
        self.mealTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.mealTypeLabel)
        
        // Meal Type Food Button
        self.mealTypeFoodButton.titleLabel!.font = UIFont.systemFontOfSize(16)
        self.mealTypeFoodButton.setTitle("Food", forState: UIControlState.Normal)
        self.mealTypeFoodButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        self.mealTypeFoodButton.backgroundColor = COLOR_WHITE
        self.mealTypeFoodButton.layer.cornerRadius = 10
        self.mealTypeFoodButton.addTarget(self, action: "mealTypeButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.mealTypeFoodButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.mealTypeFoodButton)
        
        // Meal Type Coffee Button
        self.mealTypeCoffeeButton.titleLabel!.font = UIFont.systemFontOfSize(16)
        self.mealTypeCoffeeButton.setTitle("Coffee", forState: UIControlState.Normal)
        self.mealTypeCoffeeButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        self.mealTypeCoffeeButton.backgroundColor = COLOR_WHITE
        self.mealTypeCoffeeButton.layer.cornerRadius = 10
        self.mealTypeCoffeeButton.addTarget(self, action: "mealTypeButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.mealTypeCoffeeButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.mealTypeCoffeeButton)
        
        // When Label
        self.whenLabel.font = UIFont.systemFontOfSize(16)
        self.whenLabel.textAlignment = NSTextAlignment.Center
        self.whenLabel.text = "When?"
        self.whenLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.whenLabel)
        
        // When Date Picker
        self.whenDatePicker.timeZone = nil // User local time
        self.whenDatePicker.datePickerMode = UIDatePickerMode.Date
        self.whenDatePicker.minimumDate = getMinimumDay()
        self.whenDatePicker.date = self.whenDatePicker.minimumDate!
        self.whenDatePicker.maximumDate = getMaximumDay()
        self.whenDatePicker.addTarget(self, action: Selector("whenDatePickerValueChanged"), forControlEvents: UIControlEvents.ValueChanged)
        
        // When Text Field
        self.whenTextField.text = self.whenDatePicker.date.toReadableDateOnlyStringLong()
        self.whenTextField.textAlignment = NSTextAlignment.Center
        self.whenTextField.font = UIFont.systemFontOfSize(16)
        self.whenTextField.borderStyle = UITextBorderStyle.RoundedRect
        self.whenTextField.inputView = self.whenDatePicker
        self.whenTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.whenTextField)
        
        // What Time Label
        self.whatTimeLabel.font = UIFont.systemFontOfSize(16)
        self.whatTimeLabel.textAlignment = NSTextAlignment.Center
        self.whatTimeLabel.text = "Start meal between"
        self.whatTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.whatTimeLabel)
        
        // And Label
        self.andLabel.font = UIFont.systemFontOfSize(16)
        self.andLabel.textAlignment = NSTextAlignment.Center
        self.andLabel.text = "and"
        self.andLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.andLabel)
        
        // Start Time Picker
        self.startTimePicker.timeZone = nil // User local time
        self.startTimePicker.datePickerMode = UIDatePickerMode.Time
        self.startTimePicker.minuteInterval = 5
        self.startTimePicker.date = getMinimumDate(self.startTimePicker)
        self.startTimePicker.addTarget(self, action: Selector("whatTimeDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        // End Time Picker
        self.endTimePicker.timeZone = nil // User local time
        self.endTimePicker.datePickerMode = UIDatePickerMode.Time
        self.endTimePicker.minuteInterval = 5
        self.endTimePicker.date = getMaximumDate(self.endTimePicker)
        self.endTimePicker.addTarget(self, action: Selector("whatTimeDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        // Set minimum and maximum dates for Start and End Time Pickers after their dates have been set
        self.startTimePicker.minimumDate = getMinimumDate(self.startTimePicker)
        self.startTimePicker.maximumDate = getMaximumDate(self.startTimePicker)
        self.endTimePicker.minimumDate = getMinimumDate(self.endTimePicker)
        self.endTimePicker.maximumDate = getMaximumDate(self.endTimePicker)
        
        // Start Time Text Field
        self.startTimeTextField.text = self.startTimePicker.date.toReadableTimeOnlyString()
        self.startTimeTextField.textAlignment = NSTextAlignment.Center
        self.startTimeTextField.font = UIFont.systemFontOfSize(16)
        self.startTimeTextField.borderStyle = UITextBorderStyle.RoundedRect
        self.startTimeTextField.inputView = self.startTimePicker
        self.startTimeTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.startTimeTextField)
        
        // End Time Text Field
        self.endTimeTextField.text = self.endTimePicker.date.toReadableTimeOnlyString()
        self.endTimeTextField.textAlignment = NSTextAlignment.Center
        self.endTimeTextField.font = UIFont.systemFontOfSize(16)
        self.endTimeTextField.borderStyle = UITextBorderStyle.RoundedRect
        self.endTimeTextField.inputView = self.endTimePicker
        self.endTimeTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.endTimeTextField)
        
        // How Many People Label
        self.howManyPeopleLabel.font = UIFont.systemFontOfSize(16)
        self.howManyPeopleLabel.textAlignment = NSTextAlignment.Center
        self.howManyPeopleLabel.text = "With how many other people?"
        self.howManyPeopleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.howManyPeopleLabel)
        
        // How Many People Picker
        self.howManyPeoplePicker.dataSource = self
        self.howManyPeoplePicker.delegate = self
        
        // How Many People Text Field
        self.howManyPeopleTextField.text = self.howManyPeoplePickerData[self.howManyPeoplePicker.selectedRowInComponent(0)]
        self.howManyPeopleTextField.textAlignment = NSTextAlignment.Center
        self.howManyPeopleTextField.font = UIFont.systemFontOfSize(16)
        self.howManyPeopleTextField.borderStyle = UITextBorderStyle.RoundedRect
        self.howManyPeopleTextField.inputView = self.howManyPeoplePicker
        self.howManyPeopleTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.howManyPeopleTextField)
        
        // New Meal Button
        self.newMealButton.titleLabel!.font = UIFont.systemFontOfSize(16)
        self.newMealButton.setTitle("Create Meal!", forState: UIControlState.Normal)
        self.newMealButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        self.newMealButton.backgroundColor = COLOR_RED
        self.newMealButton.layer.cornerRadius = 10
        self.newMealButton.addTarget(self, action: "newMealButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.newMealButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.newMealButton)
        
        // MARK: - Constraints
        
        // Meal Type Label
        self.mealTypeLabelConstraintCenterX = NSLayoutConstraint(item: self.mealTypeLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.mealTypeLabelConstraintTop = NSLayoutConstraint(item: self.mealTypeLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: (1/50)*MAIN_VIEW_HEIGHT)
        
        // Meal Type Food Button
        self.mealTypeFoodButtonConstraintLeft = NSLayoutConstraint(item: self.mealTypeFoodButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (1/16)*SCREEN_WIDTH)
        self.mealTypeFoodButtonConstraintRight = NSLayoutConstraint(item: self.mealTypeFoodButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-9/16)*SCREEN_WIDTH)
        self.mealTypeFoodButtonConstraintTop = NSLayoutConstraint(item: self.mealTypeFoodButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.mealTypeLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.mealTypeFoodButtonConstraintBottom = NSLayoutConstraint(item: self.mealTypeFoodButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.mealTypeFoodButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // Meal Type Coffee Button
        self.mealTypeCoffeeButtonConstraintLeft = NSLayoutConstraint(item: self.mealTypeCoffeeButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (9/16)*SCREEN_WIDTH)
        self.mealTypeCoffeeButtonConstraintRight = NSLayoutConstraint(item: self.mealTypeCoffeeButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-1/16)*SCREEN_WIDTH)
        self.mealTypeCoffeeButtonConstraintTop = NSLayoutConstraint(item: self.mealTypeCoffeeButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.mealTypeFoodButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
        self.mealTypeCoffeeButtonConstraintBottom = NSLayoutConstraint(item: self.mealTypeCoffeeButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.mealTypeFoodButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
        
        // When Label
        self.whenLabelConstraintCenterX = NSLayoutConstraint(item: self.whenLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.whenLabelConstraintTop = NSLayoutConstraint(item: self.whenLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.mealTypeFoodButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        
        // When Text Field
        self.whenTextFieldConstraintCenterX = NSLayoutConstraint(item: self.whenTextField, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.whenTextFieldConstraintLeft = NSLayoutConstraint(item: self.whenTextField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (1/16)*SCREEN_WIDTH)
        self.whenTextFieldConstraintRight = NSLayoutConstraint(item: self.whenTextField, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-1/16)*SCREEN_WIDTH)
        self.whenTextFieldConstraintTop = NSLayoutConstraint(item: self.whenTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.whenLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.whenTextFieldConstraintBottom = NSLayoutConstraint(item: self.whenTextField, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.whenTextField, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // What Time Label
        self.whatTimeLabelConstraintCenterX = NSLayoutConstraint(item: self.whatTimeLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.whenLabel, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.whatTimeLabelConstraintTop = NSLayoutConstraint(item: self.whatTimeLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.whenTextField, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        
        // And Label
        self.andLabelConstraintCenterX = NSLayoutConstraint(item: self.andLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.andLabelConstraintCenterY = NSLayoutConstraint(item: self.andLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.startTimeTextField, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
        
        // Start Time Text Field
        self.startTimeTextFieldConstraintLeft = NSLayoutConstraint(item: self.startTimeTextField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (1/16)*SCREEN_WIDTH)
        self.startTimeTextFieldConstraintRight = NSLayoutConstraint(item: self.startTimeTextField, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-9/16)*SCREEN_WIDTH)
        self.startTimeTextFieldConstraintTop = NSLayoutConstraint(item: self.startTimeTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.whatTimeLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.startTimeTextFieldConstraintBottom = NSLayoutConstraint(item: self.startTimeTextField, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.startTimeTextField, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // End Time Text Field
        self.endTimeTextFieldConstraintLeft = NSLayoutConstraint(item: self.endTimeTextField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (9/16)*SCREEN_WIDTH)
        self.endTimeTextFieldConstraintRight = NSLayoutConstraint(item: self.endTimeTextField, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-1/16)*SCREEN_WIDTH)
        self.endTimeTextFieldConstraintBottom = NSLayoutConstraint(item: self.endTimeTextField, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.endTimeTextField, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        self.endTimeTextFieldConstraintCenterY = NSLayoutConstraint(item: self.endTimeTextField, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.startTimeTextField, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
        
        // How Many People Label
        self.howManyPeopleLabelConstraintCenterX = NSLayoutConstraint(item: self.howManyPeopleLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.howManyPeopleLabelConstraintTop = NSLayoutConstraint(item: self.howManyPeopleLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.startTimeTextField, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        
        // How Many People Text Field
        self.howManyPeopleTextFieldConstraintCenterX = NSLayoutConstraint(item: self.howManyPeopleTextField, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.howManyPeopleTextFieldConstraintLeft = NSLayoutConstraint(item: self.howManyPeopleTextField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (1/16)*SCREEN_WIDTH)
        self.howManyPeopleTextFieldConstraintRight = NSLayoutConstraint(item: self.howManyPeopleTextField, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-1/16)*SCREEN_WIDTH)
        self.howManyPeopleTextFieldConstraintTop = NSLayoutConstraint(item: self.howManyPeopleTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.howManyPeopleLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.howManyPeopleTextFieldConstraintBottom = NSLayoutConstraint(item: self.howManyPeopleTextField, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.howManyPeopleTextField, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        
        // New Meal Button
        self.newMealButtonConstraintLeft = NSLayoutConstraint(item: self.newMealButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (1/6)*SCREEN_WIDTH)
        self.newMealButtonConstraintRight = NSLayoutConstraint(item: self.newMealButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-1/6)*SCREEN_WIDTH)
        self.newMealButtonConstraintTop = NSLayoutConstraint(item: self.newMealButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.howManyPeopleTextField, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.newMealButtonConstraintBottom = NSLayoutConstraint(item: self.newMealButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.newMealButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 50.0)
        
        // Activate all constraints
        NSLayoutConstraint.activateConstraints([self.mealTypeLabelConstraintCenterX, self.mealTypeLabelConstraintTop, self.mealTypeFoodButtonConstraintLeft, self.mealTypeFoodButtonConstraintRight, self.mealTypeFoodButtonConstraintTop, self.mealTypeFoodButtonConstraintBottom, self.mealTypeCoffeeButtonConstraintLeft, self.mealTypeCoffeeButtonConstraintRight, self.mealTypeCoffeeButtonConstraintTop, self.mealTypeCoffeeButtonConstraintBottom, self.whenLabelConstraintCenterX, self.whenLabelConstraintTop, self.whenTextFieldConstraintCenterX, self.whenTextFieldConstraintLeft, self.whenTextFieldConstraintRight, self.whenTextFieldConstraintTop, self.whenTextFieldConstraintBottom, self.whatTimeLabelConstraintCenterX, self.whatTimeLabelConstraintTop, self.andLabelConstraintCenterX, self.andLabelConstraintCenterY, self.startTimeTextFieldConstraintLeft, self.startTimeTextFieldConstraintRight, self.startTimeTextFieldConstraintTop, self.startTimeTextFieldConstraintBottom, self.endTimeTextFieldConstraintLeft, self.endTimeTextFieldConstraintRight, self.endTimeTextFieldConstraintBottom, self.endTimeTextFieldConstraintCenterY, self.howManyPeopleLabelConstraintCenterX, self.howManyPeopleLabelConstraintTop, self.howManyPeopleTextFieldConstraintCenterX, self.howManyPeopleTextFieldConstraintLeft, self.howManyPeopleTextFieldConstraintRight, self.howManyPeopleTextFieldConstraintTop, self.howManyPeopleTextFieldConstraintBottom, self.newMealButtonConstraintLeft, self.newMealButtonConstraintRight, self.newMealButtonConstraintTop, self.newMealButtonConstraintBottom])
    }
    
    func getMinimumDate(datePicker: UIDatePicker) -> NSDate {
        var returnDate = NSDate()
        
        let currentDateComponents = getCurrentTime()
        let currentDate = NSCalendar.currentCalendar().dateFromComponents(currentDateComponents)
        
        let dayStart = NSDateComponents()
        dayStart.calendar = NSCalendar.currentCalendar()
        dayStart.year = currentDateComponents.year
        dayStart.month = currentDateComponents.month
        dayStart.day = currentDateComponents.day
        dayStart.hour = 8
        dayStart.minute = 0
        dayStart.second = 0
        dayStart.nanosecond = 0
        
        let dayStop = NSDateComponents()
        dayStop.calendar = NSCalendar.currentCalendar()
        dayStop.year = currentDateComponents.year
        dayStop.month = currentDateComponents.month
        dayStop.day = currentDateComponents.day
        dayStop.hour = 19
        dayStop.minute = 30
        dayStop.second = 0
        dayStop.nanosecond = 0
        
        if datePicker == self.endTimePicker {
            dayStart.minute = 30
            
            dayStop.hour = 20
            dayStop.minute = 0
        }
        
        let dayStartDate = NSCalendar.currentCalendar().dateFromComponents(dayStart)
        let dayStopDate = NSCalendar.currentCalendar().dateFromComponents(dayStop)
        
        if currentDate!.compare(self.whenDatePicker.date) == NSComparisonResult.OrderedAscending || currentDate!.compare(dayStartDate!) == NSComparisonResult.OrderedAscending {
            // Current Date is before the minimum dayStartDate for today or date chosen for when is after today
            returnDate = dayStartDate!
        }
            
        else if currentDate!.compare(dayStopDate!) == NSComparisonResult.OrderedDescending {
            // Current Date is after dayStopDate
            returnDate = dayStopDate!
        }
            
        else {
            // Round to nearest 5 minutes 30 minutes from now
            let roundingRemainder = NSDateComponents()
            roundingRemainder.minute = 30 + (5 - currentDateComponents.minute % 5)
            roundingRemainder.second = -currentDateComponents.second
            roundingRemainder.nanosecond = -currentDateComponents.nanosecond

            returnDate = NSCalendar.currentCalendar().dateByAddingComponents(roundingRemainder, toDate: currentDate!, options: NSCalendarOptions(rawValue: 0))!
        }
        
        if datePicker == self.startTimePicker {
            return returnDate
        }
            
        else {
            // End Time Picker
            if returnDate.timeIntervalSinceDate(self.startTimePicker.date) < 1800 {
                // return date is less than 30 min since self.startTimePicker.date
                returnDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Minute, value: 30, toDate: self.startTimePicker.date, options: NSCalendarOptions(rawValue: 0))!
            }
            
            return returnDate
        }
    }
    
    func getMaximumDate(datePicker: UIDatePicker) -> NSDate {
        var returnDate = NSDate()
        
        let currentDateComponents = getCurrentTime()
        
        let dayStart = NSDateComponents()
        dayStart.calendar = NSCalendar.currentCalendar()
        dayStart.year = currentDateComponents.year
        dayStart.month = currentDateComponents.month
        dayStart.day = currentDateComponents.day
        dayStart.hour = 8
        dayStart.minute = 0
        dayStart.second = 0
        dayStart.nanosecond = 0
        
        let dayStop = NSDateComponents()
        dayStop.calendar = NSCalendar.currentCalendar()
        dayStop.year = currentDateComponents.year
        dayStop.month = currentDateComponents.month
        dayStop.day = currentDateComponents.day
        dayStop.hour = 19
        dayStop.minute = 30
        dayStop.second = 0
        dayStop.nanosecond = 0
        
        if datePicker == self.endTimePicker {
            dayStart.minute = 30
            
            dayStop.hour = 20
            dayStop.minute = 0
        }
        
        let dayStopDate = NSCalendar.currentCalendar().dateFromComponents(dayStop)
        
        returnDate = dayStopDate!
        
        if datePicker == self.startTimePicker {
            
            if returnDate.timeIntervalSinceDate(self.endTimePicker.date) > -1800 {
                // returnDate is greater than 30 min before self.endTimePicker.date
                returnDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Minute, value: -30, toDate: self.endTimePicker.date, options: NSCalendarOptions(rawValue: 0))!
            }

            return returnDate
        }
            
        else {
            // End Time Picker
            return returnDate
        }
    }
    
    func getMinimumDay() -> NSDate {
        let todayComponents = getCurrentTime()
        let today = NSCalendar.currentCalendar().dateFromComponents(todayComponents)
        
        let currentDayStop = NSDateComponents()
        currentDayStop.calendar = NSCalendar.currentCalendar()
        currentDayStop.year = todayComponents.year
        currentDayStop.month = todayComponents.month
        currentDayStop.day = todayComponents.day
        currentDayStop.hour = 19
        currentDayStop.minute = 30
        currentDayStop.second = 0
        currentDayStop.nanosecond = 0
        
        let currentDayStopDate = NSCalendar.currentCalendar().dateFromComponents(currentDayStop)
        
        if today?.timeIntervalSinceDate(currentDayStopDate!) >= 0 {
            // Current time is after minimum day stop; return tomorrow
            return NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: 1, toDate: today!, options: NSCalendarOptions(rawValue: 0))!
        }
        
        return today!
    }
    
    func getMaximumDay() -> NSDate {
        let oneWeekFromMinimumDay = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: 6, toDate: self.whenDatePicker.minimumDate!, options: NSCalendarOptions(rawValue: 0))
        
        return oneWeekFromMinimumDay!
    }
    
    // MARK: - Action Methods
    
    func newMealButtonPressed(sender: UIButton) {
        self.view.endEditing(true)
        
        let user = getCurrentUser()
        let howManyPeople = Int(self.howManyPeopleTextField.text!)
        self.meal.mealCallback = self;
        self.meal.createMeal(user.emailAddress, authenticationToken: user.authenticationToken, day: self.whenDatePicker.date, startRange: self.startTimePicker.date, endRange: self.endTimePicker.date, numberOfPeople: howManyPeople!, mealType: self.mealType!)
    }
    
    func whenDatePickerValueChanged() {
        self.whenTextField.text = self.whenDatePicker.date.toReadableDateOnlyStringLong()
    }
    
    func whatTimeDatePickerValueChanged(datePicker: UIDatePicker) {
        if datePicker == self.startTimePicker {
            self.endTimePicker.minimumDate = getMinimumDate(self.endTimePicker)
            if self.endTimePicker.minimumDate!.compare(self.endTimePicker.date) == NSComparisonResult.OrderedDescending {
                self.endTimePicker.date = self.endTimePicker.minimumDate!
            }
            self.startTimeTextField.text = self.startTimePicker.date.toReadableTimeOnlyString()
        }
        else {
            // End Time Picker
            self.startTimePicker.maximumDate = getMaximumDate(self.startTimePicker)
            if self.startTimePicker.maximumDate!.compare(self.startTimePicker.date) == NSComparisonResult.OrderedAscending {
                self.startTimePicker.date = self.startTimePicker.maximumDate!
            }
            self.endTimeTextField.text = self.endTimePicker.date.toReadableTimeOnlyString()
        }
    }
    
    func mealTypeButtonPressed(sender: UIButton?) {
        self.view.endEditing(true)
        
        if sender == nil || (sender == self.mealTypeFoodButton && self.mealType == MealType(rawValue: 1)) || (sender == self.mealTypeCoffeeButton && self.mealType == MealType.Coffee) {
            // User deselected chosen option
            self.mealType = MealType(rawValue: 0)
            self.changemealTypeButtonColors(nil)
        }
            
        else if sender == self.mealTypeFoodButton {
            self.mealType = MealType(rawValue: 1)
            self.changemealTypeButtonColors(sender)
        }
            
        else {
            // sender == self.mealTypeCoffeeButton
            self.mealType = MealType.Coffee
            self.changemealTypeButtonColors(sender)
        }
    }
    
    func changemealTypeButtonColors(sender: UIButton?) {
        if sender == self.mealTypeFoodButton {
            self.mealTypeFoodButton.backgroundColor = COLOR_ACCENT_ONE
            self.mealTypeCoffeeButton.backgroundColor = COLOR_WHITE
        }
        
        else if sender == self.mealTypeCoffeeButton {
            self.mealTypeFoodButton.backgroundColor = COLOR_WHITE
            self.mealTypeCoffeeButton.backgroundColor = COLOR_ACCENT_ONE
        }
        
        else {
            self.mealTypeFoodButton.backgroundColor = COLOR_WHITE
            self.mealTypeCoffeeButton.backgroundColor = COLOR_WHITE
        }
    }
    
    // Check for single or multiple taps on view to dismiss keyboard - resign all text fields
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.resignFirstResponder()
        view.endEditing(true)
    }
    
    // MARK: - Delegates and data sources
    // MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return howManyPeoplePickerData.count
    }
    
    // MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return howManyPeoplePickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        howManyPeopleTextField.text = howManyPeoplePickerData[row]
    }
    
    // MARK: - API Callback
    
    func createMealAPICallback(success: Bool, errorMessage: String) -> Void {
        if success {
            // Reset all options on view
            self.mealTypeButtonPressed(nil)
            self.howManyPeoplePicker.selectRow(0, inComponent: 0, animated: false)
            self.howManyPeopleTextField.text = self.howManyPeoplePickerData[self.howManyPeoplePicker.selectedRowInComponent(0)]
            // Reset self.whenDatePicker.date to self.whenDatePicker.minimumDate
            self.whenDatePicker.date = self.whenDatePicker.minimumDate!
            self.whenDatePickerValueChanged()
            self.endTimePicker.date = getMaximumDate(self.endTimePicker)
            self.whatTimeDatePickerValueChanged(self.endTimePicker)
            self.startTimePicker.date = getMinimumDate(self.startTimePicker)
            self.whatTimeDatePickerValueChanged(self.startTimePicker)
            
            // Display success
            let alertView = createAlert("Success", message: errorMessage, actionMessage: "Ok")
            self.presentViewController(alertView, animated: true, completion: nil)
            
            // Send notification to upcoming mela view controller to add created meal to view
            NSNotificationCenter.defaultCenter().postNotificationName(NEW_MEAL_NOTIFICATION, object: self)
        }
        else {
            // Display error
            let alertView = createAlert("Error", message: errorMessage, actionMessage: "Ok")
            self.presentViewController(alertView, animated: true, completion: nil)
        }
    }
}

