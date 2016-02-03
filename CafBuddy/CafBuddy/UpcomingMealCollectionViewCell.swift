//
//  MealListingCell.swift
//  Caf Buddy
//
//  Created by Jacob Forster on 2/26/15.
//  Copyright (c) 2015 St. Olaf Acm. All rights reserved.
//
//
//import Foundation
//import UIKit
//
//class MealListingCell : CollectionListingTemplateCell {
//    
//    var labelMealDate = UILabel()
//    var labelMealTime = UILabel()
//    
//    
//    //initializes everything in the cell
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        initializeAdditionalCellContents()
//    }
//    //just needed to initialize the parent cell
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    
//    func initializeAdditionalCellContents() {
//        
//        /*additional meal details needed*/
//        labelMealDate.font = UIFont.systemFontOfSize(15)
//        labelMealDate.textAlignment = NSTextAlignment.Center
//        //labelMealType.textColor = colorWithHexString()
//        labelMealDate.frame = CGRectMake(0, labelMealType.frame.origin.y + labelMealType.frame.height + 10, contentView.frame.size.width, 20)
//        
//        labelMealTime.font = UIFont.systemFontOfSize(15)
//        labelMealTime.textAlignment = NSTextAlignment.Center
//        //labelMealType.textColor = colorWithHexString()
//        labelMealTime.frame = CGRectMake(0, labelMealDate.frame.origin.y + labelMealDate.frame.height + 5, contentView.frame.size.width, 20)
//        
//        
//        self.contentView.addSubview(labelMealDate)
//        self.contentView.addSubview(labelMealTime)
//        
//    }
//    
//    func setMealDetails(theMealType : MealType, theMealStatus : MealStatus) {
//        
//        
//        if (theMealStatus == MealStatus.Confirmed) {
//            
//            buttonFullBottom.hidden = true
//            buttonHalfBottomLeft.hidden = false
//            buttonHalfBottomRight.hidden = false
//            
//            buttonHalfBottomRight.setTitle("Chat W/ Buddy", forState: UIControlState.Normal)
//            buttonHalfBottomRight.setImage(filledImageFrom(UIImage(named: "chat2")!, colorWithHexString(COLOR_ACCENT_GREEN)), forState: UIControlState.Normal)
//            buttonHalfBottomRight.enabled = true
//            
//            buttonHalfBottomLeft.setTitle("Add To Calendar", forState: UIControlState.Normal)
//            buttonHalfBottomLeft.setImage(filledImageFrom(UIImage(named: "addCal")!, colorWithHexString(COLOR_ACCENT_GREEN)), forState: UIControlState.Normal)
//            buttonHalfBottomLeft.enabled = true
//        }
//        else {
//            
//            buttonHalfBottomRight.hidden = true
//            buttonHalfBottomLeft.hidden = true
//            buttonFullBottom.hidden = false
//            
//            //put the searching thing as the full button on the bottom of the screen
//            buttonFullBottom.setTitle("Searching For A Buddy...", forState: UIControlState.Normal)
//            buttonFullBottom.setImage(filledImageFrom(UIImage(named: "buddy")!, colorWithHexString(COLOR_ACCENT_GREEN)), forState: UIControlState.Normal)
//            buttonFullBottom.enabled = false
//        }
//        
//        labelMealDate.text = "Wednesday, September 2nd"
//        labelMealTime.text = "At 3:30 PM"
//    }
//    
//    
//    
//}