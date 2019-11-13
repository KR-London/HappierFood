//
//  confettiViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 13/11/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class confettiViewController: UIViewController {
    
      lazy var happyButton: UIButton = {
          var button = UIButton()
          button.setImage(#imageLiteral(resourceName: "little dude1.png"), for: .normal)
          return button
      }()
      
      /// bubble view
      lazy var bubbleBox: UIView = {
          let bubble = UIView()
          bubble.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
          return bubble
      }()
    
    /// bubble view
    lazy var moveOnButton: myButton = {
          let button = myButton()
          button.setTitle("I'm a superstar", for: .normal)
          button.titleLabel?.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24)
         button.addTarget(self, action: #selector(goHome), for: .touchUpInside)
          return button
      }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubview()
        showMessage(text: "Well done! Trying a new food is hard and you did it!")
        // Do any additional setup after loading the view.
    }
    
    func setUpSubview(){
        let margins = view.layoutMarginsGuide
        let myNav = self.navigationController
        
        let bubbleHeight = 0.5*(view.frame.height - (myNav?.navigationBar.frame.height ?? 0 ) )
        
        view.addSubview(moveOnButton)
        moveOnButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                 moveOnButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -10),
                 moveOnButton.heightAnchor.constraint(equalToConstant: bubbleHeight/4),
                 moveOnButton.widthAnchor.constraint(equalTo:margins.widthAnchor , multiplier: 0.65),
               //  moveOnButton.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.65),
                 moveOnButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor)
             ])
        
        view.addSubview(happyButton)
        happyButton.translatesAutoresizingMaskIntoConstraints = false
        happyButton.addTarget(self, action: #selector(happyWobble), for: .touchUpInside)
        NSLayoutConstraint.activate([
            happyButton.bottomAnchor.constraint(equalTo: moveOnButton.topAnchor, constant: -10),
            happyButton.heightAnchor.constraint(equalToConstant: bubbleHeight/3),
            happyButton.widthAnchor.constraint(equalToConstant: bubbleHeight/3),
            happyButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        ])
        
        view.addSubview(bubbleBox)
        bubbleBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bubbleBox.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor, constant: 10),
            bubbleBox.heightAnchor.constraint(lessThanOrEqualToConstant: bubbleHeight),
            bubbleBox.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 40),
            bubbleBox.leadingAnchor.constraint(equalTo: happyButton.trailingAnchor),
            bubbleBox.bottomAnchor.constraint(equalTo: happyButton.topAnchor, constant: 10)
        ])


}
    
    func showMessage(text: String) {
        
            let myNav = self.navigationController
            
           let bubbleHeight = 0.25*(view.frame.height - view.frame.width - (myNav?.navigationBar.frame.height ?? 0 ) )
            let label =  UILabel()
            
            label.numberOfLines = 0
            label.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24)
            label.text = text
            label.layoutIfNeeded()
            label.sizeToFit()

            let constraintRect = bubbleBox.frame.size
            let boundingBox = text.boundingRect(with: constraintRect,
                                                options: .usesLineFragmentOrigin,
                                                attributes: [.font: label.font],
                                                context: nil)
            label.frame.size = CGSize(width: ceil(view.frame.width - bubbleHeight - 30),
                                      height: ceil(bubbleHeight))

            let bubbleSize = CGSize(width: label.frame.width + 28,
                                         height: label.frame.height + 20)

            let bubbleView = BubbleView()
            bubbleView.frame.size = bubbleSize
            bubbleView.backgroundColor = .clear
            
            bubbleBox.addSubview(bubbleView)
            

            label.center = bubbleView.center
            bubbleView.addSubview(label)
            
            bubbleView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bubbleView.bottomAnchor.constraint(equalTo: bubbleBox.bottomAnchor, constant: -10),
                bubbleView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor)
               ])

        }
    
    @objc func happyWobble(){
        print("Make happy wobble here")
    }
    
    @objc func goHome(){
        navigationController?.popToRootViewController(animated: true)
    }
}
