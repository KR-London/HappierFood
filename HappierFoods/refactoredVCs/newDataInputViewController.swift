//
//  newDataInputViewController.swift
//
//
//  Created by Kate Roberts on 13/11/2019.
//

import UIKit
import CoreData

class newDataInputViewController: UIViewController {
    
    /// initialise all the elements programatically
    lazy var triesCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
  
    
        return collection
    }()
    
    lazy var targetsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
          let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
          collection.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
          return collection
      }()
    
    lazy var eatNowButton: myButton = {
        let button = myButton()
        button.setTitle("Eat Now", for: .normal)
        return button
    }()

    lazy var eatLaterButton: myButton = {
          let button = myButton()
        button.setTitle("Eat Later", for: .normal)
          return button
      }()
    
    lazy var foodImage: UIImageView = {
        let imageView = UIImageView()
        

        /// stretch
        return imageView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.setTitle("+", for: .normal)
        button.titleLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.titleLabel?.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 72 )
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 5.0
        button.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return button
    }()
    
    lazy var textInput: UITextField = {
        let foodName = UITextField()
        foodName.layer.borderWidth = 5.0
        foodName.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        foodName.placeholder = "Name of food...."
        foodName.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 18 )
        foodName.setLeftPaddingPoints(15)
        return foodName
    }()
        
    lazy var buttonStackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubview()
        
        
    }
    
    /// set up contstraints to lay them out
    func setUpSubview(){
        let layoutUnit = (self.view.frame.height - (self.navigationController?.navigationBar.frame.height ?? 0))/8 as! CGFloat
        let margins = view.layoutMarginsGuide
        //let fullScreen = view.
        
        triesCollectionView.register(mainCollectionViewCell.self, forCellWithReuseIdentifier: "tryCell")
        triesCollectionView.delegate = self
        triesCollectionView.dataSource = self
        view.addSubview(triesCollectionView)
        triesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            triesCollectionView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            triesCollectionView.heightAnchor.constraint(equalToConstant: layoutUnit),
            triesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            triesCollectionView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor)
            
        ])
        
    targetsCollectionView.register(mainCollectionViewCell.self, forCellWithReuseIdentifier: "tryCell")
        targetsCollectionView.delegate = self
        targetsCollectionView.dataSource = self
        view.addSubview(targetsCollectionView)
        targetsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            targetsCollectionView.topAnchor.constraint(equalTo: triesCollectionView.bottomAnchor, constant: 10),
            targetsCollectionView.heightAnchor.constraint(equalToConstant: layoutUnit),
            targetsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            targetsCollectionView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor)
            
        ])
    
    

        view.addSubview(foodImage)
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        foodImage.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
       // foodImage.image = UIImage(named: "cracker.jpeg")
        foodImage.layer.borderWidth = 6.0
        foodImage.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        NSLayoutConstraint.activate([
            foodImage.topAnchor.constraint(equalTo: targetsCollectionView.bottomAnchor, constant: 10),
            foodImage.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            foodImage.heightAnchor.constraint(equalToConstant: 3*layoutUnit),
            foodImage.widthAnchor.constraint(equalTo: foodImage.heightAnchor)
        ])
        foodImage.cornerRadius = 1.5*layoutUnit
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: targetsCollectionView.bottomAnchor, constant: 10),
            addButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
           addButton.heightAnchor.constraint(equalToConstant: 3*layoutUnit),
            addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor)
        ])
        addButton.cornerRadius = 1.5*layoutUnit
        
        view.addSubview(textInput)
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.cornerRadius = 5
        NSLayoutConstraint.activate([
            textInput.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 10),
            textInput.heightAnchor.constraint(equalToConstant: layoutUnit),
            textInput.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.85),
            textInput.centerXAnchor.constraint(equalTo: margins.centerXAnchor)
        ])

        buttonStackView.addArrangedSubview(eatNowButton)
        buttonStackView.addArrangedSubview(eatLaterButton)
        
        view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -10),
            buttonStackView.heightAnchor.constraint(equalToConstant: layoutUnit),
            buttonStackView.widthAnchor.constraint(equalTo: margins.widthAnchor),
            buttonStackView.centerXAnchor.constraint(equalTo: margins.centerXAnchor)
        ])
        
    }
    
    /// define the collection view layout
    
    /// fill in the data for the two collection view sources
    
    /// make a click on the collection view send a message to populate the main screen
    
    /// put in button in the middle of the image view
    
    /// launch camera from image view button, and input picture
    
    /// define the segue out of the screen

}

extension newDataInputViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tryCell", for: indexPath) as! mainCollectionViewCell
            cell.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
         
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: collectionView.bounds.size.height - 8 , height: collectionView.bounds.height - 8 )
    }
    
    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 0)
      }
    
}
