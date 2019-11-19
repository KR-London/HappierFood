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
    
//    @IBOutlet weak var instructionReminder: UIButton!
//    @IBOutlet weak var cellLabel: UILabel!
//
//    @IBOutlet weak var showDetailButtonProperties: UIButton!
//    @IBOutlet weak var tickImage: UIImageView!
//    @IBOutlet weak var cellImage: UIImageView!

  
    var instructionReminder: UIButton!
    var cellLabel: UILabel!
    var showDetailButtonProperties: UIButton!
    var tickImage: UIImageView!
    var cellImage: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    public func displayContent(image: String){
        cellImage.image = UIImage(named: image)
    }
    func setup(){
        //cellImage.image
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.cornerRadius = 5.0
        
        cellImage  = UIImageView()
        cellImage.contentMode = .scaleToFill
        cellImage.cornerRadius = 5
        self.addSubview(cellImage)
        instructionReminder =  UIButton(frame: CGRect(x:0, y:0, width:self.frame.width,height:self.frame.width))
        self.addSubview(instructionReminder)
        
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
             var frame = cellImage.frame
                   frame.size.height = self.frame.size.height
                   frame.size.width = self.frame.size.width
                   frame.origin.x = 0
                   frame.origin.y = 0
                   cellImage.frame = frame
    }
}
