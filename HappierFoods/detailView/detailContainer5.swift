//
//  detailContainer5.swift
//  HappierFoods
//
//  Created by Kate Roberts on 14/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class detailContainer5: UIView {
    
    lazy var deleteButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = UIColor.red
        button.titleLabel?.text = "Delete Record"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        backgroundColor = UIColor.blue
        addSubview(deleteButton)
        layoutButtons(deleteButton: deleteButton)
        translatesAutoresizingMaskIntoConstraints = false
        // frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
    }
    
    func layoutButtons(deleteButton: UIButton)
    {
        NSLayoutConstraint.activate([
                deleteButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                deleteButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
                deleteButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
                deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
      
    }

}
