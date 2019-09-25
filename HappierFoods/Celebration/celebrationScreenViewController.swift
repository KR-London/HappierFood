//
//  celebrationScreenViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 11/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class celebrationScreenViewController: UIViewController {
    
    @IBOutlet weak var dancingHappy: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for x in 6...1000
        {
            let dude3Time = DispatchTimeInterval.milliseconds(100*x)
            let dude6Time = DispatchTimeInterval.milliseconds(100*x + 25)
            let dude7Time = DispatchTimeInterval.milliseconds(100*x + 50)
            let dudeRevertTime = DispatchTimeInterval.milliseconds(100*x + 75)
            
            print(dude3Time)
            print(dude6Time)
            print(dude7Time)
            print(dudeRevertTime)
            
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
        
        
        unowned let nav = navigationController as! customNavigationController
        nav.presentState = .ReturnFromCelebrationScreen
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "celebrationBackToMain"{
//            let dvc = segue.destination as! customNavigationController
//            dvc.presentState = .ReturnFromCelebrationScreen
//            dvc.happyTracker = true
//        }
//    }

}
