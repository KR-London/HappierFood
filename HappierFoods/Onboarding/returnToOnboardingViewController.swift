//
//  returnToOnboardingViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 11/10/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class returnToOnboardingViewController: UIViewController {
        
        lazy var happy: UIImageView = {
            let contentView = UIImageView()
            contentView.image = UIImage(named: "little dude3.png")
            return contentView
        }()

        lazy var block1: UILabel = {
            let contentView = UILabel()
            contentView.text = "Welcome back! How can I help?"
            contentView.font =  UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
            contentView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            return contentView
        }()
        
        
        lazy var b1: myButton = {
            let button = myButton()
           // button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
              //  R95 G215 B176  )
           // button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
            button.setTitle("Hold my hand - I'm gonna try something", for: .normal)
            button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            button.titleLabel?.allowsDefaultTighteningForTruncation = true
            button.titleLabel?.font =  UIFont(name: "TwCenMT-CondensedExtraBold", size: 18 )
            button.titleLabel?.textAlignment = .center
           // button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
            return button
        }()
        
        lazy var b2: myButton = {
            let button = myButton()
             // button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
           // button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
            button.setTitle("Gimme a target! ", for: .normal)
            button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            button.titleLabel?.allowsDefaultTighteningForTruncation = true
            button.titleLabel?.allowsDefaultTighteningForTruncation = true
            button.titleLabel?.font =  UIFont(name: "TwCenMT-CondensedExtraBold", size: 18 )
            //button.titleLabel?.adjustsFontForContentSizeCategory
           // button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
            return button
        }()
        
            lazy var b3: myButton = {
                let button = myButton()
               // button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
                  //  R95 G215 B176  )
               // button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
                button.setTitle("How will this app help me?", for: .normal)
                button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
                button.titleLabel?.textAlignment = .center
                button.titleLabel?.allowsDefaultTighteningForTruncation = true
                button.titleLabel?.font =  UIFont(name: "TwCenMT-CondensedExtraBold", size: 18 )
               // button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
                return button
            }()
            
            lazy var b4: myButton = {
                let button = myButton()
                 // button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
               // button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
                button.setTitle("I'm feeling down", for: .normal)
                button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
                button.titleLabel?.allowsDefaultTighteningForTruncation = true
                 button.titleLabel?.allowsDefaultTighteningForTruncation = true
                button.titleLabel?.font =  UIFont(name: "TwCenMT-CondensedExtraBold", size: 18 )
               // button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
                return button
            }()
    
    lazy var b5: myButton = {
        let button = myButton()
         // button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
       // button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
        button.setTitle("I want to play!", for: .normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.allowsDefaultTighteningForTruncation = true
         button.titleLabel?.allowsDefaultTighteningForTruncation = true
        button.titleLabel?.font =  UIFont(name: "TwCenMT-CondensedExtraBold", size: 18 )
       // button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        return button
    }()
    
    lazy var b6: myButton = {
        let button = myButton()
         // button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
       // button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
        button.setTitle("Settings", for: .normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.allowsDefaultTighteningForTruncation = true
         button.titleLabel?.allowsDefaultTighteningForTruncation = true
        button.titleLabel?.font =  UIFont(name: "TwCenMT-CondensedExtraBold", size: 18 )
       // button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        return button
    }()
        lazy var block2: UILabel = {
        let contentView = UILabel()
        contentView.text = "You're doing great!"
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
                    block1.topAnchor.constraint(equalTo: self.view.topAnchor),
                    block1.widthAnchor.constraint(equalTo: margins.widthAnchor),
                    block1.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                    block1.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 163/545)
                ]
            )
            
            view.addSubview(happy)
            happy.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(
                [
                    happy.topAnchor.constraint(equalTo: block1.bottomAnchor),
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
                    b1.topAnchor.constraint(equalTo: happy.bottomAnchor, constant: view.frame.width/100),
                    b1.widthAnchor.constraint(equalTo: b1.heightAnchor, multiplier: 1.5),
                   // b1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    b1.leadingAnchor.constraint(equalTo: margins.leadingAnchor , constant: 10),
                    b1.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.15)
                ]
            )
            
            self.view.addSubview(b2)
            b2.translatesAutoresizingMaskIntoConstraints = false
            b2.addTarget(self, action: #selector(noTry), for: .touchUpInside)
            b2.alpha = 0
            NSLayoutConstraint.activate(
                [
                    b2.topAnchor.constraint(equalTo: happy.bottomAnchor, constant: view.frame.width/100),
                    b2.widthAnchor.constraint(equalTo: b2.heightAnchor, multiplier: 1.5),
                    //b2.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    b2.trailingAnchor.constraint(equalTo: margins.trailingAnchor , constant: -10),
                    b2.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.15)
                ]
            )
            
            self.view.addSubview(b3)
            b3.translatesAutoresizingMaskIntoConstraints = false
            b3.addTarget(self, action: #selector(info), for: .touchUpInside)
            b3.alpha = 0
            NSLayoutConstraint.activate(
                [
                    b3.topAnchor.constraint(equalTo: b1.bottomAnchor, constant: 10),
                    b3.widthAnchor.constraint(equalTo: b3.heightAnchor, multiplier: 1.5),
                   // b3.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    b3.leadingAnchor.constraint(equalTo: margins.leadingAnchor , constant: 10),
                    b3.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.15)
                ]
            )
            
            self.view.addSubview(b4)
            b4.translatesAutoresizingMaskIntoConstraints = false
            b4.addTarget(self, action: #selector(motivate), for: .touchUpInside)
            b4.alpha = 0
            NSLayoutConstraint.activate(
                [
                    b4.topAnchor.constraint(equalTo: b2.bottomAnchor, constant: 10),
                    b4.widthAnchor.constraint(equalTo: b4.heightAnchor, multiplier: 1.5),
                   // b4.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    b4.trailingAnchor.constraint(equalTo: margins.trailingAnchor , constant: -10),
                    b4.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.15)
                ]
            )
            
            self.view.addSubview(b5)
            b5.translatesAutoresizingMaskIntoConstraints = false
            b5.addTarget(self, action: #selector(play), for: .touchUpInside)
            b5.alpha = 0
            NSLayoutConstraint.activate(
                [
                    b5.topAnchor.constraint(equalTo: b3.bottomAnchor, constant: 10),
                    b5.widthAnchor.constraint(equalTo: b5.heightAnchor, multiplier: 1.5),
                   // b4.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    b5.leadingAnchor.constraint(equalTo: margins.leadingAnchor , constant: 10),
                    b5.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.15)
                ]
            )
            
            
            self.view.addSubview(b6)
            b6.translatesAutoresizingMaskIntoConstraints = false
            b6.addTarget(self, action: #selector(settings), for: .touchUpInside)
            b6.alpha = 0
            NSLayoutConstraint.activate(
                [
                    b6.topAnchor.constraint(equalTo: b4.bottomAnchor, constant: 10),
                    b6.widthAnchor.constraint(equalTo: b6.heightAnchor, multiplier: 1.5),
                   // b4.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    b6.trailingAnchor.constraint(equalTo: margins.trailingAnchor , constant: -10),
                    b6.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.15)
                ]
            )
            
            
//
//            self.view.addSubview(b1)
//            b1.translatesAutoresizingMaskIntoConstraints = false
//            b1.addTarget(self, action: #selector(trying), for: .touchUpInside)
//            b1.alpha = 0
//            NSLayoutConstraint.activate(
//                [
//                    b1.topAnchor.constraint(equalTo: block1.bottomAnchor, constant: 100),
//                    b1.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.45),
//                    b1.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
//                    b1.leadingAnchor.constraint(equalTo: margins.leadingAnchor , constant: 5),
//                    b1.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.2)
//                ]
//            )
//
//            self.view.addSubview(b2)
//            b2.translatesAutoresizingMaskIntoConstraints = false
//            b2.addTarget(self, action: #selector(noTry), for: .touchUpInside)
//            b2.alpha = 0
//            NSLayoutConstraint.activate(
//                [
//                    b2.topAnchor.constraint(equalTo: block1.bottomAnchor, constant: 100),
//                    b2.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.45),
//                    b2.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
//                    b2.trailingAnchor.constraint(equalTo: margins.trailingAnchor , constant: -5),
//                    b2.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.2)
//                ]
//            )
//
            
            
            view.addSubview(block2)
            block2.translatesAutoresizingMaskIntoConstraints = false
            block2.alpha = 0
            NSLayoutConstraint.activate(
                [
                    block2.topAnchor.constraint(equalTo: b4.bottomAnchor, constant: 400),
                    block2.widthAnchor.constraint(equalTo: margins.widthAnchor),
                    block2.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                    block2.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 163/545)
                ]
            )
            
            /// fade it in & out with RH picture
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)){
                let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
                    self.block1.alpha = 1
                }
                animator.startAnimation()
            }
            
            /// fade it in & out with RH picture
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)){
                let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
                    self.block2.alpha = 1
                }
                animator.startAnimation()
            }
            
            
            /// fade it in & out with RH picture
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)){
                let animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
                    self.b1.alpha = 1
                    self.b2.alpha = 1
                     self.b3.alpha = 1
                     self.b4.alpha = 1
                    self.b5.alpha = 1
                    self.b6.alpha = 1
                }
                animator.startAnimation()
            }
            
            
        }
        
        @objc func trying(sender: UIButton!) {
            performSegue(withIdentifier: "reTry", sender: self)
        }
        
        
        @objc func noTry(sender: UIButton!) {
            performSegue(withIdentifier: "reNoTry", sender: self)
        }
    
        @objc func info(sender: UIButton!) {
              let storyboard = UIStoryboard(name: "ExtraTutorial", bundle: nil)
              let initialViewController = storyboard.instantiateViewController(withIdentifier: "p0" )
              self.present(initialViewController, animated: false, completion: nil)
        }
          
        @objc func motivate(sender: UIButton!) {
              performSegue(withIdentifier: "motivate", sender: self)
//            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
//            let initialViewController = storyboard.instantiateViewController(withIdentifier: "resources" )
//            self.present(initialViewController, animated: false, completion: nil)
        }
    
        @objc func settings(sender: UIButton!) {
                 performSegue(withIdentifier: "settingSegue", sender: self)
        }
    
        @objc func play(sender: UIButton!) {
             performSegue(withIdentifier: "playSegue", sender: self)
        }
    
    
        
    }
