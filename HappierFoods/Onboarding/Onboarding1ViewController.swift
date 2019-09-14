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
                block1.widthAnchor.constraint(equalTo: margins.widthAnchor),
                block1.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                block1.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 169/640)
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
                block2.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                block2.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 169/640),
                block2.widthAnchor.constraint(equalTo: margins.widthAnchor),
            ]
        )

        view.addSubview(block3)
        block3.translatesAutoresizingMaskIntoConstraints = false
        block3.alpha = 0
        NSLayoutConstraint.activate(
            [
                block3.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                block3.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 419/640),
                block3.widthAnchor.constraint(equalTo: margins.widthAnchor)
            ]
        )
        
        self.view.addSubview(moveOnButton)
        moveOnButton.translatesAutoresizingMaskIntoConstraints = false
        moveOnButton.addTarget(self, action: #selector(goOn), for: .touchUpInside)
        moveOnButton.alpha = 0
        NSLayoutConstraint.activate(
            [
                moveOnButton.bottomAnchor.constraint(lessThanOrEqualTo: margins.bottomAnchor),
                moveOnButton.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.9),
                moveOnButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                moveOnButton.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 1/6 )
            ]
        )
        
        let ratio: CGFloat = (169 + 169 + 419 + (self.view.frame.width/6) )/640
        let contentSize = self.view.frame.width*ratio
        let spacer = ( self.view.frame.height - contentSize )/5

        NSLayoutConstraint.activate(
            [
                block1.topAnchor.constraint(equalTo: margins.topAnchor, constant:spacer),
                block2.topAnchor.constraint(equalTo: block1.bottomAnchor, constant:spacer),
                block3.topAnchor.constraint(equalTo: block2.bottomAnchor, constant:spacer),
                moveOnButton.topAnchor.constraint(equalTo: block3.bottomAnchor, constant:spacer),
                moveOnButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -spacer)
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
