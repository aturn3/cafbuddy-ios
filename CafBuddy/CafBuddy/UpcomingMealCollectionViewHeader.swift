//
//  UpcomingMealCollectionViewHeader.swift
//  CafBuddy
//
//  Copyright © 2016 CafBuddy. All rights reserved.
//

import Foundation

class UpcomingMealCollectionViewHeader : UICollectionReusableView {
    
    var headerTitle = UILabel()
    
    func setTitle(title: String, sectionIndex : Int) {
        headerTitle.text = title
        headerTitle.font = UIFont.boldSystemFontOfSize(14)
        headerTitle.textColor = COLOR_MAIN_DARK
        headerTitle.textAlignment = NSTextAlignment.Center        
        headerTitle.frame = CGRectMake(0, 10, self.frame.size.width, 20)
        
        self.addSubview(headerTitle)
        
    }
    
}