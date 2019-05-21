//
//  detailContainer4.swift
//  HappierFoods
//
//  Created by Kate Roberts on 14/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class detailContainer4: UIView {
    
    
    lazy var motivation: UITextView = {
        let content = UITextView(frame: CGRect(x: 0, y: 10, width: 200, height: 40))
        content.text = "Motivation goes here Motivation goes here Motivation goes here Motivation goes here Motivation goes here Motivation goes here Motivation goes here Motivation goes here Motivation goes here Motivation goes here"
        content.font =  UIFont(name: "07891284.ttf", size: 22)
        content.textAlignment = .center
        content.translatesAutoresizingMaskIntoConstraints = false
        //content.textAlignment = .wrap
      //  content.borderStyle = UITextField.BorderStyle.line
        return content
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
        backgroundColor = UIColor.clear
        addSubview(motivation)
     //   motivation.placeholder = "Placeholder"
        layout(view: motivation)
        translatesAutoresizingMaskIntoConstraints = false
        // frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
    }
    
    func layout(view: UITextView) {
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.widthAnchor.constraint(equalTo: widthAnchor)
    ])
    }
}
