//
//  preTargetViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 13/07/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class preTargetViewController: UINavigationController {

    lazy var happy: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "little dude1.png")
        return contentView
    }()

    lazy var block1: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "text 5 1.png")
        return contentView
    }()
  
    
    
    lazy var b1: myButton = {
        let button = myButton()
        //button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
        //button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
        button.setTitle("Egg", for: .normal)
        //button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        return button
    }()
    
    lazy var b2: myButton = {
        let button = myButton()
       // button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
       // button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
        button.setTitle("Rice", for: .normal)
      //  button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        return button
    }()
    
    lazy var b3: myButton = {
        let button = myButton()
        //button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
       // button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
        button.setTitle("Apple", for: .normal)
        //button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        return button
    }()
    
    lazy var b4: myButton = {
        let button = myButton()
        // button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
        //button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
        button.setTitle("Other", for: .normal)
       // button.alpha = 0.2
        //button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        return button
    }()
    
    
    lazy var block2: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "text 5 2.png")
        return contentView
    }()
    
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 224, green: 250, blue: 233, alpha: 1)
        self.navigationBar.isHidden = true
        
        view.addSubview(block1)
        block1.translatesAutoresizingMaskIntoConstraints = false
        block1.alpha = 1
        NSLayoutConstraint.activate(
            [
                block1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
                block1.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                block1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                block1.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25)
            ]
        )
        
        view.addSubview(block2)
        block2.translatesAutoresizingMaskIntoConstraints = false
        block2.alpha = 1
        NSLayoutConstraint.activate(
            [
                block2.bottomAnchor.constraint(equalTo: self.view.centerYAnchor),
                block2.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                block2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                block2.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25)
            ]
        )
        
        view.addSubview(happy)
        happy.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                happy.centerYAnchor.constraint(equalTo: block2.bottomAnchor),
                happy.trailingAnchor.constraint(equalTo: block2.trailingAnchor),
                happy.heightAnchor.constraint(equalToConstant: 150),
                happy.widthAnchor.constraint(equalToConstant: 150),
            ]
        )
        
        self.view.addSubview(b1)
        b1.translatesAutoresizingMaskIntoConstraints = false
        b1.addTarget(self, action: #selector(injectIntoMainFlow), for: .touchUpInside)
        b1.alpha = 0
        NSLayoutConstraint.activate(
            [
                b1.topAnchor.constraint(equalTo: block2.bottomAnchor, constant: 10),
                b1.widthAnchor.constraint(equalTo: b1.heightAnchor),
                // b1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                b1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor , constant: 20),
                b1.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2)
            ]
        )
        
        self.view.addSubview(b2)
        b2.translatesAutoresizingMaskIntoConstraints = false
        b2.addTarget(self, action: #selector(injectIntoMainFlow), for: .touchUpInside)
        b2.alpha = 0
        NSLayoutConstraint.activate(
            [
                b2.topAnchor.constraint(equalTo: block2.bottomAnchor, constant: 10),
                b2.widthAnchor.constraint(equalTo: b2.heightAnchor),
                //b2.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                b2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor , constant: -20),
                b2.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2)
            ]
        )
        
        self.view.addSubview(b3)
        b3.translatesAutoresizingMaskIntoConstraints = false
        b3.addTarget(self, action: #selector(injectIntoMainFlow), for: .touchUpInside)
        b3.alpha = 0
        NSLayoutConstraint.activate(
            [
                b3.topAnchor.constraint(equalTo: b1.bottomAnchor, constant: 10),
                b3.widthAnchor.constraint(equalTo: b3.heightAnchor),
                // b3.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                b3.leadingAnchor.constraint(equalTo: self.view.leadingAnchor , constant: 20),
                b3.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2)
            ]
        )
        
        self.view.addSubview(b4)
        b4.translatesAutoresizingMaskIntoConstraints = false
        b4.addTarget(self, action: #selector(injectIntoMainFlow), for: .touchUpInside)
        b4.alpha = 0
        NSLayoutConstraint.activate(
            [
                b4.topAnchor.constraint(equalTo: b2.bottomAnchor, constant: 10),
                b4.widthAnchor.constraint(equalTo: b4.heightAnchor),
                // b4.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                b4.trailingAnchor.constraint(equalTo: self.view.trailingAnchor , constant: -20),
                b4.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.b1.alpha = 1
                self.b2.alpha = 1
                self.b3.alpha = 1
                self.b4.alpha = 1
            }
            animator.startAnimation()
        }
    }
    
    
    @objc func injectIntoMainFlow(sender: UIButton!) {
        /// i need to jump into the second screen but preserve the navigation stack.
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //        let newViewController = storyBoard.instantiateViewController(withIdentifier: "photoInputScreen") as! dataInputViewController
        //        newViewController.sourceViewController = "Try Food"
        //        self.present(newViewController, animated: true, completion: nil)
        
        
        let rootViewController = storyBoard.instantiateViewController(withIdentifier: "FrontPage") as! newMainViewController
        let myNav = customNavigationController()
        
        rootViewController.myNav?.presentState = .SetTargetViewController
        
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "photoInputScreen") as! newDataInputViewController
        
       // newViewController.sourceViewController = "Set Target"
        
        //  myNav.roo
        myNav.pushViewController(rootViewController, animated: false)
        myNav.pushViewController(newViewController, animated: false)
        
      
        
        let motivationViewController = storyBoard.instantiateViewController(withIdentifier: "targetSettingScreen") as! rateFoodViewController
        
        
        
        switch sender.titleLabel?.text{
            case "Egg":
                motivationViewController.imagePlaceholder = UIImage(named: "boiled_eggs.jpeg")!
                motivationViewController.placeHolderImage = "boiled_eggs.jpeg"
                motivationViewController.foodName = "Boiled Egg"
            
            case "Apple":
            
                motivationViewController.imagePlaceholder = UIImage(named: "apple.jpg")!
                motivationViewController.placeHolderImage = "apple.jpg"
                motivationViewController.foodName = "Apple"
            
            case "Rice":
            
                motivationViewController.imagePlaceholder = UIImage(named: "rice.jpeg")!
                motivationViewController.placeHolderImage = "rice.jpeg"
                motivationViewController.foodName = "Rice"
            
            case "Other":
            
                motivationViewController.imagePlaceholder = UIImage(named: "chaos.jpg")!
                motivationViewController.placeHolderImage = "chaos.jpg"
            
            default:
            
                motivationViewController.imagePlaceholder = UIImage(named: "chaos.jpg")!
                motivationViewController.placeHolderImage = "chaos.jpg"
        }
      
        
        
        
        motivationViewController.presentState = "First Target"
        motivationViewController.firstPass = "Target"
        motivationViewController.navigationItem.setHidesBackButton(true, animated: true)
        
        myNav.navigationItem.setHidesBackButton(true, animated: true)
        myNav.pushViewController(motivationViewController, animated: false)
        
        if #available(iOS 13.0, *) {
            myNav.modalPresentationStyle = .fullScreen
        } 
        
        self.present(myNav, animated: true, completion: nil)
    }

}

