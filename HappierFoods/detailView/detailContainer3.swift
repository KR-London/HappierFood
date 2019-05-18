//
//  detailContainer3.swift
//  HappierFoods
//
//  Created by Kate Roberts on 14/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class detailContainer3: UIView {

    lazy var DateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont(name: "07891284.ttf", size: 22)
        dateLabel.text = "Your rating"
        dateLabel.textAlignment = .center
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()

    lazy var TopFaceView: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "eyeOpen_browDownLeft.png")
//contentView.image = UIImage(named: "chaos.jpg")
         contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    lazy var BottomFaceView: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "face.png")
        //contentView.image = UIImage(named: "chaos.jpg")
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
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
        backgroundColor = UIColor.yellow
        addSubview(DateLabel)
        addSubview(BottomFaceView)
        addSubview(TopFaceView)
//addSubview()
        applyLayoutConstraints(view1: DateLabel, view2: TopFaceView, view3: BottomFaceView)
        //applyLayoutConstraints2(view2: TopFaceView)
        translatesAutoresizingMaskIntoConstraints = false
        // frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
    }
    
    func applyLayoutConstraints(view1 : UIView, view2: UIView, view3: UIView)
    {
        NSLayoutConstraint.activate([
            view1.topAnchor.constraint(equalTo: topAnchor),
            view1.leadingAnchor.constraint(equalTo: leadingAnchor),
            view1.heightAnchor.constraint(equalTo: heightAnchor),
            view1.trailingAnchor.constraint(equalTo: view2.leadingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            view2.topAnchor.constraint(equalTo: topAnchor),
            view2.trailingAnchor.constraint(equalTo: trailingAnchor),
            view2.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            view2.widthAnchor.constraint(equalTo: heightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            view3.topAnchor.constraint(equalTo: view2.topAnchor),
            view3.bottomAnchor.constraint(equalTo: view1.bottomAnchor),
            view3.leadingAnchor.constraint(equalTo: view2.leadingAnchor),
            view3.trailingAnchor.constraint(equalTo: view2.trailingAnchor),
            ])
    }
    
    func applyLayoutConstraints2(view2: UIView)
    {
        NSLayoutConstraint.activate([
            view2.topAnchor.constraint(equalTo: topAnchor),
            view2.trailingAnchor.constraint(equalTo: trailingAnchor),
            view2.heightAnchor.constraint(equalTo: heightAnchor),
            view2.widthAnchor.constraint(equalTo: heightAnchor)
            ])
    }

}


