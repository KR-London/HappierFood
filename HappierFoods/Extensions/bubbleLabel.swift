//
//  bubbleLabel.swift
//  HappierFoods
//
//  Created by Kate Roberts on 02/12/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//override func drawText(in rect: CGRect) {
//    let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//    super.drawText(in: rect.inset(by: insets))
//}

import UIKit

class bubbleLabel: UILabel {

   required init(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)!
       self.setup()
   }


   override init(frame: CGRect){
       super.init(frame: frame)
       self.setup()
   }

   override func awakeFromNib() {
       super.awakeFromNib()
       self.setup()
   }

   func setup(){
       self.text = self.text
       self.textColor = self.textColor
       self.font = self.font
       self.layer.display()
   }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.drawText(in: rect.inset(by: insets))
    }
}
