//
//  detailContainer2.swift
//  HappierFoods
//
//  Created by Kate Roberts on 14/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class detailContainer2: UIView {

   // @IBOutlet weak var foodPicture: UIImageView!
  //  @IBOutlet weak var foodName: UILabel!
    
    lazy var foodLabel: UILabel = {
        let foodName = UILabel()
        foodName.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        foodName.text = "Custom View"
        foodName.textAlignment = .center
        foodName.translatesAutoresizingMaskIntoConstraints = false
        return foodName
    }()
    
    lazy var foodPicture: UIImageView = {
        let pic = UIImageView()
       // pic.frame = CGRect(x: 0, y: 0, width:50, height: 50)
        pic.image = UIImage(named: "chaos.jpg")
      //  pic.heightAnchor.constraint(equalToConstant: 100)
        pic.translatesAutoresizingMaskIntoConstraints = false
        return pic
    }()
    
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
        backgroundColor = UIColor.orange
        let stackView = UIStackView(arrangedSubviews: [foodPicture, foodLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.heightAnchor.constraint(equalToConstant: 400)
        stackView.translatesAutoresizingMaskIntoConstraints = false
      addSubview(stackView)
     // addSubview(foodPicture)
      // applyLayoutConstraintsNarrow(view: foodPicture)
        applyLayoutConstraints(view: stackView)
        translatesAutoresizingMaskIntoConstraints = false
        // frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
    }
    
    func applyLayoutConstraints(view : UIView)
    {
        NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: topAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
                view.heightAnchor.constraint(equalTo: heightAnchor),
            ])
        
    }
    
    func applyLayoutConstraintsNarrow(view : UIView)
    {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
             view.bottomAnchor.constraint(equalTo: bottomAnchor),
           // view.trailingAnchor.constraint(equalTo: trailingAnchor),
            //view.heightAnchor.constraint(equalTo: heightAnchor),
             view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
            ])
        
    }
    
}
