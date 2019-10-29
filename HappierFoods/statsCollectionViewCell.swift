//
//  statsCollectionViewCell.swift
//  HappierFoods
//
//  Created by Kate Roberts on 29/10/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class statsCollectionViewCell: UICollectionViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    public func displayContent(image: String){
       // cellImage.image = UIImage(named: image)
    }
    func setup(){
        //cellImage.image
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        self.layer.cornerRadius = 5.0
    }
}
