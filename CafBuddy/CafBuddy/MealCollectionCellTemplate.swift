//
//  CollectionListingTemplateCell.swift
//  Caf Buddy
//
//  Copyright (c) 2015 Caf Buddy. All rights reserved.
//

import Foundation
import UIKit


protocol MealCollectionCellCallBack {
    func mealCellButtonWasPressed(buttonIndex: Int, sectionIndex: Int) -> Void
}

// a standard meal cell with an spot for an image in the top left of the meal cell
// has a row of buttons on the bottom of the cell with an adjustable number of buttons (0 to unlimited)
// each button can be assigned text and an image
// also has a shadow around the cell
class MealCollectionCellTemplate : UICollectionViewCell {

    var imageMealType = UIImageView()
    var mealType : MealType?
    var buttons = [UIButton]()
    
    var numButtons = Int()
    var showImage = Bool()
    
    var cellSectionIndex = Int()
    
    var buttonCallBack : MealCollectionCellCallBack?
    
    //initializes everything in the cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setCellBorderAndShadow()
    }
    
    //this should never actually be called and is just there cause it has to be for some reason
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // create the shadow around each of the meal cells
    func setCellBorderAndShadow() {
        self.layer.cornerRadius = 3.0
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSizeMake(0, 0)
    }
    
    // initialize the buttons - this should be called from the subclass in the initializer
    func initializeButtonsAndImage(numButtonsInBar : Int, shouldShowImage : Bool) {
        numButtons = numButtonsInBar
        showImage = shouldShowImage
        
        if (showImage) {
            // no constraints here because this should be pretty static and not change much
            imageMealType.frame = CGRectMake(self.contentView.frame.width - 15 - 32, 10, 32, 32)
            self.contentView.addSubview(imageMealType)
        }
        
        let buttonHeight : CGFloat = 40
        for (var i = 0; i < numButtons; i++) {
            let button = UIButton()
            button.frame = CGRectMake(CGFloat(i)*(self.contentView.frame.width/CGFloat(numButtons)), self.contentView.frame.height - buttonHeight, self.contentView.frame.width/CGFloat(numButtons), buttonHeight)
            button.layer.cornerRadius = 3.0
            button.setBackgroundImage(getImageWithColor(COLOR_LIGHT_GRAY, width: self.contentView.frame.width, height: buttonHeight), forState: UIControlState.Normal)
            button.setBackgroundImage(getImageWithColor(COLOR_DARK_GRAY, width: self.contentView.frame.width, height: buttonHeight), forState: UIControlState.Highlighted)
            button.setBackgroundImage(getImageWithColor(COLOR_DARK_GRAY, width: self.contentView.frame.width, height: buttonHeight), forState: UIControlState.Selected)
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 25)
            // dont want left border on the first button
            if (i != 0) {
                let leftBorder : UIView = UIView(frame: CGRectMake(0, 0, 1, button.frame.size.height))
                leftBorder.backgroundColor = COLOR_DARK_GRAY
                button.addSubview(leftBorder)
            }
            //dont want right border on the last button
            if (i < numButtons - 1) {
                let rightBorder : UIView = UIView(frame: CGRectMake(button.frame.size.width, 0, 1, button.frame.size.height))
                rightBorder.backgroundColor = COLOR_DARK_GRAY
                button.addSubview(rightBorder)
            }
            button.tag = i;
            button.addTarget(self, action: "buttonWasPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            
            buttons.append(button)
        }
        
        for theButton in buttons {
            self.contentView.addSubview(theButton)
        }

    }
    
    func buttonWasPressed(sender : UIButton!) {
        buttonCallBack?.mealCellButtonWasPressed(sender.tag, sectionIndex: cellSectionIndex)
    }
    
    func decorateButton(withIndex index: Int, title: String, color : UIColor = COLOR_ACCENT_ONE, icon: UIImage? = nil, isClickable : Bool = true) {
        if (index > -1 && index < numButtons) {
            buttons[index].setTitle(title, forState: UIControlState.Normal)
            buttons[index].titleLabel?.font = UIFont.systemFontOfSize(15)
            buttons[index].setTitleColor(color, forState: UIControlState.Normal)
            if (icon != nil) {
                let newIcon = scaledImage(icon!, scaledToSize: CGSize(width: 20,height: 20))
                buttons[index].setImage(filledImageFrom(newIcon, color: color), forState: UIControlState.Normal)
            }
            buttons[index].enabled = isClickable
        }
    }
    
    func decorateImage(withImage image: UIImage, coloredAs color: UIColor) {
        if (showImage) {
            let newImage = scaledImage(image, scaledToSize: CGSize(width: 32,height: 32))
            imageMealType.image = filledImageFrom(newImage, color: COLOR_MAIN_DARK )
            
        }
    }
    
}
