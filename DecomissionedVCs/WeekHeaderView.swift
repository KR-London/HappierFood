//
//  WeekHeaderView.swift
//  HappierFoods
//
//  Created by Kate Roberts on 18/07/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class WeekHeaderView: UICollectionReusableView {
    
    //////////////////////////////////////////////////////////////////////////////
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.myCustomInit()
    }
    
    //////////////////////////////////////////////////////////////////////////////
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.myCustomInit()
    }
    
    @IBOutlet weak var weekLabel: UILabel!
    
    func myCustomInit() {
        backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
        
       // R95 G215 B176
        tintColor = UIColor().HexToColor(hexString: "#DDEDAA", alpha: 1.0)
        
    }
}
