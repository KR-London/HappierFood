//
//  detailView.swift
//  HappierFoods
//
//  Created by Kate Roberts on 13/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class DetailView: UIView, goBackDelegate {
    func performSegueDelegate(recordToDelete: String) {
        delegate?.performSegueDelegate(recordToDelete: "")
    }
    

    weak var delegate: goBackDelegate?
    
    var detailToDisplay = (photoFilename: "tick.jpg", foodName: "not initialised", rating: 0.0, triedOn: NSDate.init(), notes: "" )
    var presentState = Costume.Unknown
//    
    lazy var backButton: UIButton = {
        let button = UIButton()
       // button.backgroundColor = UIColor.red
        button.titleLabel?.text = "< Back "
        button.backgroundColor = UIColor.yellow
        button.addTarget(self, action: #selector(testButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // use lazy properties for each view
    lazy var container1: UIView = {
        let headerView = detailContainer1()
        return headerView
    }()
    
    lazy var container2: UIView = {
        let bodyView = detailContainer2()
        bodyView.inputData(photoFilename: detailToDisplay.photoFilename, foodNameInput: detailToDisplay.foodName )
        return bodyView
    }()
    
    lazy var container3: UIView = {
        let bodyView = detailContainer3()
     // bodyView.rating = detail
        return bodyView
    }()
    
    lazy var container4: UIView = {
        let bodyView = detailContainer4()
        return bodyView
    }()
    
    lazy var container5: UIView = {
        let footerView = detailContainer5()
        return footerView
    }()
    
    
    lazy var headerTitle: UILabel = {
        let headerTitle = UILabel()
        headerTitle.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        headerTitle.text = "Custom View"
        headerTitle.textAlignment = .center
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        return headerTitle
    }()
    
    
    //var container1 = UIView()
    
    var title: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        customViewItems()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customViewItems()
    }
    
    func customViewItems(){
        NotificationCenter.default.addObserver(self, selector: #selector(onDidExpandRecord), name: .expandRecord, object: nil)
        backgroundColor = UIColor.white
        addSubview(container1)
        addSubview(container2)
        addSubview(container3)
        addSubview(container4)
        addSubview(container5)
        //addSubview(backButton)
        setupLayout()

    }
    
    private func setupLayout() {
        
//        NSLayoutConstraint.activate([
//            backButton.topAnchor.constraint(equalTo: topAnchor),
//            backButton.leadingAnchor.constraint(equalTo: leadingAnchor),
//            backButton.widthAnchor.constraint(equalToConstant: 600),
//            backButton.heightAnchor.constraint(equalToConstant: 600)
//            ])
//
        
        NSLayoutConstraint.activate([
            container1.topAnchor.constraint(equalTo: topAnchor),
            container1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            container1.centerXAnchor.constraint(equalTo: centerXAnchor),
            container1.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15),
            ])
        NSLayoutConstraint.activate([
            container2.topAnchor.constraint(equalTo: container1.bottomAnchor),
            container2.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            container2.centerXAnchor.constraint(equalTo: centerXAnchor),
            container2.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            ])
        
        NSLayoutConstraint.activate([

            container3.topAnchor.constraint(equalTo: container2.bottomAnchor),
            container3.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            container3.centerXAnchor.constraint(equalTo: centerXAnchor),
            container3.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),

            ])
        NSLayoutConstraint.activate([
            container4.topAnchor.constraint(equalTo: container3.bottomAnchor),
            container4.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            container4.centerXAnchor.constraint(equalTo: centerXAnchor),
            container4.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            ])
   
        NSLayoutConstraint.activate([
            container5.topAnchor.constraint(equalTo: container4.bottomAnchor),
            container5.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            container5.centerXAnchor.constraint(equalTo: centerXAnchor),
            container5.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
    ])


    
  
    }

    @objc func testButton(sender: UIButton){
        delegate?.performSegueDelegate(recordToDelete: "")
    }
    
    @objc func onDidExpandRecord(){
        print("I see record")
    }

    //custom views should override this to return true if
    //they cannot layout correctly using autoresizing.

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    
    //override var backgroundColor: UIColor?

    /// Section 1: Top amber bar
    
    /// Section 2: Photo and food name
    
    /// Section 3: If it's a tried food tapped - the faceview and the date
    //              If it's the target food tapped - placeholder for "high level nutritional information or inspirational quote goes here"
    
    /// Section 4: Notes Section
    
    /// Section 5: Stack of buttons
}

protocol passFoodDetailProtocol: class
{
    func updateDetail(photoFilename: String, foodName: String, rating: Double, triedOn: Date, notes: String)
}
