//
//  HistoryCollectionViewCell.swift
//  HappierFoods
//
//  Created by Kate Roberts on 16/07/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImage: UIImageView!
    
    public func displayContent(image: String){
        foodImage.image = UIImage(named: image)
    }
    func setup(){
        //cellImage.image
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.cornerRadius = 5.0
    }
    
}
