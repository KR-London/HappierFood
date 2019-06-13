//
//  topView.swift
//  HappierFoods
//
//  Created by Kate Roberts on 10/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class topView: UIView{
  
    
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        //button.backgroundColor = UIColor.yellow
        button.setTitle("< Back", for: .normal)
        button.titleLabel?.font  = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    lazy var titleLabel : UILabel = {
        let content = UILabel()
        content.text = "Well Done!!!"
        content.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 30 )
        content.textAlignment = .center
       // content.backgroundColor = UIColor.blue
        content.translatesAutoresizingMaskIntoConstraints = false

        return content
    }()
    
    lazy var shareButton : UIButton = {
        let button = UIButton()
        //button.backgroundColor = UIColor.red
        button.setImage(UIImage(named: "share.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
       // button.addTarget(self, action: #selector(share), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        customViewItems()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customViewItems()    }
    
    
    func customViewItems(){
        backgroundColor = UIColor(red: 245/255.0, green: 192/255.0, blue: 106/255.0, alpha: 1.0)
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(shareButton)
        applyLayoutConstraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// this is terrible coding. I shouldn't have this in a view file.
    @objc func share(){
        print("I'm sharing")
        let whatHaveITried = "My target is to try: RICE. I tried CARROTS on TUESDAY. I tried CARROTS on THURSDAY. "
        
        let activityViewController =
            UIActivityViewController(activityItems: [whatHaveITried],
                                     applicationActivities: nil)
        
        let vc = UIViewController()
        
        vc.present(activityViewController, animated: true)
    }
    
    func applyLayoutConstraints()
    {
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            titleLabel.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            backButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            backButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
            
        ])
        
        NSLayoutConstraint.activate([
            shareButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            shareButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            shareButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            shareButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
            
            ])

        
    }
}
