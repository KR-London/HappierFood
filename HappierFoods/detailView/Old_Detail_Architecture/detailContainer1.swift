//
//  detailContainer1.swift
//  HappierFoods
//
//  Created by Kate Roberts on 14/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class detailContainer1: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        customViewItems()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customViewItems()
    }
    
    func customViewItems(){
       // backgroundColor = UIColor.blue
        translatesAutoresizingMaskIntoConstraints = false
       // frame = CGRect(x: 100, y: 100, width: 100, height: 100)

    }

}
