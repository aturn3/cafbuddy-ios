//
//  NewMealViewController.swift
//  CafBuddy
//
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import UIKit

class NewMealViewController: UIViewController {
    
    // MARK: - Properties
    
    var when = String()
    var howManyPeople = Int()
    var startTime = NSDate()
    var endTime = NSDate()
    
    let whenLabel = UILabel()
    let todayButton = UIButton()
    let tomorrowButton = UIButton()
    let dayAfterTomorrowButton = UIButton()
    let whatTimeLabel = UILabel()
    let toLabel = UILabel()
    let startTimeTextField = UITextField()
    let endTimeTextField = UITextField()
    let startTimePicker = UIDatePicker()
    let endTimePicker = UIDatePicker()
    let howManyPeopleLabel = UILabel()
    let newMealButton = UIButton()
    
    var whenLabelConstraintCenterX = NSLayoutConstraint()
    var whenLabelConstraintTop = NSLayoutConstraint()
    var whenLabelConstraintBottom = NSLayoutConstraint()
    
    var todayButtonConstraintLeft = NSLayoutConstraint()
    var todayButtonConstraintRight = NSLayoutConstraint()
    var todayButtonConstraintTop = NSLayoutConstraint()
    var todayButtonConstraintBottom = NSLayoutConstraint()
    
    var tomorrowButtonConstraintLeft = NSLayoutConstraint()
    var tomorrowButtonConstraintRight = NSLayoutConstraint()
    var tomorrowButtonConstraintTop = NSLayoutConstraint()
    var tomorrowButtonConstraintBottom = NSLayoutConstraint()
    
    var dayAfterTomorrowButtonConstraintLeft = NSLayoutConstraint()
    var dayAfterTomorrowButtonConstraintRight = NSLayoutConstraint()
    var dayAfterTomorrowButtonConstraintTop = NSLayoutConstraint()
    var dayAfterTomorrowButtonConstraintBottom = NSLayoutConstraint()
    
    var whatTimeLabelConstraintCenterX = NSLayoutConstraint()
    var whatTimeLabelConstraintTop = NSLayoutConstraint()
    var whatTimeLabelConstraintBottom = NSLayoutConstraint()
    
    var toLabelConstraintCenterX = NSLayoutConstraint()
    var toLabelConstraintTop = NSLayoutConstraint()
    var toLabelConstraintBottom = NSLayoutConstraint()

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
    var howManyPeopleLabelConstraintBottom = NSLayoutConstraint()
    
    var newMealButtonConstraintLeft = NSLayoutConstraint()
    var newMealButtonConstraintRight = NSLayoutConstraint()
    var newMealButtonConstraintTop = NSLayoutConstraint()
    var newMealButtonConstraintBottom = NSLayoutConstraint()
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the navigation bar to be tinted main color and set title
        navigationController?.navigationBar.barTintColor = COLOR_MAIN
        navigationItem.title = "Create A Meal"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        self.initInterface()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initInterface() {
        
        self.view.backgroundColor = COLOR_NEUTRAL_BACKGROUND
        
        // When Label
        self.whenLabel.font = UIFont.systemFontOfSize(24)
        self.whenLabel.textAlignment = NSTextAlignment.Center
        self.whenLabel.text = "When?"
        self.whenLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.whenLabel)
        
        // Today Button
        self.todayButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        self.todayButton.setTitle("Today", forState: UIControlState.Normal)
        self.todayButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        self.todayButton.backgroundColor = COLOR_WHITE
        self.todayButton.layer.cornerRadius = 10
        self.todayButton.addTarget(self, action: "whenButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.todayButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.todayButton)
        
        // Tomorrow Button
        self.tomorrowButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        self.tomorrowButton.setTitle("Tomorrow", forState: UIControlState.Normal)
        self.tomorrowButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        self.tomorrowButton.backgroundColor = COLOR_WHITE
        self.tomorrowButton.layer.cornerRadius = 10
        self.tomorrowButton.addTarget(self, action: "whenButtonPressed:", forControlEvents: UIControlEvents.ValueChanged)
        self.tomorrowButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tomorrowButton)
        
        // Day After Tomorrow Button
        self.dayAfterTomorrowButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        self.dayAfterTomorrowButton.setTitle("Day After Tomorrow", forState: UIControlState.Normal)
        self.dayAfterTomorrowButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        self.dayAfterTomorrowButton.backgroundColor = COLOR_WHITE
        self.dayAfterTomorrowButton.layer.cornerRadius = 10
        self.dayAfterTomorrowButton.addTarget(self, action: "whenButtonPressed:", forControlEvents: UIControlEvents.ValueChanged)
        self.dayAfterTomorrowButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.dayAfterTomorrowButton)
        
        // What Time Label
        self.whatTimeLabel.font = UIFont.systemFontOfSize(24)
        self.whatTimeLabel.textAlignment = NSTextAlignment.Center
        self.whatTimeLabel.text = "Start meal between"
        self.whatTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.whatTimeLabel)
        
        // To Label
        self.toLabel.font = UIFont.systemFontOfSize(18)
        self.toLabel.textAlignment = NSTextAlignment.Center
        self.toLabel.text = "to"
        self.toLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.toLabel)
        
        // Start Time Picker
        self.startTimePicker.timeZone = nil // User local time
        self.startTimePicker.datePickerMode = UIDatePickerMode.Time
        self.startTimePicker.minuteInterval = 5
        self.startTimePicker.date = getMinimumDate(self.startTimePicker)
        self.startTimePicker.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        // End Time Picker
        self.endTimePicker.timeZone = nil // User local time
        self.endTimePicker.datePickerMode = UIDatePickerMode.Time
        self.endTimePicker.minuteInterval = 5
        self.endTimePicker.date = getMaximumDate(self.endTimePicker)
        self.endTimePicker.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        // Set minimum and maximum dates for Start and End Time Pickers after their dates have been set
        self.startTimePicker.minimumDate = getMinimumDate(self.startTimePicker)
        self.startTimePicker.maximumDate = getMaximumDate(self.startTimePicker)
        self.endTimePicker.minimumDate = getMinimumDate(self.endTimePicker)
        self.endTimePicker.maximumDate = getMaximumDate(self.endTimePicker)
        
        // Start Time Text Field
        self.startTimeTextField.text = self.startTimePicker.date.toReadableTimeOnlyString()
        self.startTimeTextField.textAlignment = NSTextAlignment.Center
        self.startTimeTextField.font = UIFont.systemFontOfSize(12)
        self.startTimeTextField.borderStyle = UITextBorderStyle.RoundedRect
        self.startTimeTextField.inputView = self.startTimePicker
        self.startTimeTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.startTimeTextField)
        
        // End Time Text Field
        self.endTimeTextField.text = self.endTimePicker.date.toReadableTimeOnlyString()
        self.endTimeTextField.textAlignment = NSTextAlignment.Center
        self.endTimeTextField.font = UIFont.systemFontOfSize(12)
        self.endTimeTextField.borderStyle = UITextBorderStyle.RoundedRect
        self.endTimeTextField.inputView = self.endTimePicker
        self.endTimeTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.endTimeTextField)
        
        // How Many People Label
        self.howManyPeopleLabel.font = UIFont.systemFontOfSize(24)
        self.howManyPeopleLabel.textAlignment = NSTextAlignment.Center
        self.howManyPeopleLabel.text = "With how many people?"
        self.howManyPeopleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.howManyPeopleLabel)
        
        // New Meal Button
        self.newMealButton.titleLabel!.font = UIFont.systemFontOfSize(24)
        self.newMealButton.setTitle("Create Meal!", forState: UIControlState.Normal)
        self.newMealButton.setTitleColor(COLOR_BLACK, forState: UIControlState.Normal)
        self.newMealButton.backgroundColor = COLOR_RED
        self.newMealButton.layer.cornerRadius = 10
        self.newMealButton.addTarget(self, action: "newMealButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.newMealButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.newMealButton)
        
        // MARK: - Constraints
        
        // When Label
        self.whenLabelConstraintCenterX = NSLayoutConstraint(item: self.whenLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.whenLabelConstraintTop = NSLayoutConstraint(item: self.whenLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: (1/10)*MAIN_VIEW_HEIGHT)
        self.whenLabelConstraintBottom = NSLayoutConstraint(item: self.whenLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.whenLabel, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 50.0)
        
        // Today Button
        self.todayButtonConstraintLeft = NSLayoutConstraint(item: self.todayButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (1/52)*SCREEN_WIDTH)
        self.todayButtonConstraintRight = NSLayoutConstraint(item: self.todayButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-35/52)*SCREEN_WIDTH)
        self.todayButtonConstraintTop = NSLayoutConstraint(item: self.todayButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.whenLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.todayButtonConstraintBottom = NSLayoutConstraint(item: self.todayButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.todayButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)

        // Tomorrow Button
        self.tomorrowButtonConstraintLeft = NSLayoutConstraint(item: self.tomorrowButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (18/52)*SCREEN_WIDTH)
        self.tomorrowButtonConstraintRight = NSLayoutConstraint(item: self.tomorrowButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-18/52)*SCREEN_WIDTH)
        self.tomorrowButtonConstraintTop = NSLayoutConstraint(item: self.tomorrowButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.todayButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
        self.tomorrowButtonConstraintBottom = NSLayoutConstraint(item: self.tomorrowButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.todayButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
        
        // Day After Tomorrow Button
        self.dayAfterTomorrowButtonConstraintLeft = NSLayoutConstraint(item: self.dayAfterTomorrowButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (35/52)*SCREEN_WIDTH)
        self.dayAfterTomorrowButtonConstraintRight = NSLayoutConstraint(item: self.dayAfterTomorrowButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-1/52)*SCREEN_WIDTH)
        self.dayAfterTomorrowButtonConstraintTop = NSLayoutConstraint(item: self.dayAfterTomorrowButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.todayButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
        self.dayAfterTomorrowButtonConstraintBottom = NSLayoutConstraint(item: self.dayAfterTomorrowButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.todayButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
        
        // What Time Label
        self.whatTimeLabelConstraintCenterX = NSLayoutConstraint(item: self.whatTimeLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.whenLabel, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.whatTimeLabelConstraintTop = NSLayoutConstraint(item: self.whatTimeLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.todayButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.whatTimeLabelConstraintBottom = NSLayoutConstraint(item: self.whatTimeLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.whatTimeLabel, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 50.0)
        
        // To Label
        self.toLabelConstraintCenterX = NSLayoutConstraint(item: self.toLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.toLabelConstraintTop = NSLayoutConstraint(item: self.toLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.whatTimeLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.toLabelConstraintBottom = NSLayoutConstraint(item: self.toLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.toLabel, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 50.0)
        
        // Start Time Text Field
        self.startTimeTextFieldConstraintLeft = NSLayoutConstraint(item: self.startTimeTextField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (1/16)*SCREEN_WIDTH)
        self.startTimeTextFieldConstraintRight = NSLayoutConstraint(item: self.startTimeTextField, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-9/16)*SCREEN_WIDTH)
        self.startTimeTextFieldConstraintBottom = NSLayoutConstraint(item: self.startTimeTextField, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.startTimeTextField, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        self.startTimeTextFieldConstraintCenterY = NSLayoutConstraint(item: self.startTimeTextField, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.toLabel, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
        
        // End Time Text Field
        self.endTimeTextFieldConstraintLeft = NSLayoutConstraint(item: self.endTimeTextField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (9/16)*SCREEN_WIDTH)
        self.endTimeTextFieldConstraintRight = NSLayoutConstraint(item: self.endTimeTextField, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-1/16)*SCREEN_WIDTH)
        self.endTimeTextFieldConstraintBottom = NSLayoutConstraint(item: self.endTimeTextField, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.endTimeTextField, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 35.0)
        self.endTimeTextFieldConstraintCenterY = NSLayoutConstraint(item: self.endTimeTextField, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.toLabel, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
        
        // How Many People Label
        self.howManyPeopleLabelConstraintCenterX = NSLayoutConstraint(item: self.howManyPeopleLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.howManyPeopleLabelConstraintTop = NSLayoutConstraint(item: self.howManyPeopleLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.toLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        self.howManyPeopleLabelConstraintBottom = NSLayoutConstraint(item: self.howManyPeopleLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.howManyPeopleLabel, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 50.0)
        
        // New Meal Button
        self.newMealButtonConstraintLeft = NSLayoutConstraint(item: self.newMealButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: (1/6)*SCREEN_WIDTH)
        self.newMealButtonConstraintRight = NSLayoutConstraint(item: self.newMealButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: (-1/6)*SCREEN_WIDTH)
        self.newMealButtonConstraintTop = NSLayoutConstraint(item: self.newMealButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: (5/6)*MAIN_VIEW_HEIGHT)
        self.newMealButtonConstraintBottom = NSLayoutConstraint(item: self.newMealButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.newMealButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 70.0)
        
        // Activate all constraints
        NSLayoutConstraint.activateConstraints([self.whenLabelConstraintCenterX, self.whenLabelConstraintTop, self.whenLabelConstraintBottom, self.todayButtonConstraintLeft, self.newMealButtonConstraintLeft, self.todayButtonConstraintRight, self.todayButtonConstraintTop, self.todayButtonConstraintBottom, self.tomorrowButtonConstraintLeft, self.tomorrowButtonConstraintRight, self.tomorrowButtonConstraintTop, self.tomorrowButtonConstraintBottom, self.dayAfterTomorrowButtonConstraintLeft, self.dayAfterTomorrowButtonConstraintRight, self.dayAfterTomorrowButtonConstraintTop, self.dayAfterTomorrowButtonConstraintBottom, self.whatTimeLabelConstraintCenterX, self.whatTimeLabelConstraintTop, self.whatTimeLabelConstraintBottom, self.toLabelConstraintCenterX, self.toLabelConstraintTop, self.toLabelConstraintBottom, self.startTimeTextFieldConstraintLeft, self.startTimeTextFieldConstraintRight, self.startTimeTextFieldConstraintBottom, self.startTimeTextFieldConstraintCenterY, self.endTimeTextFieldConstraintLeft, self.endTimeTextFieldConstraintRight, self.endTimeTextFieldConstraintBottom, self.endTimeTextFieldConstraintCenterY, self.howManyPeopleLabelConstraintCenterX, self.howManyPeopleLabelConstraintTop, self.howManyPeopleLabelConstraintBottom, self.newMealButtonConstraintLeft, self.newMealButtonConstraintRight, self.newMealButtonConstraintTop, self.newMealButtonConstraintBottom])
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
        
        var dayStartDate = NSCalendar.currentCalendar().dateFromComponents(dayStart)
        var dayStopDate = NSCalendar.currentCalendar().dateFromComponents(dayStop)
        
        if when == self.todayButton.titleLabel!.text || when == String() {
            // Calculated day start and day stop from above are correct
        }
        
        else if when == self.tomorrowButton.titleLabel!.text {
            // Add 1 day to dayStart and dayStop
            dayStartDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: 1, toDate: dayStartDate!, options: NSCalendarOptions(rawValue: 0))
            dayStopDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: 1, toDate: dayStartDate!, options: NSCalendarOptions(rawValue: 0))
        }
        
        else {
            // Day after tomorrow
            // Add 2 days to dayStart and dayStop
            dayStartDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: 2, toDate: dayStartDate!, options: NSCalendarOptions(rawValue: 0))
            dayStopDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: 2, toDate: dayStartDate!, options: NSCalendarOptions(rawValue: 0))
        }
        
        if currentDate!.compare(dayStartDate!) == NSComparisonResult.OrderedAscending {
            returnDate = dayStartDate!
        }
            
        else if currentDate!.compare(dayStopDate!) == NSComparisonResult.OrderedDescending {
            // Current Date is before dayStopDate
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
    
    // MARK: - Action Methods
    
    func datePickerValueChanged(datePicker: UIDatePicker) {
        print(self.startTimePicker.minimumDate)
        print(self.startTimePicker.maximumDate)
        print(self.endTimePicker.minimumDate)
        print(self.endTimePicker.maximumDate)
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
    
    // New Meal Button Action
    func whenButtonPressed(sender: UIButton) {
        self.view.endEditing(true)
        
        if self.when == sender.titleLabel!.text! {
            // User deselected chosen option
            self.when = String()
            self.changeWhenButtonColors(nil)
        }
        else {
            self.when = sender.titleLabel!.text!
            self.changeWhenButtonColors(sender)
        }
    }
    
    func changeWhenButtonColors(sender: UIButton?) {
        if sender == self.todayButton {
            self.todayButton.backgroundColor = COLOR_BLUE
            self.tomorrowButton.backgroundColor = COLOR_WHITE
            self.dayAfterTomorrowButton.backgroundColor = COLOR_WHITE
        }
        else if sender == self.tomorrowButton {
            self.todayButton.backgroundColor = COLOR_WHITE
            self.tomorrowButton.backgroundColor = COLOR_BLUE
            self.dayAfterTomorrowButton.backgroundColor = COLOR_WHITE
        }
        else if sender == self.dayAfterTomorrowButton {
            self.todayButton.backgroundColor = COLOR_WHITE
            self.tomorrowButton.backgroundColor = COLOR_WHITE
            self.dayAfterTomorrowButton.backgroundColor = COLOR_BLUE
        }
        else {
            // Sender is nil
            self.todayButton.backgroundColor = COLOR_WHITE
            self.tomorrowButton.backgroundColor = COLOR_WHITE
            self.dayAfterTomorrowButton.backgroundColor = COLOR_WHITE
        }
    }
}

