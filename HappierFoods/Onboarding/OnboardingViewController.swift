//
//  OnboardingViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 28/06/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    

    @IBOutlet weak var block1: UILabel!
   
    @IBOutlet weak var block2: UILabel!
    @IBOutlet weak var pic: UIImageView!
  
    @IBOutlet weak var block3: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func moveToMain(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FrontPage") as! mainViewController
       // newViewController.presentS
        newViewController.presentStatePlaceholder = Costume.FirstLaunch
        self.present(newViewController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutBlocks()
    }
    
    func layoutBlocks(){
        block1.translatesAutoresizingMaskIntoConstraints = false
        block1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8).isActive = true
        block1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        block1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        block1.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        
        block2.translatesAutoresizingMaskIntoConstraints = false
        block2.topAnchor.constraint(greaterThanOrEqualTo: block1.bottomAnchor, constant: 8).isActive = true
        block2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        block2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        block2.heightAnchor.constraint(greaterThanOrEqualToConstant: 300).isActive = true
        
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.topAnchor.constraint(greaterThanOrEqualTo: block2.bottomAnchor, constant: 8).isActive = true
        pic.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        pic.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        pic.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true

        block3.translatesAutoresizingMaskIntoConstraints = false
        block3.topAnchor.constraint(greaterThanOrEqualTo: pic.bottomAnchor, constant: 8).isActive = true
        block3.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        block3.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        block3.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true

        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(greaterThanOrEqualTo: block3.bottomAnchor, constant: 8).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        button.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -8).isActive = true


    }

}
