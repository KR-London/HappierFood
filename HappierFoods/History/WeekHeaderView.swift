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
        print("hello there from SupView")
        backgroundColor = UIColor().HexToColor(hexString: "#93b5C6", alpha: 1.0)
        tintColor = UIColor().HexToColor(hexString: "#DDEDAA", alpha: 1.0)
        
    }
}
