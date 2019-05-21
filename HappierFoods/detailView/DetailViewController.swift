//
//  detailViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 17/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, goBackDelegate {
    func performSegueDelegate(recordToDelete: String) {
        performSegue(withIdentifier: "detailToMain", sender: self)
    }
    
    
    var detailView = DetailView()
    
    var PresentState = Costume.Unknown

    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.delegate = self
    
        let fakeNavBar = storyboard!.instantiateViewController(withIdentifier: "topBarViewController") as! topBarViewController
        addChild(fakeNavBar)
        fakeNavBar.view.translatesAutoresizingMaskIntoConstraints = false
        fakeNavBar.delegate = self
        detailView.container1.addSubview(fakeNavBar.view)
        
        NSLayoutConstraint.activate([
            fakeNavBar.view.topAnchor.constraint(equalTo: view.topAnchor),
            fakeNavBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fakeNavBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fakeNavBar.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
            ])
        
        //        NSLayoutConstraint.activate([
        //            backButton.topAnchor.constraint(equalTo: topAnchor),
        //            backButton.leadingAnchor.constraint(equalTo: leadingAnchor),
        //            backButton.widthAnchor.constraint(equalToConstant: 100),
        //            backButton.heightAnchor.constraint(equalToConstant: 40)
        //            ])
    
        
       // setUpNavigationBarItems()
        loadView()
     //   detailView.rating = -1
        //detailView.data
        //detailView.container2.food
        //detailView.container3.mouth

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
    
    func setUpNavigationBarItems(){

        navigationItem.title = "Nav Bar title"

        let backButton = UIButton(type: .system)
        backButton.setTitle("< Back", for: .normal)
        backButton.addTarget(self, action: #selector(goBackToMain), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        let shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(named: "share.png"), for: .normal)
        shareButton.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        shareButton.contentMode = .scaleAspectFit
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
    }
    
    override  func loadView() {
        view = detailView
    }
    
    @objc func goBackToMain(sender: UIButton!){
        performSegue(withIdentifier: "detailToMain", sender: self)
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

protocol goBackDelegate: class {
    func performSegueDelegate(recordToDelete: String)
}
