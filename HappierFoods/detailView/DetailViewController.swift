//
//  detailViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 17/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailView = DetailView()
    
      var PresentState = Costume.Unknown

    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()

//        switch PresentState
//        {
//        case .ReviewTriedViewController:
//            print("reviewing a tried food")
//           // titleLabel.text = "Review Progress"
//        case .ReviewTargetViewController:
//            print("reviewing a target food")
//           // titleLabel.text = "Review Target"
//        default:
//            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
//                let storyBoard: UIStoryboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
//                let newViewController = storyBoard.instantiateViewController(withIdentifier: "photoInputScreen")
//                self.present(newViewController, animated: true, completion: nil)
//            }
//        }
    }
    
    override  func loadView() {
        view = detailView
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
