//
//  MealHistoryViewController.swift
//  CafBuddy
//
//  Copyright © 2015 CafBuddy. All rights reserved.
//

import UIKit

class MealHistoryViewController: MainScreenViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MealAPICallback, MealCollectionCellCallBack {
    
    var collectionViewMeals : UICollectionView?
    
    let mealObject = Meal()
    
    var pastMeals = [MatchedMeal]()
    
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
        
        update()
    }
    
    
    // basically can have a little word in the top left denoting the sections.. split the sections by month and year but only display the year if the month is not in the current year
    // on each cell we can just say Breakfast on January 7th 2016..
    // with NAMES OF ALL THE PEOPLE...
    // no need for times since that is no longer relevant for them
    // have a How did it go? button - this bring you to a new screen where you can have a smiley face or a frowny face
    
}