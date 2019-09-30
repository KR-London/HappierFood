//
//  myButton.swift
//  HappierFoods
//
//  Created by Kate Roberts on 27/09/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class myButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setColorScheme()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
      //  fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        layer.cornerRadius = 5
    }

    private func setColorScheme() {

        self.backgroundColor = UIColor(red: 186/255, green: 242/255, blue: 206/255, alpha: 1)
        self.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        self.tintColor = UIColor(red: 3/255, green: 18/255, blue: 8/255, alpha: 1)
        self.setTitleColor( (UIColor(red: 3/255, green: 18/255, blue: 8/255, alpha: 1)), for: .normal)
    }

//   override func awakeFromNib() {
//      layer.cornerRadius = 4
//      backgroundColor = UIColor(red: 0.75, green: 0.20, blue: 0.19, alpha: 1.0)
//    }

}
