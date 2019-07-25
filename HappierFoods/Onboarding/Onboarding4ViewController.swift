//
//  Onboarding4ViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 13/07/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class Onboarding4ViewController: UINavigationController {

//    lazy var block1: UIImageView = {
//        let contentView = UIImageView()
//        contentView.image = UIImage(named: "areYouReady1.jpg")
//        return contentView
//    }()
//
//    lazy var block2: UIImageView = {
//        let contentView = UIImageView()
//        contentView.image = UIImage(named: "areYouReady2.jpg")
//        return contentView
//    }()
//
//    lazy var block3: UIImageView = {
//        let contentView = UIImageView()
//        contentView.image = UIImage(named: "screen2_block3.jpg")
//        return contentView
//    }()
//
//    lazy var moveOnButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = UIColor.blue
//        button.setTitle("....Okay....", for: .normal)
//        button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
//
//        return button
//    }()
//
//    override func viewDidLoad() {
//        view.backgroundColor = UIColor.white
//        view.addSubview(block1)
//        block1.translatesAutoresizingMaskIntoConstraints = false
//        block1.alpha = 0
//        NSLayoutConstraint.activate(
//            [
//                block1.topAnchor.constraint(equalTo: self.view.topAnchor),
//                block1.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//                block1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//                block1.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3)
//            ]
//        )
//        view.addSubview(block2)
//        block2.translatesAutoresizingMaskIntoConstraints = false
//        block2.alpha = 0
//        NSLayoutConstraint.activate(
//            [
//                block2.topAnchor.constraint(equalTo: block1.bottomAnchor),
//                block2.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//                block2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//                block2.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3)
//            ]
//        )
//
//        view.addSubview(block3)
//        block3.translatesAutoresizingMaskIntoConstraints = false
//        block3.alpha = 0
//        NSLayoutConstraint.activate(
//            [
//                block3.topAnchor.constraint(equalTo: block2.bottomAnchor),
//                block3.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//                block3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//                block3.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3)
//            ]
//        )
//
//        self.view.addSubview(moveOnButton)
//        moveOnButton.translatesAutoresizingMaskIntoConstraints = false
//        moveOnButton.addTarget(self, action: #selector(goOn), for: .touchUpInside)
//        moveOnButton.alpha = 0
//        NSLayoutConstraint.activate(
//            [
//                moveOnButton.topAnchor.constraint(equalTo: block3.bottomAnchor),
//                moveOnButton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//                moveOnButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//                moveOnButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1)
//            ]
//        )
//
//    }
//
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)){
//            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
//                self.block1.alpha = 1
//            }
//            animator.startAnimation()
//        }
//
//        /// fade it in & out with RH picture
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)){
//            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
//                self.block2.alpha = 1
//            }
//            animator.startAnimation()
//        }
//
//        /// fade it in & out with RH picture
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(9)){
//            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
//                self.block3.alpha = 1
//            }
//            animator.startAnimation()
//        }
//
//        /// fade it in & out with RH picture
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(12)){
//            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
//                self.moveOnButton.alpha = 1
//            }
//            animator.startAnimation()
//        }
//    }
//
//
//    @objc func goOn(sender: UIButton!) {
//        performSegue(withIdentifier: "o4-o5", sender: self)
//    }
    
    lazy var happy: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "little dude3.png")
        return contentView
    }()

    lazy var block1: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "speech.png")
        return contentView
    }()
    
    
    lazy var b1: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
          //  R95 G215 B176  )
       // button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
        button.setTitle("Try Food", for: .normal)
        button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        return button
    }()
    
    lazy var b2: UIButton = {
        let button = UIButton()
          button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
        button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
        button.setTitle("Not Eating Now", for: .normal)
        button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        return button
    }()
    
    
    
    lazy var block2: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "speech 2.png")
        return contentView
    }()
    
    
    override func viewDidLoad() {
               view.backgroundColor = UIColor(red: 224, green: 250, blue: 233, alpha: 1)
        let margins = view.layoutMarginsGuide
        view.addSubview(block1)
        block1.translatesAutoresizingMaskIntoConstraints = false
        block1.alpha = 0
        NSLayoutConstraint.activate(
            [
                //block1.topAnchor.constraint(equalTo: self.view.topAnchor),
                block1.widthAnchor.constraint(equalTo: margins.widthAnchor),
                block1.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                block1.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.3)
            ]
        )
        
        view.addSubview(happy)
        happy.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                happy.centerYAnchor.constraint(equalTo: block1.bottomAnchor),
                happy.trailingAnchor.constraint(equalTo: block1.trailingAnchor),
                happy.heightAnchor.constraint(equalToConstant: 150),
                happy.widthAnchor.constraint(equalToConstant: 150),
            ]
        )
        
        self.view.addSubview(b1)
        b1.translatesAutoresizingMaskIntoConstraints = false
        b1.addTarget(self, action: #selector(trying), for: .touchUpInside)
        b1.alpha = 0
        NSLayoutConstraint.activate(
            [
                b1.topAnchor.constraint(equalTo: block1.bottomAnchor, constant: 20),
                b1.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.45),
                b1.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
                b1.leadingAnchor.constraint(equalTo: margins.leadingAnchor , constant: 5),
                b1.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.2)
            ]
        )
        
        self.view.addSubview(b2)
        b2.translatesAutoresizingMaskIntoConstraints = false
        b2.addTarget(self, action: #selector(noTry), for: .touchUpInside)
        b2.alpha = 0
        NSLayoutConstraint.activate(
            [
                b2.topAnchor.constraint(equalTo: block1.bottomAnchor, constant: 20),
                b2.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.45),
                b2.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
                b2.trailingAnchor.constraint(equalTo: margins.trailingAnchor , constant: -5),
                b2.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.2)
            ]
        )
        
        
        
        view.addSubview(block2)
        block2.translatesAutoresizingMaskIntoConstraints = false
        block2.alpha = 0
        NSLayoutConstraint.activate(
            [
                block2.topAnchor.constraint(equalTo: b1.bottomAnchor, constant: 20),
                block2.widthAnchor.constraint(equalTo: margins.widthAnchor),
                block2.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                block2.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.3)
            ]
        )
        
        /// fade it in & out with RH picture
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
                self.b1.alpha = 1
                self.b2.alpha = 1
            }
            animator.startAnimation()
        }
        
        
    }
    
    @objc func trying(sender: UIButton!) {
        performSegue(withIdentifier: "try", sender: self)
    }
    
    
    @objc func noTry(sender: UIButton!) {
        performSegue(withIdentifier: "noTry", sender: self)
    }
    
}
