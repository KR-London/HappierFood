//
//  celebrationScreenViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 11/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class celebrationScreenViewController: UIViewController {
    
    lazy var b1: myButton = {
        let button = myButton()
        button.tintColor = UIColor().HexToColor(hexString: "#210203", alpha: 1.0)
        button.setTitle("I'm the dude!", for: .normal)
        button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        return button
    }()
    
    @IBOutlet weak var dancingHappy: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for x in 6...1000
        {
            let dude3Time = DispatchTimeInterval.milliseconds(100*x)
            let dude6Time = DispatchTimeInterval.milliseconds(100*x + 25)
            let dude7Time = DispatchTimeInterval.milliseconds(100*x + 50)
            let dudeRevertTime = DispatchTimeInterval.milliseconds(100*x + 75)
            
            DispatchQueue.main.asyncAfter(deadline: .now() +  dude3Time){
                self.dancingHappy.image = UIImage(named: "little dude3.png")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + dude6Time){
                self.dancingHappy.image = UIImage(named: "little dude6.png")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + dude7Time){
                self.dancingHappy.image = UIImage(named: "little dude7.png")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + dudeRevertTime){
                self.dancingHappy.image = UIImage(named: "little dude6.png")
            }
        }
        
        
        //unowned let nav = navigationController as! customNavigationController
        //nav.presentState = .ReturnFromCelebrationScreen
        let margins = view.layoutMarginsGuide
        
        view.addSubview(b1)
        b1.translatesAutoresizingMaskIntoConstraints = false
        b1.addTarget(self, action: #selector(home), for: .touchUpInside)
        b1.alpha = 1
        NSLayoutConstraint.activate(
            [
                b1.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -200),
                b1.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.85),
                b1.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                b1.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.2)
            ]
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                               self.b1.alpha = 1
                           }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "celebrationBackToMain"{
//            let dvc = segue.destination as! customNavigationController
//            dvc.presentState = .ReturnFromCelebrationScreen
//            dvc.happyTracker = true
//        }
//    }

    @objc func home(){
        
        let myNav = customNavigationController()
        
        //rootViewController.myNav?.presentState = pre
        
        //let newViewController = storyBoard.instantiateViewController(withIdentifier: "newDataInputViewController") as! newDataInputViewController
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "newMainViewController" ) as! newMainViewController
        nextViewController.isRainingConfetti = true
        myNav.pushViewController(nextViewController, animated: true)
        self.present(myNav, animated: true, completion: nil)
        
        
        /// want it full screen
    }
}
