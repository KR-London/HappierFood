//
//  detailContainer2.swift
//  HappierFoods
//
//  Created by Kate Roberts on 14/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class detailContainer2: UIView {

    lazy var foodLabel: UILabel = {
        let foodName = UILabel()
        foodName.font = UIFont(name: "07891284.ttf", size: 22)
        foodName.text = "Custom View"
        foodName.textAlignment = .center
        foodName.translatesAutoresizingMaskIntoConstraints = false
        return foodName
    }()
    
    lazy var foodPicture: UIImageView = {
        let pic = UIImageView()
        pic.image = UIImage(named: "chaos.jpg")
        pic.translatesAutoresizingMaskIntoConstraints = false
        return pic
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customViewItems()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        customViewItems()
    }
    
    func customViewItems(){
        backgroundColor = UIColor.orange
        addSubview(foodPicture)
        addSubview(foodLabel)
        applyLayoutConstraints(view1: foodPicture, view2: foodLabel)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyLayoutConstraints(view1 : UIView, view2: UIView)
    {
        NSLayoutConstraint.activate([
                view1.topAnchor.constraint(equalTo: topAnchor),
                view1.leadingAnchor.constraint(equalTo: leadingAnchor),
                view1.heightAnchor.constraint(equalTo: heightAnchor),
                view1.widthAnchor.constraint(equalTo: heightAnchor)
            ])
        
        NSLayoutConstraint.activate([
                view2.topAnchor.constraint(equalTo: topAnchor),
                view2.trailingAnchor.constraint(equalTo: trailingAnchor),
                view2.heightAnchor.constraint(equalTo: heightAnchor),
                view2.leadingAnchor.constraint(equalTo: view1.trailingAnchor)
            ])
    }
}
