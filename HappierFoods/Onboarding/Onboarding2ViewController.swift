//
//  Onboarding2ViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 13/07/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class Onboarding2ViewController: UINavigationController {

    lazy var block1: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "screen2_Block1.jpg")
        return contentView
    }()
    
    lazy var block2: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "screen2_block2.jpg")
        return contentView
    }()
    
    lazy var block3: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "screen2_block3.jpg")
        return contentView
    }()
    
    lazy var moveOnButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("....Okay....", for: .normal)
        button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        view.addSubview(block1)
        block1.translatesAutoresizingMaskIntoConstraints = false
        block1.alpha = 0
        NSLayoutConstraint.activate(
            [
                block1.topAnchor.constraint(equalTo: self.view.topAnchor),
                block1.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                block1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                block1.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3)
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
                block2.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3)
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
                block3.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3)
            ]
        )
        
        self.view.addSubview(moveOnButton)
        moveOnButton.translatesAutoresizingMaskIntoConstraints = false
        moveOnButton.addTarget(self, action: #selector(goOn), for: .touchUpInside)
        moveOnButton.alpha = 0
        NSLayoutConstraint.activate(
            [
                moveOnButton.topAnchor.constraint(equalTo: block3.bottomAnchor),
                moveOnButton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                moveOnButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                moveOnButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.block2.alpha = 1
            }
            animator.startAnimation()
        }
        
        /// fade it in & out with RH picture
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(9)){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.block3.alpha = 1
            }
            animator.startAnimation()
        }
        
        /// fade it in & out with RH picture
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(12)){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.moveOnButton.alpha = 1
            }
            animator.startAnimation()
        }
    }
    
    
    @objc func goOn(sender: UIButton!) {
        performSegue(withIdentifier: "o2-o3", sender: self)
    }

}
