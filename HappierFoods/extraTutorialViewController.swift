//
//  extraTutorialViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 11/10/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class extraTutorialViewController: UIViewController {

    @IBOutlet weak var tutorial: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
        for i in 1...11
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2*Double(i - 1 )) {
                let pic = "T" + String(i) + ".png"
                print(pic)
                self.tutorial.image = UIImage(named: pic)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 25) {
               // let myNav = customNavigationController()
               // let storyboard = UIStoryboard(name: "Main", bundle: nil)
               // let initialViewController = storyboard.instantiateViewController(withIdentifier: "Main" )
              //  myNav.pushViewController(initialViewController, animated: false)
            //self.present(initialViewController, animated: true, completion: nil)
            
            self.dismiss(animated: true, completion: nil)
        }
        }
}
