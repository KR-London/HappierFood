//
//  Onboarding4ViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 13/07/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class Onboarding4ViewController: UINavigationController {

  
    lazy var block1: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "areYouReady1.jpg")
        return contentView
    }()
    
    lazy var tryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("Try Food", for: .normal)
        button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        
        return button
    }()
    
    lazy var noTryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("Not Eating Now", for: .normal)
        button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        
        return button
    }()
    
    lazy var block2: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "areYouReady2.jpg")
        return contentView
    }()
    

    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        view.addSubview(block1)
        block1.translatesAutoresizingMaskIntoConstraints = false
        block1.alpha = 0
        NSLayoutConstraint.activate(
            [
                //block1.topAnchor.constraint(equalTo: self.view.topAnchor),
                block1.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                block1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                block1.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3)
            ]
        )
        
        self.view.addSubview(tryButton)
        tryButton.translatesAutoresizingMaskIntoConstraints = false
        tryButton.addTarget(self, action: #selector(goOn), for: .touchUpInside)
        tryButton.alpha = 0
        NSLayoutConstraint.activate(
            [
                tryButton.topAnchor.constraint(equalTo: block1.bottomAnchor, constant: 20),
                tryButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
                tryButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                tryButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor , constant: 20),
                tryButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2)
            ]
        )
        
        self.view.addSubview(noTryButton)
        noTryButton.translatesAutoresizingMaskIntoConstraints = false
        noTryButton.addTarget(self, action: #selector(goOn), for: .touchUpInside)
        noTryButton.alpha = 0
        NSLayoutConstraint.activate(
            [
                noTryButton.topAnchor.constraint(equalTo: block1.bottomAnchor),
                noTryButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
                noTryButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                noTryButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor , constant: -20),
                noTryButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2)
            ]
        )
        
        view.addSubview(block2)
        block2.translatesAutoresizingMaskIntoConstraints = false
        block2.alpha = 0
        NSLayoutConstraint.activate(
            [
                block2.topAnchor.constraint(equalTo: tryButton.bottomAnchor, constant: 20),
                block2.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                block2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                block2.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8)){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.tryButton.alpha = 1
                self.noTryButton.alpha = 1
            }
            animator.startAnimation()
        }
    }
    
    
    @objc func goOn(sender: UIButton!) {
        performSegue(withIdentifier: "o2-o3", sender: self)
    }
}
