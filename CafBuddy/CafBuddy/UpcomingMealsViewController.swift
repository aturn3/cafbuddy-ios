//
//  UpcomingMealsViewController.swift
//  CafBuddy
//
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import UIKit
import Foundation

class UpcomingMealsViewController: MainScreenViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MealAPICallback, MealCollectionCellCallBack {

    var collectionViewMeals : UICollectionView?
    
    let mealObject = Meal()
    
    var matchedMeals = [MatchedMeal]()
    var unMatchedMeals = [UnMatchedMeal]()
//    var meals: [AnyObject] = [[, ]
    
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
    
    func updateAllMealsFromDatabase() {
        let curUser = getCurrentUser()
        mealObject.getAllUpcomingMeals(curUser.emailAddress, authToken: curUser.authenticationToken)
    }
    
    func getAllUpcomingMealsAPICallback(success: Bool, errorMessage: String, unMatchedMeals: [UnMatchedMeal], matchedMeals: [MatchedMeal]) -> Void {
        if (success) {
            self.matchedMeals = matchedMeals
            self.unMatchedMeals = unMatchedMeals
            collectionViewMeals?.reloadData()
        }
    }

    func mealCellButtonWasPressed(buttonIndex: Int, sectionIndex: Int) {
        print("The button that was pressed was: " + String(buttonIndex) + " in the section: " + String(sectionIndex))
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let mealCollectionCell = collectionViewMeals!.dequeueReusableCellWithReuseIdentifier("upcomingMealCell", forIndexPath: indexPath) as! UpcomingMealListingCell
        
        // needed to receive the button presses from the cells
        mealCollectionCell.buttonCallBack = self;
        mealCollectionCell.cellSectionIndex = indexPath.section
        mealCollectionCell.cellRowIndex = indexPath.row
        
        //if the seciton is MatchedMeals
        var theMealType = MealType.Breakfast
        if (indexPath.section == 0) {
            theMealType = (matchedMeals[indexPath.row].mealType)!
        }
        else {
            theMealType = (unMatchedMeals[indexPath.row].mealType)!
        }
//        mealCollectionCell.initializeUpcomingMealCellContents(MealStatus(rawValue: indexPath.section)!, mealType: theMealType, )
        mealCollectionCell.initializeUpcomingMealCellContents(MealStatus(rawValue: indexPath.section)!, mealType: theMealType, numBuddies: unMatchedMeals[indexPath.row].numPeople!, startTime: unMatchedMeals[indexPath.row].startRange!, endTime: unMatchedMeals[indexPath.row].endRange!)
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
}

