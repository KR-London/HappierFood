//
//  Onboarding3ViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 13/07/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class Onboarding3ViewController: UINavigationController {
    
    
    lazy var block1: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "screen3.jpg")
        return contentView
    }()
    
    lazy var shakeMe: UIButton = {
        let contentView = UIButton()
        contentView.setImage(UIImage(named: "shakeMe.jpg"), for: .normal)
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(block1)
        block1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                block1.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                block1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                block1.topAnchor.constraint(equalTo: self.view.topAnchor),
                block1.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.8),
            ]
        )
        
        view.addSubview(shakeMe)
        shakeMe.translatesAutoresizingMaskIntoConstraints = false
        shakeMe.alpha = 0
        NSLayoutConstraint.activate(
            [
                shakeMe.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
                shakeMe.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                shakeMe.topAnchor.constraint(equalTo: block1.bottomAnchor),
                shakeMe.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
            ]
        )
        
    
        /// fade it in & out with RH picture
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){
            self.startAnimate(text: self.shakeMe)
            let animator = UIViewPropertyAnimator(duration: 6, curve: .easeOut) {
                self.shakeMe.alpha = 1
            }
            animator.startAnimation()
       
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(12)){
            self.performSegue(withIdentifier: "o3-o4", sender: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        stopAnimate(text: shakeMe)
    }
    
    
    func startAnimate(text: UIButton) {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
        shakeAnimation.duration = 0.05
        shakeAnimation.repeatCount = 4
        shakeAnimation.autoreverses = true
        shakeAnimation.duration = 0.2
        shakeAnimation.repeatCount = 99999
        
        let startAngle: Float = (-2) * 3.14159/180
        let stopAngle = -startAngle
        
        shakeAnimation.fromValue = NSNumber(value: startAngle as Float)
        shakeAnimation.toValue = NSNumber(value: 3 * stopAngle as Float)
        shakeAnimation.autoreverses = true
        shakeAnimation.timeOffset = 290 * drand48()
        
        let layer: CALayer = text.layer
        layer.add(shakeAnimation, forKey:"animate")
        
    }
    
    func stopAnimate(text: UIButton) {
        let layer: CALayer = text.layer
        layer.removeAnimation(forKey: "animate")
    }

    

}


    func startAnimate(text: UIButton) {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
        shakeAnimation.duration = 0.05
        shakeAnimation.repeatCount = 4
        shakeAnimation.autoreverses = true
        shakeAnimation.duration = 0.2
        shakeAnimation.repeatCount = 99999
        
        let startAngle: Float = (-2) * 3.14159/180
        let stopAngle = -startAngle
        
        shakeAnimation.fromValue = NSNumber(value: startAngle as Float)
        shakeAnimation.toValue = NSNumber(value: 3 * stopAngle as Float)
        shakeAnimation.autoreverses = true
        shakeAnimation.timeOffset = 290 * drand48()
        
        let layer: CALayer = text.layer
        layer.add(shakeAnimation, forKey:"animate")
        
    }
    
    func stopAnimate(text: UIButton) {
        let layer: CALayer = text.layer
        layer.removeAnimation(forKey: "animate")
    }

