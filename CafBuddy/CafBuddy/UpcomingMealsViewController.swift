//
//  UpcomingMealsViewController.swift
//  CafBuddy
//
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import UIKit

class UpcomingMealsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var collectionViewMain : UICollectionView?
    
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
        
        let collectionViewLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 15
        collectionViewLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15)
        collectionViewLayout.itemSize = CGSizeMake(screenSize.width - 30, 150)
        
        //the screen starts after the top bar but extends below the navbar
        let collectionViewHeight = screenSize.height - TAB_BAR_HEIGHT - NAV_BAR_HEIGHT - STATUS_BAR_HEIGHT
        collectionViewMain = UICollectionView(frame: CGRectMake(0, 0, screenSize.width, collectionViewHeight), collectionViewLayout: collectionViewLayout)
        
        collectionViewMain!.delegate = self;
        collectionViewMain!.dataSource = self;
        collectionViewMain!.alwaysBounceVertical = true
        collectionViewMain!.registerClass(MealCollectionCellTemplate.self, forCellWithReuseIdentifier: "upcomingMealCell")
        collectionViewMain!.backgroundColor = COLOR_NEUTRAL_BACKGROUND
        
        self.view.addSubview(collectionViewMain!)
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let mealCollectionCell = collectionViewMain!.dequeueReusableCellWithReuseIdentifier("upcomingMealCell", forIndexPath: indexPath) as! MealCollectionCellTemplate
        mealCollectionCell.backgroundColor = UIColor.whiteColor()
        
//        //set some default values
//        var theMealType = MealType.Breakfast
//        if (indexPath.item%3 == 0) {
//            historyCell.setMealDetails(MealType.Breakfast)
//        }
//        else if (indexPath.item%3 == 1) {
//            historyCell.setMealDetails(MealType.Lunch)
//        }
//        else {
//            historyCell.setMealDetails(MealType.Dinner)
//        }
        
        //need to set the target of the feedback button appropriately
//        historyCell.buttonFullBottom.addTarget(self, action: "leaveFeedbackWasPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return mealCollectionCell
    }
    
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}

