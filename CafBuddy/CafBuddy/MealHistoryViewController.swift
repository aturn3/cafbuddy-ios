//
//  MealHistoryViewController.swift
//  CafBuddy
//
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import UIKit

class MealHistoryViewController: MainScreenViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MealAPICallback, MealCollectionCellCallBack {
    
    let mealObject = Meal() // the object used to interact with the API
    
    var collectionViewMeals : UICollectionView? // the actual collection view shown on the screen
    var pastMeals = [MatchedMeal]() // holds the meals that are shown in the collection view
    
    var mealClickedForFeedback : MatchedMeal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Set the title of the navigation bar
        navigationItem.title = "Meal History"
        
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
        collectionViewLayout.sectionInset = UIEdgeInsetsMake(15, 15, 0, 15)
        collectionViewLayout.itemSize = CGSizeMake(screenSize.width - 30, 150)
//        collectionViewLayout.headerReferenceSize = CGSizeMake(screenSize.width, 20)
        //the screen starts after the top bar but extends below the navbar
        let collectionViewHeight = screenSize.height - TAB_BAR_HEIGHT - NAV_BAR_HEIGHT - STATUS_BAR_HEIGHT
        collectionViewMeals = UICollectionView(frame: CGRectMake(0, 0, screenSize.width, collectionViewHeight), collectionViewLayout: collectionViewLayout)
        
        collectionViewMeals!.delegate = self;
        collectionViewMeals!.dataSource = self;
        collectionViewMeals!.alwaysBounceVertical = true
        collectionViewMeals!.registerClass(HistoryMealListingCell.self, forCellWithReuseIdentifier: "historyMealCell")
//        collectionViewMeals!.registerClass(UpcomingMealCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionViewMeals!.backgroundColor = COLOR_NEUTRAL_BACKGROUND
        
        self.view.addSubview(collectionViewMeals!)
        
        updateMeals()
        
    }
    
    func updateMeals() {
        let curUser = getCurrentUser()
        // lets just get all possible meals that the user has had up to this point
        mealObject.getMatchedMealsInRange(curUser.emailAddress, authToken: curUser.authenticationToken, startRange: NSDate.distantPast(), endRange: NSDate())
    }
    
    //MARK: - Cell Call Backs
    
    func mealCellButtonWasPressed(buttonIndex: Int, sectionIndex: Int, rowIndex: Int) {
        // if the feedback button was pressed, we first need to save which meal it was, then segue to the feedback view controller
        mealClickedForFeedback = pastMeals[rowIndex];
        self.performSegueWithIdentifier("toMealFeedbackFromMealHistory", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // before going to the feedback screen, give the meal we are giving feedback on to that view
        // then set the meal to nil since next meal to give feedback will be different
        if segue.identifier == "toMealFeedbackFromMealHistory" {
            let destinationController = segue.destinationViewController as! MealFeedbackViewController
            destinationController.mealToFeedback = mealClickedForFeedback
            mealClickedForFeedback = nil
        }
    }
    
    //MARK: - Collection View Call Backs
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let historyCollectionCell = collectionViewMeals!.dequeueReusableCellWithReuseIdentifier("historyMealCell", forIndexPath: indexPath) as! HistoryMealListingCell
        
        // needed to receive the button presses from the cells
        historyCollectionCell.buttonCallBack = self;
        historyCollectionCell.cellSectionIndex = indexPath.section
        historyCollectionCell.cellRowIndex = indexPath.row

        let theMeal = pastMeals[indexPath.row]
        historyCollectionCell.initializeHistoryMealCellContents(
            theMeal.mealType!,
            people: theMeal.people,
            startTime: theMeal.startTime!,
            curUser: getCurrentUser(),
            feedbackGiven: theMeal.feedbackGiven!
        )
        
        return historyCollectionCell
    }
    
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pastMeals.count
    }
    
    
    //MARK: - API Callbacks
    
    func getMatchedMealsInRangeAPICallback(success: Bool, errorMessage: String, matchedMeals: [MatchedMeal]) {
        if (success) {
            pastMeals = matchedMeals
            collectionViewMeals?.reloadData()
        }
    }
    
    
}