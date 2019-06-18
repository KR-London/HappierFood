//
//  detailViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 17/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    var photoFilename = String()
    var foodName = String()
    var rating = Double()
    var triedOn = Date()
    var notes = String()
    var detailToDisplay = (photoFilename: "tick.jpg", foodName: "not initialised", rating: 0.0, triedOn: Date(), notes: "" )
    
    func expandDetailSegue(buttonTag: Int) {
        detailToDisplay = (photoFilename: photoFilename, foodName: foodName, rating: rating, triedOn: triedOn, notes: notes)
    }

    var PresentState = Costume.Unknown
    
    var detail1VC = Detail1ViewController(nibName: "Detail1ViewController", bundle: nil)
    var detail2VC = Detail2ViewController(nibName: "Detail2ViewController", bundle: nil)
    var detail3VC = Detail3ViewController(nibName: "Detail3ViewController", bundle: nil)
    var detail4VC = Detail4ViewController(nibName: "Detail4ViewController", bundle: nil)
    var detail5VC = Detail5ViewController(nibName: "Detail5ViewController", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(detail1VC.view)
        self.view.addSubview(detail2VC.view)
        self.view.addSubview(detail3VC.view)
        self.view.addSubview(detail4VC.view)
        self.view.addSubview(detail5VC.view)

        detail2VC.foodName.text = self.detailToDisplay.foodName
        detail2VC.foodPicture.image = UIImage(named: detailToDisplay.photoFilename ?? "chaos.jpg")
        detail5VC.detailToDisplay = detailToDisplay
        
        switch PresentState {
        case .AddFoodViewController:
            detail5VC.tryButton.setTitle("Try it again?", for: .normal)
        case .SetTargetViewController:
            detail5VC.tryButton.setTitle("Try this food?", for: .normal)
        default:
            detail5VC.tryButton.setTitle("Bug", for: .normal)
        }
       
        
        setupLayout( container1 : detail1VC.view, container2: detail2VC.view, container3: detail3VC.view, container4: detail4VC.view, container5: detail5VC.view)
        
        setUpNavigationBarItems()
    }
    
    func setUpNavigationBarItems(){

        let deleteButton = UIButton(type: .system)
        //shareButton.setImage(UIImage(named: "share.png")?.resize(to: CGSize(width: 100,height: 100)), for: .normal)
       // shareButton.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
       // shareButton.contentMode = .right
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: #selector(delete), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: deleteButton)
    }

    @objc func goBackToMain(sender: UIButton!){
        performSegue(withIdentifier: "detailToMain", sender: self)
    }
    
    @objc func delete(sender: UIButton!){
        /// delete record function
    }

    private func setupLayout( container1 : UIView, container2 : UIView, container3 : UIView, container4 : UIView, container5 : UIView) {
        
        container1.translatesAutoresizingMaskIntoConstraints = false
        container2.translatesAutoresizingMaskIntoConstraints = false
        container3.translatesAutoresizingMaskIntoConstraints = false
        container4.translatesAutoresizingMaskIntoConstraints = false
        container5.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container1.topAnchor.constraint(equalTo: view.topAnchor),
            container1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
            container1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            container1.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1),
            ])
        NSLayoutConstraint.activate([
            container2.topAnchor.constraint(equalTo: container1.bottomAnchor),
            container2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1 ),
            container2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            container2.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
            ])
        
        NSLayoutConstraint.activate([
            container3.topAnchor.constraint(equalTo: container2.bottomAnchor),
            container3.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1 ),
            container3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            container3.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3),
            ])
        NSLayoutConstraint.activate([
            container4.topAnchor.constraint(equalTo: container3.bottomAnchor),
            container4.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
            container4.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            container4.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
            ])
        
        NSLayoutConstraint.activate([
            container5.topAnchor.constraint(equalTo: container4.bottomAnchor),
            container5.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
            container5.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            container5.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
            ])
    }
}
