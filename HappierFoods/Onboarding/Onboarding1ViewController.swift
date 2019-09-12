//
//  Onboarding1ViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 13/07/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class Onboarding1ViewController: UINavigationController {

    lazy var happy: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "little dude1.png")
        return contentView
    }()
    
    lazy var block1: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "text 1 1.png")
        return contentView
    }()
    
    lazy var block2: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "text 1 2.png")
        return contentView
    }()
    
    lazy var block3: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "text 1 3.png")
        return contentView
    }()
    
    lazy var moveOnButton: UIButton = {
        let button = UIButton()
         button.backgroundColor = UIColor(red: 186/255, green: 242/255, blue: 206/255, alpha: 1)
        //button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
        button.setTitle("I'll give it a try", for: .normal)
        button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        return button
        }()

    override func viewDidLoad() {
        
        let margins = view.layoutMarginsGuide
        
        view.backgroundColor = UIColor(red: 224, green: 250, blue: 233, alpha: 1)
        self.navigationBar.isHidden = true
  
        view.addSubview(block1)
        block1.translatesAutoresizingMaskIntoConstraints = false
        block1.alpha = 0
        NSLayoutConstraint.activate(
            [
               // block1.topAnchor.constraint(equalTo: margins.topAnchor, constant: 15),
                block1.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor),
                block1.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                block1.heightAnchor.constraint(lessThanOrEqualTo: margins.heightAnchor, multiplier: 0.8/4.5),
                block1.widthAnchor.constraint(equalTo: block1.heightAnchor, multiplier: 640/169),
            ]
        )
        view.addSubview(happy)
        happy.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                happy.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor),
                happy.trailingAnchor.constraint(equalTo: block1.trailingAnchor),
                happy.heightAnchor.constraint(equalToConstant: 150),
                 happy.widthAnchor.constraint(equalToConstant: 150),
            ]
        )
        
        view.addSubview(block2)
        block2.translatesAutoresizingMaskIntoConstraints = false
        block2.alpha = 0
        NSLayoutConstraint.activate(
            [
                //block2.topAnchor.constraint(greaterThanOrEqualTo: block1.bottomAnchor),
               // block2.widthAnchor.constraint(equalTo: margins.widthAnchor),
                block2.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                block2.heightAnchor.constraint(lessThanOrEqualTo: margins.heightAnchor, multiplier: 0.8/4.5),
                block2.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor),
                block2.widthAnchor.constraint(equalTo: block2.heightAnchor, multiplier: 640/169)
            ]
        )

        view.addSubview(block3)
        block3.translatesAutoresizingMaskIntoConstraints = false
        block3.alpha = 0
        NSLayoutConstraint.activate(
            [
                //block3.topAnchor.constraint(greaterThanOrEqualTo: block2.bottomAnchor),
                //(block3.topAnchor-block2.bottomAnchor) = (block3.topAnchor-block2.bottomAnchor),
                //block3.widthAnchor.constraint(equalTo: margins.widthAnchor),
                block3.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                block3.heightAnchor.constraint(lessThanOrEqualTo: margins.heightAnchor, multiplier: (2.4*0.8)/4.5),
                block3.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor),
                block3.widthAnchor.constraint(equalTo: block3.heightAnchor, multiplier: 640/(3*169))
            ]
        )
        
        self.view.addSubview(moveOnButton)
        moveOnButton.translatesAutoresizingMaskIntoConstraints = false
        moveOnButton.addTarget(self, action: #selector(goOn), for: .touchUpInside)
        moveOnButton.alpha = 0
        NSLayoutConstraint.activate(
            [
                moveOnButton.bottomAnchor.constraint(lessThanOrEqualTo: margins.bottomAnchor),
                moveOnButton.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.8),
                moveOnButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                moveOnButton.heightAnchor.constraint(equalTo: block2.heightAnchor)
               /// moveOnButton.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 5/8),
                //moveOnButton.topAnchor.constraint(greaterThanOrEqualTo: block3.bottomAnchor, constant: 10)
            ]
        )
        
       // let totalHeights = block1.bounds.size.height + block2.bounds.size.height + block3.bounds.size.height + moveOnButton.bounds.size.height
      //  let spacer = ( self.view.frame.height - totalHeights)/5
        let ratio: CGFloat = 169*6/640
        let contentSize = self.view.frame.width*ratio
       // let content = ( self.view.frame.width as CGFloat)*ratio
        let spacer = ( self.view.frame.height - contentSize )/6
        print(self.view.frame.height)
       // print("total heights = ", totalHeights)
     //   print("spacer = ", spacer)
        
        
        NSLayoutConstraint.activate(
            [
                block1.topAnchor.constraint(equalTo: margins.topAnchor, constant:spacer),
                block2.topAnchor.constraint(equalTo: block1.bottomAnchor, constant:spacer),
                block3.topAnchor.constraint(equalTo: block2.bottomAnchor, constant:spacer),
                moveOnButton.topAnchor.constraint(equalTo: block3.bottomAnchor, constant:spacer),
                moveOnButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant:spacer)
            ]
        )
}

    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(true)
    
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)){
                let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                    self.block1.alpha = 1
                }
                animator.startAnimation()
            }
    
            /// fade it in & out with RH picture
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                    self.block2.alpha = 1
                }
                animator.startAnimation()
            }
    
            /// fade it in & out with RH picture
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
                let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                    self.block3.alpha = 1
                }
                animator.startAnimation()
            }
        
            /// fade it in & out with RH picture
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.moveOnButton.alpha = 1
            }
            animator.startAnimation()
        }
     }


@objc func goOn(sender: UIButton!) {


    
    performSegue(withIdentifier: "o1-o2", sender: self)
}
}
