//
//  topBarViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 10/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class topBarViewController: UIViewController {
    
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        
        let whatHaveITried = "My target this week is to try green beans"

        let activityViewController =
            UIActivityViewController(activityItems: [whatHaveITried],
                                     applicationActivities: nil)
        
        present(activityViewController, animated: true) {
            // ...
        }
    }
    

    @IBOutlet var topView: topView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        if topView.wrapperVC == "Main"
//        {
//            topView.titleLabel.text = "Hello World"
//        }
        
       

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
