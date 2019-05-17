//
//  detailView.swift
//  HappierFoods
//
//  Created by Kate Roberts on 13/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        customViewItems()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customViewItems()
    }
    
    func customViewItems(){
        backgroundColor = UIColor.green
    }
    
    //override var backgroundColor: UIColor?

    /// Section 1: Top amber bar
    
    /// Section 2: Photo and food name
    
    /// Section 3: If it's a tried food tapped - the faceview and the date
    //              If it's the target food tapped - placeholder for "high level nutritional information or inspirational quote goes here"
    
    /// Section 4: Notes Section
    
    /// Section 5: Stack of buttons
}
