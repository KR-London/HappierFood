//
//  topView.swift
//  HappierFoods
//
//  Created by Kate Roberts on 10/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class topView: UIView {
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        return button
    }()
    
    lazy var titleLabel : UILabel = {
        let content = UILabel()
        content.text = "Title"
        content.backgroundColor = UIColor.green
        return content
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        customViewItems()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customViewItems()    }
    
    
    func customViewItems(){
        backgroundColor = UIColor.green
        addSubview(backButton)
        addSubview(titleLabel)
        applyLayoutConstraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyLayoutConstraints()
    {
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            titleLabel.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            backButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
            
        ])
        
    }
}
