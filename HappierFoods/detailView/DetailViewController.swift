//
//  detailViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 17/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    
//    func performSegueDelegate(recordToDelete: String) {
//        performSegue(withIdentifier: "detailToMain", sender: self)
//    }
    
//    weak var delegate: expandDetailDelegate?
    
   /// var messageFromTheOtherSide = "I'm talking from DetailViewController"
    
    var photoFilename = String()
    var foodName = String()
    var rating = Double()
    var triedOn = Date()
    var notes = String()
    var detailToDisplay = (photoFilename: "tick.jpg", foodName: "not initialised", rating: 0.0, triedOn: Date(), notes: "" )
    
    func expandDetailSegue(buttonTag: Int) {
        detailToDisplay = (photoFilename: photoFilename, foodName: foodName, rating: rating, triedOn: triedOn, notes: notes)
    }
    
    //var detailView = DetailView()
    
   // let detail1 = detailContainer1()
    
    var PresentState = Costume.Unknown
    
    var detail1VC = Detail1ViewController(nibName: "Detail1ViewController", bundle: nil)
    var detail2VC = Detail2ViewController(nibName: "Detail2ViewController", bundle: nil)
    var detail3VC = Detail3ViewController(nibName: "Detail3ViewController", bundle: nil)
    var detail4VC = Detail4ViewController(nibName: "Detail4ViewController", bundle: nil)
    var detail5VC = Detail5ViewController(nibName: "Detail5ViewController", bundle: nil)
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let container1 = detail1VC.view
//        let container2 = detail2VC.view
//        let container3 = detail3VC.view
//        let container4 = detail4VC.view
//        let container5 = detail5VC.view
//
        self.view.addSubview(detail1VC.view)
        self.view.addSubview(detail2VC.view)
        self.view.addSubview(detail3VC.view)
        self.view.addSubview(detail4VC.view)
        self.view.addSubview(detail5VC.view)

        
        detail2VC.foodName.text = self.detailToDisplay.foodName
        detail2VC.foodPicture.image = UIImage(named: "chaos.jpg")
        
        setupLayout(container1: detail1VC.view, container2: detail2VC.view, container3: detail3VC.view, container4: detail4VC.view, container5: detail5VC.view)
//        detail1VC.view.backgroundColor = UIColor.blue
//        NSLayoutConstraint.activate([
//                    detail1VC.view.topAnchor.constraint(equalTo: view.topAnchor),
//                    detail1VC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                    detail1VC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                    detail1VC.view.heightAnchor.constraint(equalTo: view.heightAnchor)
//       ])
    
//        let fakeNavBar = storyboard!.instantiateViewController(withIdentifier: "topBarViewController") as! topBarViewController
//        addChild(fakeNavBar)
//        fakeNavBar.view.translatesAutoresizingMaskIntoConstraints = false
//        fakeNavBar.delegate = self
    //    detailView.container1.addSubview(fakeNavBar.view)
        
//        NSLayoutConstraint.activate([
//            fakeNavBar.view.topAnchor.constraint(equalTo: view.topAnchor),
//            fakeNavBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            fakeNavBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            fakeNavBar.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
//            ])
        
        //        NSLayoutConstraint.activate([
        //            backButton.topAnchor.constraint(equalTo: topAnchor),
        //            backButton.leadingAnchor.constraint(equalTo: leadingAnchor),
        //            backButton.widthAnchor.constraint(equalToConstant: 100),
        //            backButton.heightAnchor.constraint(equalToConstant: 40)
        //            ])
    
        
       // setUpNavigationBarItems()
    //  loadView()
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
    
//    func setUpNavigationBarItems(){
//
//        navigationItem.title = "Nav Bar title"
//
//        let backButton = UIButton(type: .system)
//        backButton.setTitle("< Back", for: .normal)
//        backButton.addTarget(self, action: #selector(goBackToMain), for: .touchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
//
//        let shareButton = UIButton(type: .system)
//        shareButton.setImage(UIImage(named: "share.png"), for: .normal)
//        shareButton.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
//        shareButton.contentMode = .scaleAspectFit
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
//    }
////
//    override  func loadView() {
//        view = detailView
//    }
//
//    @objc func goBackToMain(sender: UIButton!){
//        performSegue(withIdentifier: "detailToMain", sender: self)
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
    
    private func setupLayout(container1 : UIView, container2 : UIView, container3 : UIView, container4 : UIView, container5 : UIView) {
        
        //        NSLayoutConstraint.activate([
        //            backButton.topAnchor.constraint(equalTo: topAnchor),
        //            backButton.leadingAnchor.constraint(equalTo: leadingAnchor),
        //            backButton.widthAnchor.constraint(equalToConstant: 600),
        //            backButton.heightAnchor.constraint(equalToConstant: 600)
        //            ])
        //
        
        container1.translatesAutoresizingMaskIntoConstraints = false
        container2.translatesAutoresizingMaskIntoConstraints = false
        container3.translatesAutoresizingMaskIntoConstraints = false
        container4.translatesAutoresizingMaskIntoConstraints = false
        container5.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container1.topAnchor.constraint(equalTo: view.topAnchor),
            container1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            container1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            container1.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15),
            ])
        NSLayoutConstraint.activate([
            container2.topAnchor.constraint(equalTo: container1.bottomAnchor),
            container2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            container2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            container2.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
            ])
        
        NSLayoutConstraint.activate([
            
            container3.topAnchor.constraint(equalTo: container2.bottomAnchor),
            container3.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            container3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            container3.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
            
            ])
        NSLayoutConstraint.activate([
            container4.topAnchor.constraint(equalTo: container3.bottomAnchor),
            container4.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            container4.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            container4.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
            ])
        
        NSLayoutConstraint.activate([
            container5.topAnchor.constraint(equalTo: container4.bottomAnchor),
            container5.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            container5.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            container5.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
            ])
        
        
        
        
    }
    
    
    
}
//
//protocol goBackDelegate: class {
//    func performSegueDelegate(recordToDelete: String)
//}
