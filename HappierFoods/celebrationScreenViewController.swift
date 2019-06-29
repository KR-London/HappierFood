//
//  celebrationScreenViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 11/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class celebrationScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "celebrationBackToMain"{
            let dvc = segue.destination as! mainViewController
            dvc.presentStatePlaceholder = .ReturnFromCelebrationScreen
            dvc.happyTracker = true
        }
    }

}
