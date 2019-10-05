//
//  preTryViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 13/07/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class preTryViewController: UINavigationController {

//    lazy var block1: UIImageView = {
//        let contentView = UIImageView()
//        contentView.image = UIImage(named: "screen2_Block1.jpg")
//        return contentView
//    }()
//    
//    lazy var block2: UIImageView = {
//        let contentView = UIImageView()
//        contentView.image = UIImage(named: "screen2_block2.jpg")
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
//        performSegue(withIdentifier: "o2-o3", sender: self)
//    }


//}
    
    lazy var happy: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "little dude1.png")
        return contentView
    }()

lazy var block1: UIImageView = {
    let contentView = UIImageView()
    contentView.image = UIImage(named: "text 4 0.png")
    return contentView
}()


lazy var b1: myButton = {
    let button = myButton()
    //button.setImage(UIImage(named: "b1.jpg"), for: .normal)
   // button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
    //button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
    button.setTitle("Smell It", for: .normal)
   // button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 18 )
    return button
}()

lazy var b2: myButton = {
    let button = myButton()
    //button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
   // button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
    button.setTitle("Taste It", for: .normal)
    //button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 18 )
    return button
}()

lazy var b3: myButton = {
    let button = myButton()
    //button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
   // button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
    button.setTitle("Nibble It", for: .normal)
    //button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 18 )
    return button
}()

lazy var b4: myButton = {
    let button = myButton()
    //button.backgroundColor = UIColor(red: 95/255, green: 215/255, blue: 176/255, alpha: 1)
   // button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
    button.setTitle("Finish It", for: .normal)
   // button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 18 )
    return button
}()


lazy var block2: UIImageView = {
    let contentView = UIImageView()
    contentView.image = UIImage(named: "text 4 1.png")
    return contentView
}()



override func viewDidLoad() {
           view.backgroundColor = UIColor(red: 224, green: 250, blue: 233, alpha: 1)
      let margins = view.layoutMarginsGuide
    self.navigationBar.isHidden = true
    view.addSubview(block1)
    block1.translatesAutoresizingMaskIntoConstraints = false
    block1.alpha = 0
    NSLayoutConstraint.activate(
        [
            block1.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            block1.widthAnchor.constraint(equalTo: margins.widthAnchor),
            block1.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            block1.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.25)
        ]
    )
    
    self.view.addSubview(b1)
    b1.translatesAutoresizingMaskIntoConstraints = false
    b1.addTarget(self, action: #selector(injectIntoMainFlow), for: .touchUpInside)
    b1.alpha = 0
    NSLayoutConstraint.activate(
        [
            b1.topAnchor.constraint(equalTo: block1.bottomAnchor, constant: view.frame.width/100),
            b1.widthAnchor.constraint(equalTo: b1.heightAnchor),
           // b1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            b1.leadingAnchor.constraint(equalTo: margins.leadingAnchor , constant: 20),
            b1.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.2)
        ]
    )
    
    self.view.addSubview(b2)
    b2.translatesAutoresizingMaskIntoConstraints = false
    b2.addTarget(self, action: #selector(injectIntoMainFlow), for: .touchUpInside)
    b2.alpha = 0
    NSLayoutConstraint.activate(
        [
            b2.topAnchor.constraint(equalTo: block1.bottomAnchor, constant: view.frame.width/100),
            b2.widthAnchor.constraint(equalTo: b2.heightAnchor),
            //b2.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            b2.trailingAnchor.constraint(equalTo: margins.trailingAnchor , constant: -20),
            b2.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.2)
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
            b3.leadingAnchor.constraint(equalTo: margins.leadingAnchor , constant: 20),
            b3.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.2)
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
            b4.trailingAnchor.constraint(equalTo: margins.trailingAnchor , constant: -20),
            b4.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.2)
        ]
    )
    
    view.addSubview(block2)
    block2.translatesAutoresizingMaskIntoConstraints = false
    block2.alpha = 0
    NSLayoutConstraint.activate(
        [
            block2.topAnchor.constraint(equalTo: b3.bottomAnchor, constant: view.frame.width/100),
            block2.widthAnchor.constraint(equalTo: margins.widthAnchor),
            block2.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            block2.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.25)
        ]
    )
    
    view.addSubview(happy)
    happy.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(
        [
            happy.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 5),
            happy.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 40),
            happy.heightAnchor.constraint(equalToConstant: 150),
            happy.widthAnchor.constraint(equalToConstant: 150),
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
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
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
    
    let rootViewController = storyBoard.instantiateViewController(withIdentifier: "FrontPage") as! mainViewController
    let myNav = customNavigationController()
   // myNav.presentState = .FirstLaunch
    //clean up 
   // rootViewController.deleteAllData("TargetFood")
   // rootViewController.deleteAllData("TriedFood")
    //deleteAllData("HistoryTriedFoods")
    
   // rootViewController.foodArray = []
 //   rootViewController.targetArray = []
  //  defaults.set(0.0, forKey: "Last Week Started")
   // defaults.set(false, forKey: "Celebration Status")
    
    rootViewController.myNav?.presentState = .AddFoodViewController
    
    
    let newViewController = storyBoard.instantiateViewController(withIdentifier: "photoInputScreen") as! dataInputViewController
    
    newViewController.sourceViewController = "Try Food"

    
    myNav.pushViewController(rootViewController, animated: false)
    newViewController.navigationItem.setHidesBackButton(true, animated: true)
    myNav.pushViewController(newViewController, animated: false)
    
    
    if #available(iOS 13.0, *) {
        //newViewController.isModalInPresentation = true
       /// newViewController.modalPresentationStyle = .fullScreen
          myNav.modalPresentationStyle = .fullScreen
    }
    
    self.present(myNav, animated: true, completion: nil)
//    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    let newViewController = storyBoard.instantiateViewController(withIdentifier: "photoInputScreen") as! dataInputViewController
//    newViewController.sourceViewController = "Try Food"
//    self.present(newViewController, animated: true, completion: nil)
}
    
@objc func presetTarget(sender: UIButton!) {
    
        /// i need to jump into the second screen but preserve the navigation stack.
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
        let rootViewController = storyBoard.instantiateViewController(withIdentifier: "FrontPage") as! mainViewController
        let myNav = customNavigationController()
        rootViewController.myNav?.presentState = .AddFoodViewController
    
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "photoInputScreen") as! dataInputViewController
    
        newViewController.sourceViewController = "Try Food"
    
        myNav.pushViewController(rootViewController, animated: false)
        myNav.pushViewController(newViewController, animated: false)
    
        self.present(myNav, animated: true, completion: nil)
    
    }

}
