//
//  confettiViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 13/11/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class confettiViewController: UIViewController {
    
        var message : String?
    
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
    
    var imagePlaceholder = UIImage()
    
    lazy var foodImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy var foodName: UILabel = {
        let label = UILabel()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 224/255, green: 250/255, blue: 233/255, alpha: 1)
        setUpSubview()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showMessage(text: message ?? "That's fantastic progress!")
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
                 moveOnButton.widthAnchor.constraint(equalTo:margins.widthAnchor , multiplier: 1),
               //  moveOnButton.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.65),
                 moveOnButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor)
             ])
        
        view.addSubview(happyButton)
        happyButton.translatesAutoresizingMaskIntoConstraints = false
        happyButton.addTarget(self, action: #selector(happyWobble), for: .touchUpInside)
        NSLayoutConstraint.activate([
            happyButton.bottomAnchor.constraint(equalTo: moveOnButton.topAnchor, constant: -10),
            happyButton.heightAnchor.constraint(lessThanOrEqualToConstant: bubbleHeight/3),
            happyButton.widthAnchor.constraint(equalToConstant: bubbleHeight/3),
            happyButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        ])
        
        view.addSubview(bubbleBox)
        bubbleBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bubbleBox.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor, constant: 10),
            bubbleBox.heightAnchor.constraint(lessThanOrEqualToConstant: bubbleHeight),
            bubbleBox.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -40),
            bubbleBox.leadingAnchor.constraint(equalTo: happyButton.trailingAnchor),
            bubbleBox.bottomAnchor.constraint(equalTo: happyButton.topAnchor, constant: 10)
        ])

        if imagePlaceholder != nil{
            foodImage.image = imagePlaceholder
            view.addSubview(foodImage)
            foodImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                    foodImage.bottomAnchor.constraint(lessThanOrEqualTo: bubbleBox.topAnchor, constant: -10),
                    foodImage.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                    foodImage.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor, constant: 30),
                    foodImage.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor, multiplier: 0.6),
                    foodImage.heightAnchor.constraint(equalTo: foodImage.widthAnchor)
                ])
        }

}
    
    func showMessage(text: String) {
        
            let myNav = self.navigationController
            
            let bubbleHeight = 0.35*(view.frame.height - view.frame.width - (myNav?.navigationBar.frame.height ?? 0 ) )
            let label =  bubbleLabel()
            
            label.numberOfLines = 0
            label.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 18)
            label.text = text
            label.textColor = UIColor(red: 3/255, green: 18/255, blue: 8/255, alpha: 1)
            label.adjustsFontSizeToFitWidth = true
            label.layoutIfNeeded()
            label.sizeToFit()

            let constraintRect = bubbleBox.frame.size
            //let boundingBox = text.boundingRect(with: constraintRect,
//                                                options: .usesLineFragmentOrigin,
//                                                attributes: [.font: label.font],
//                                                context: nil)
            label.frame.size = CGSize(width: ceil(view.frame.width - bubbleHeight - 50),
                                      height: ceil(bubbleHeight))

            let bubbleSize = CGSize(width: label.frame.width + 10,
                                         height: label.frame.height + 20)

            let bubbleView = BubbleView()
            bubbleView.frame.size = bubbleSize
            bubbleView.backgroundColor = .clear
            
            bubbleBox.addSubview(bubbleView)
            

            label.center = bubbleView.center
            bubbleView.addSubview(label)
            
            bubbleView.translatesAutoresizingMaskIntoConstraints = true
            NSLayoutConstraint.activate([
                bubbleView.bottomAnchor.constraint(lessThanOrEqualTo: happyButton.topAnchor, constant: 10),
                bubbleView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
                bubbleView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 10),
                bubbleView.centerXAnchor.constraint(equalTo: bubbleBox.centerXAnchor)
               ])

        }
    
    @objc func happyWobble(){
        print("Make happy wobble here")
    }
    
    func formatImage(){
        imagePlaceholder = imagePlaceholder.cropImageToSquare()
        foodImage.image = imagePlaceholder
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        foodImage.contentMode = .scaleAspectFill
        foodImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        foodImage.cornerRadius = 5
    }
    
    @objc func goHome(){
        weak var main = navigationController?.viewControllers[0] as? newMainViewController
        main?.isRainingConfetti = true
        main?.reloadInputViews()
        navigationController?.popToRootViewController(animated: true)
    }
}
