//
//  mainCollectionViewCell.swift
//  HappierFoods
//
//  Created by Kate Roberts on 06/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class mainCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var textLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @IBOutlet weak var tickImage: UIImageView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBAction func button(_ sender: UIButton) {
    }
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    public func displayContent(image: String)
    {
        //        if foodImage.image != nil
        //        {
        //foodImage.image = maskImage(image: UIImage(named: image)!, mask: UIImage(named: "MASK.png")! )
        //}
        cellImage.image = UIImage(named: image)
        //  foodName.text = title
        // print("No ribbon should display \(title)")
    }
//    @IBOutlet var foodImage: UIImageView!
//    // @IBOutlet var foodName: UILabel!
    
//    public func displayContent(image: String, title: String)
//    {
//        //        if foodImage.image != nil
//        //        {
//        foodImage.image = maskImage(image: UIImage(named: image)!, mask: UIImage(named: "MASK.png")! )
//        //}
//        //foodImage.image = UIImage(named: image)
//        //  foodName.text = title
//        // print("No ribbon should display \(title)")
//    }
    
    func setup(){
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.cornerRadius = 5.0
    }
}
