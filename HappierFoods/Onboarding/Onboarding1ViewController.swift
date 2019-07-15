//
//  Onboarding1ViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 13/07/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class Onboarding1ViewController: UINavigationController {

    lazy var block1: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "hello2.jpg")
        return contentView
    }()
    
    lazy var block2: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "this_app_is_for_people2.jpg")
        return contentView
    }()
    
    lazy var block3: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "nerds2.jpg")
        return contentView
    }()
    
    lazy var moveOnButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = UIColor.blue
            button.setTitle("I'll give it a try", for: .normal)
            button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )

            return button
        }()

    override func viewDidLoad() {
        
        let margins = view.layoutMarginsGuide
        
        view.backgroundColor = UIColor.white
        view.addSubview(block1)
        block1.translatesAutoresizingMaskIntoConstraints = false
        block1.alpha = 0
        NSLayoutConstraint.activate(
            [
                block1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
                block1.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                block1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                block1.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.8/4.5)
            ]
        )
        view.addSubview(block2)
        block2.translatesAutoresizingMaskIntoConstraints = false
        block2.alpha = 0
        NSLayoutConstraint.activate(
            [
                block2.topAnchor.constraint(equalTo: block1.bottomAnchor),
                block2.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                block2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                block2.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.8/4.5)
            ]
        )

        view.addSubview(block3)
        block3.translatesAutoresizingMaskIntoConstraints = false
        block3.alpha = 0
        NSLayoutConstraint.activate(
            [
                block3.topAnchor.constraint(equalTo: block2.bottomAnchor),
                block3.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                block3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                block3.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: (2.5*0.8)/4.5)
            ]
        )
        
        self.view.addSubview(moveOnButton)
        moveOnButton.translatesAutoresizingMaskIntoConstraints = false
        moveOnButton.addTarget(self, action: #selector(goOn), for: .touchUpInside)
        moveOnButton.alpha = 0
        NSLayoutConstraint.activate(
            [
                moveOnButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                moveOnButton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                moveOnButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                moveOnButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2)
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
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
                let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                    self.block2.alpha = 1
                }
                animator.startAnimation()
            }
    
            /// fade it in & out with RH picture
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(7)){
                let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                    self.block3.alpha = 1
                }
                animator.startAnimation()
            }
        
            /// fade it in & out with RH picture
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)){
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
