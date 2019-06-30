//
//  mainCollectionViewCell.swift
//  HappierFoods
//
//  Created by Kate Roberts on 06/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class mainCollectionViewCell: UICollectionViewCell {
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @IBOutlet weak var showDetailButtonProperties: UIButton!
    @IBOutlet weak var tickImage: UIImageView!
    @IBOutlet weak var cellImage: UIImageView!

    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    public func displayContent(image: String){
        cellImage.image = UIImage(named: image)
    }
    func setup(){
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.cornerRadius = 5.0
    }
}
