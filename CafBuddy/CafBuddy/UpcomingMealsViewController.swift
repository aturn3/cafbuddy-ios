//
//  UpcomingMealsViewController.swift
//  CafBuddy
//
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import UIKit
import Foundation
import EventKit

class UpcomingMealsViewController: MainScreenViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MealAPICallback, MealCollectionCellCallBack {

    // MARK: properties
    
    var collectionViewMeals : UICollectionView?
    
    let mealObject = Meal()
    
    var matchedMeals = [MatchedMeal]()
    var unMatchedMeals = [UnMatchedMeal]()
    
    // MARK: - Initialization Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set the navigation bar to be tinted main color and set title
        navigationController?.navigationBar.barTintColor = COLOR_MAIN
        navigationItem.title = "Upcoming Meals"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        initInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initInterface() {
        
        mealObject.mealCallback = self
        
        let collectionViewLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 15
        collectionViewLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15)
        collectionViewLayout.itemSize = CGSizeMake(screenSize.width - 30, 150)
        
        //the screen starts after the top bar but extends below the navbar
        let collectionViewHeight = screenSize.height - TAB_BAR_HEIGHT - NAV_BAR_HEIGHT - STATUS_BAR_HEIGHT
        collectionViewMeals = UICollectionView(frame: CGRectMake(0, 0, screenSize.width, collectionViewHeight), collectionViewLayout: collectionViewLayout)
        
        collectionViewMeals!.delegate = self;
        collectionViewMeals!.dataSource = self;
        collectionViewMeals!.alwaysBounceVertical = true
        collectionViewMeals!.registerClass(UpcomingMealListingCell.self, forCellWithReuseIdentifier: "upcomingMealCell")
        collectionViewMeals!.backgroundColor = COLOR_NEUTRAL_BACKGROUND
        
        self.view.addSubview(collectionViewMeals!)
        
        updateAllMealsFromDatabase()
    }
    
    // MARK: - Action Methods
    
    func updateAllMealsFromDatabase() {
        let curUser = getCurrentUser()
        mealObject.getAllUpcomingMeals(curUser.emailAddress, authToken: curUser.authenticationToken)
    }

    func mealCellButtonWasPressed(buttonIndex: Int, sectionIndex: Int, rowIndex: Int) {
        // if dealing with matched meal buttons
        if (sectionIndex == 0) {
            // if clicked the add to calendar button
            if (buttonIndex == 0) {
                addMealToCalendar(rowIndex)
            }
            // chat button
            else {
                
            }
        }
        //  if dealing with unmatched meal buttons
        else {
            //if clicked the cancel meal plan button
            if (buttonIndex == 0) {
                
            }
            // edit time button
            else {
                
            }
        }
        
    }
    
    // add a matched meal to the calendar
    func addMealToCalendar(cellRowIndex : Int) {
        // get the actual meal
        let theMeal = matchedMeals[cellRowIndex]

        // create the meal title
        var eventTitle = String()
        eventTitle += MealTypeStrings[theMeal.mealType!.rawValue] + " with " + convertIntToWordEquivalent(theMeal.numPeople! - 1)
        if (theMeal.numPeople > 2) { eventTitle += " buddies" }
        else { eventTitle += " buddy" }
        
        // now lets save the actual meal
        let calendarStore = EKEventStore()
        calendarStore.requestAccessToEntityType(.Event) {
            // note that this block spawns a new background thread! SO in order to ensure that we don't introduce possible
            // completely unpredictable behavior, we run the showing of alertViewController on the main thread only
            // not the background thread that this block is currently running in... thats what the dispatch_async blocks are
            (accessGranted: Bool, error: NSError?) in
            // if the user has not granted us acess
            if (!accessGranted) {
                dispatch_async(dispatch_get_main_queue(), {
                    let theAlertView = createAlert("Oh no!", message: "You didn't grant CafBuddy access to your calendar. You can change this in settings.", actionMessage: "Okay")
                    self.presentViewController(theAlertView, animated: true, completion: nil)
                })
                return
            }
            // if they have granted us access... then lets create the actual event
            let theMealEvent = EKEvent(eventStore: calendarStore)
            theMealEvent.title = eventTitle
            theMealEvent.startDate = theMeal.startTime!
            theMealEvent.endDate = theMealEvent.startDate.dateByAddingTimeInterval(60*45) //assume 45 minutes long
            theMealEvent.calendar = calendarStore.defaultCalendarForNewEvents
            theMealEvent.addAlarm(EKAlarm(relativeOffset: -60*60*2)) // adds an alarm that will fire two hours before the event starts
            //actually add the event
            do {
                try calendarStore.saveEvent(theMealEvent, span: EKSpan.ThisEvent, commit: true)
                dispatch_async(dispatch_get_main_queue(), {
                    let theAlertView = createAlert("Calendar Event Created", message: "The meal '" + eventTitle + "' was saved to your calendar on " + theMeal.startTime!.toReadableDateOnlyStringShort() + " with a reminder set for two hours before the meal starts.", actionMessage: "Okay")
                    self.presentViewController(theAlertView, animated: true, completion: nil)

                })
//                self.savedEventId = event.eventIdentifier //the event identifier.. we dont need this now but if want to access later at some point we will need this
            } catch {
                dispatch_async(dispatch_get_main_queue(), {
                    let theAlertView = createAlert("Oh no!", message: "There was a problem adding the event to your calendar. Please try again.", actionMessage: "Okay")
                    self.presentViewController(theAlertView, animated: true, completion: nil)
                })
            }
        }
    }
    
    
    // MARK: - Collection View Methods
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let mealCollectionCell = collectionViewMeals!.dequeueReusableCellWithReuseIdentifier("upcomingMealCell", forIndexPath: indexPath) as! UpcomingMealListingCell
        
        // needed to receive the button presses from the cells
        mealCollectionCell.buttonCallBack = self;
        mealCollectionCell.cellSectionIndex = indexPath.section
        mealCollectionCell.cellRowIndex = indexPath.row

        // if matched meals
        if (indexPath.section == 0) {
            mealCollectionCell.initializeUpcomingMealCellContents(
                MealStatus(rawValue: indexPath.section)!,
                mealType: (matchedMeals[indexPath.row].mealType)!,
                numBuddies: matchedMeals[indexPath.row].numPeople!,
                startTime: matchedMeals[indexPath.row].startTime!
            )
        }
        // if unmatched meals
        else {
            mealCollectionCell.initializeUpcomingMealCellContents(
                MealStatus(rawValue: indexPath.section)!,
                mealType: (unMatchedMeals[indexPath.row].mealType)!,
                numBuddies: unMatchedMeals[indexPath.row].numPeople!,
                startTime: unMatchedMeals[indexPath.row].startRange!,
                endTime: unMatchedMeals[indexPath.row].endRange!
            )
        }
        
        return mealCollectionCell
    }
    
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int{
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 0){
            return matchedMeals.count
        }
        return unMatchedMeals.count
    }
    
    // MARK: - Api Callback
    
    func getAllUpcomingMealsAPICallback(success: Bool, errorMessage: String, unMatchedMeals: [UnMatchedMeal], matchedMeals: [MatchedMeal]) -> Void {
        if (success) {
            self.matchedMeals = matchedMeals
            self.unMatchedMeals = unMatchedMeals
            collectionViewMeals?.reloadData()
        }
    }
}

