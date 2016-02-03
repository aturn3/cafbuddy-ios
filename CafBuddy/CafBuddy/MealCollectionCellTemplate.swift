//
//  CollectionListingTemplateCell.swift
//  Caf Buddy
//
//  Created by Jacob Forster on 3/29/15.
//  Copyright (c) 2015 St. Olaf Acm. All rights reserved.
//

import Foundation
import UIKit


class MealCollectionCellTemplate : UICollectionViewCell {
    
    var labelMealType = UILabel()
    var imageMealType = UIImageView()
    var buttonHalfBottomRight = UIButton()
    var buttonHalfBottomLeft = UIButton()
    var buttonFullBottom = UIButton()
    
    //initializes everything in the cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBorderDecoration()
        initializeCellContents()
        
    }
    
    //this should never actually be called and is just there cause it has to be for some reason
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBorderDecoration() {
        
        self.layer.cornerRadius = 3.0
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSizeMake(0, 0)
        
    }
    
    func initializeCellContents() {
        
//        imageMealType.frame = CGRectMake(15, 10, 32, 32)
//        
//        var endOfImage = imageMealType.frame.origin.x + imageMealType.frame.width
//        labelMealType.font = UIFont.systemFontOfSize(22)
//        labelMealType.textAlignment = NSTextAlignment.Center
//        labelMealType.frame = CGRectMake(0, 17.5, contentView.frame.size.width, 20)
//        
//        
//        var buttonHeight : CGFloat = 40
//        var buttonTextSize : CGFloat = 13;
//        if (UIScreen.mainScreen().bounds.width < 375) {
//            buttonTextSize = 11 //need to accomodate the smaller screen width on iphone 5 and below
//        }
//        
//        buttonHalfBottomRight.frame = CGRectMake(self.contentView.frame.width/2, self.contentView.frame.height - buttonHeight, self.contentView.frame.width/2, buttonHeight)
//        buttonHalfBottomRight.layer.cornerRadius = 3.0
//        buttonHalfBottomRight.setBackgroundImage(getImageWithColor(colorWithHexString(COLOR_BUTTON_UNPRESSED_GRAY), CGSizeMake(self.contentView.frame.width, buttonHeight)), forState: UIControlState.Normal)
//        buttonHalfBottomRight.setBackgroundImage(getImageWithColor(colorWithHexString(COLOR_BUTTON_PRESSED_GRAY), CGSizeMake(self.contentView.frame.width, buttonHeight)), forState: UIControlState.Highlighted)
//        buttonHalfBottomRight.setBackgroundImage(getImageWithColor(colorWithHexString(COLOR_BUTTON_PRESSED_GRAY), CGSizeMake(self.contentView.frame.width, buttonHeight)), forState: UIControlState.Selected)
//        buttonHalfBottomRight.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 25)
//        buttonHalfBottomRight.setTitleColor(colorWithHexString(COLOR_ACCENT_GREEN), forState: UIControlState.Normal)
//        buttonHalfBottomRight.titleLabel?.font = UIFont.systemFontOfSize(buttonTextSize)
//        var leftBorder : UIView = UIView(frame: CGRectMake(1, 0, 1, buttonHalfBottomRight.frame.size.height))
//        leftBorder.backgroundColor = colorWithHexString(COLOR_BUTTON_PRESSED_GRAY)
//        buttonHalfBottomRight.addSubview(leftBorder)
//        
//        
//        buttonHalfBottomLeft.frame = CGRectMake(0, self.contentView.frame.height - buttonHeight, self.contentView.frame.width/2, buttonHeight)
//        buttonHalfBottomLeft.layer.cornerRadius = 3.0
//        //buttonChatAndStatus.backgroundColor = colorWithHexString(COLOR_BUTTON_UNPRESSED_GRAY)
//        buttonHalfBottomLeft.setBackgroundImage(getImageWithColor(colorWithHexString(COLOR_BUTTON_UNPRESSED_GRAY), CGSizeMake(self.contentView.frame.width, buttonHeight)), forState: UIControlState.Normal)
//        buttonHalfBottomLeft.setBackgroundImage(getImageWithColor(colorWithHexString(COLOR_BUTTON_PRESSED_GRAY), CGSizeMake(self.contentView.frame.width, buttonHeight)), forState: UIControlState.Highlighted)
//        buttonHalfBottomLeft.setBackgroundImage(getImageWithColor(colorWithHexString(COLOR_BUTTON_PRESSED_GRAY), CGSizeMake(self.contentView.frame.width, buttonHeight)), forState: UIControlState.Selected)
//        buttonHalfBottomLeft.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 25)
//        buttonHalfBottomLeft.setTitleColor(colorWithHexString(COLOR_ACCENT_GREEN), forState: UIControlState.Normal)
//        buttonHalfBottomLeft.titleLabel?.font = UIFont.systemFontOfSize(buttonTextSize)
//        
//        var rightBorder : UIView = UIView(frame: CGRectMake(buttonHalfBottomLeft.frame.size.width, 0, 1, buttonHalfBottomLeft.frame.size.height))
//        rightBorder.backgroundColor = colorWithHexString(COLOR_BUTTON_PRESSED_GRAY)
//        buttonHalfBottomLeft.addSubview(rightBorder)
//        
//        
//        buttonFullBottom.frame = CGRectMake(0, self.contentView.frame.height - buttonHeight, self.contentView.frame.width, buttonHeight)
//        buttonFullBottom.layer.cornerRadius = 3.0
//        buttonFullBottom.backgroundColor = colorWithHexString(COLOR_BUTTON_UNPRESSED_GRAY)
//        buttonFullBottom.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25)
//        buttonFullBottom.setTitleColor(colorWithHexString(COLOR_ACCENT_GREEN), forState: UIControlState.Normal)
//        buttonFullBottom.titleLabel?.font = UIFont.systemFontOfSize(13)
//        
//        self.contentView.addSubview(labelMealType)
//        self.contentView.addSubview(imageMealType)
//        self.contentView.addSubview(buttonHalfBottomRight)
//        self.contentView.addSubview(buttonHalfBottomLeft)
//        self.contentView.addSubview(buttonFullBottom)
//        
    }
    
//    func setMealDetails(theMealType : MealType) {
//        
//        if (theMealType == MealType.Dinner) {
//            labelMealType.text = "Dinner";
//            imageMealType.image = filledImageFrom(UIImage(named: "steak")!, colorWithHexString(COLOR_DARKER_BLUE))
//        }
//        else if (theMealType == MealType.Lunch){
//            labelMealType.text = "Lunch"
//            imageMealType.image = filledImageFrom(UIImage(named: "apple")!, colorWithHexString(COLOR_DARKER_BLUE))
//        }
//        else {
//            labelMealType.text = "Breakfast"
//            imageMealType.image = filledImageFrom(UIImage(named: "toast")!, colorWithHexString(COLOR_DARKER_BLUE))
//        }
//    }
    
    
    
}
