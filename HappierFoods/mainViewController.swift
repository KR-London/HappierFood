//
//  mainViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 06/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import Foundation
import Darwin
import CoreData

enum location : String {
    case Main
    case Input
    case Rate
    case History
    case Customisation
    case Celebrate
    case Unknown
}

var whereAmINowBeacon = location.Unknown



class mainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, expandDetailDelegate, UIActivityItemSource  {
    @IBAction func dummyButton(_ sender: Any) {
        
            let whatHaveITried = "My target is to try: RICE. I tried CARROTS on TUESDAY. I tried CARROTS on THURSDAY. "
            
            let activityViewController =
                UIActivityViewController(activityItems: [whatHaveITried],
                                         applicationActivities: nil)
            
           present(activityViewController, animated: true)
        
        
    }
    
    lazy var ddummyButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(share), for: .touchUpInside)
        return button
    }()
    
    var photoFilename = String()
    var foodName = String()
    var rating = Double()
    var triedOn = Date()
    var notes = String()
    
    lazy var topBar : topView = {
        let content = topView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    func expandDetailSegue(buttonTag: Int) {
        print("hello world")
        
        photoFilename = foodArray[buttonTag].filename ?? "chaos.jpg"
        foodName = foodArray[buttonTag].name ?? ""
        rating = foodArray[buttonTag].rating
        triedOn = foodArray[buttonTag].dateTried!
        notes = foodArray[buttonTag].motivation ?? " "
        
 //       NotificationCenter.default.post(name: NSNotification.Name(rawValue: "expandRecord"), object: self)
        
        
        //prepare(for: UIStoryboardSegue., sender: <#T##Any!#>)
        performSegue(withIdentifier: "expandDetail", sender: .none)
    }
    
    
    @IBOutlet weak var containerView: topView!
    
    @IBOutlet weak var setTargetOutlet: UIButton!
    @IBAction func setTargetButton(_ sender: Any) {
        performSegue(withIdentifier: "addFoodSegue", sender: setTargetOutlet)
    }

    @IBAction func hardRestButton(_ sender: Any) {
        
        deleteAllData("TriedFood")
        deleteAllData("TargetFood")
        loadItems()
        self.mainCollectionView.reloadSections([0])
    }
    
    @IBOutlet weak var addFoodOutlet: UIButton!
    @IBAction func addFoodButton(_ sender: Any) {
        
//        imagePicker.sourceType = .photoLibrary
//        present(imagePicker, animated: true, completion: nil)
        performSegue(withIdentifier: "addFoodSegue", sender: addFoodOutlet)
        
    }
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    @IBAction func expandDetailButtonPressed(_ sender: UIButton) {
  
        let buttonTag = sender.tag
        print("The tag of this button is \(sender.tag)")
        
        if buttonTag < foodArray.count
        {
            photoFilename = foodArray[buttonTag].filename ?? "chaos.jpg"
            foodName = foodArray[buttonTag].name ?? ""
            rating = foodArray[buttonTag].rating
            triedOn = foodArray[buttonTag].dateTried!
            notes = foodArray[buttonTag].motivation ?? " "
        }
        performSegue(withIdentifier: "expandDetail", sender: sender)
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var food: [NSManagedObject] = []
    var foodArray: [TriedFood]!
    var targetArray: [TargetFood]!
    
//   func viewWillAppear() {
//        super.viewWillAppear(true)
//        whereAmINowBeacon = .Main
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        whereAmINowBeacon = .Unknown
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        topBar.backButton.isHidden = true
//        topBar.titleLabel.text = "HappyFoods"
//        //mainCollectionView.register(mainCollectionViewCell.self, forCellWithReuseIdentifier: "mainCell") as! mainCollectionViewCell
//        // Do any additional setup after loading the view.
//        self.view.addSubview(topBar)
//        self.view.addSubview(ddummyButton)
//        NSLayoutConstraint.activate([
//                topBar.widthAnchor.constraint(equalTo: view.widthAnchor),
//                 topBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13),
//                  topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                   topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//            ])
//
//        NSLayoutConstraint.activate([
//            ddummyButton.widthAnchor.constraint(equalTo: view.widthAnchor),
//            ddummyButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13),
//            ddummyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            ddummyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//            ])
//
        loadItems()
        let datafilepath = FileManager.default.urls(for: .documentDirectory,
                                                    in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        
        print(datafilepath!)
       // topBarViewController.delegate
       /// containerView?.titleLabel.text = "Hello World"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
 
       
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return "HappyFoods Update"
    }
}

extension mainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width/3 - 16, height: collectionView.bounds.size.width/3 - 16)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! mainCollectionViewCell
        
      //  cell.layer.borderColor = UIColor.black.cgColor
      //  cell.layer.borderWidth = 1.0
        cell.cellImage.alpha = 1
        cell.tickImage.isHidden = true
        cell.delegate = self
       // cell.showDetailButton(self)
        cell.showDetailButtonProperties.tag = indexPath.row
       
        if indexPath.row < 6
        {
            if foodArray != nil
            {
                if indexPath.row < foodArray.count
                {
                    let plate = foodArray[indexPath.row]
                    let fileToLoad = plate.filename ?? "1.png"
                    //cell.cellImage.image = UIImage(named: "1.png")
                    cell.displayContent(image: fileToLoad)
                    cell.tickImage.isHidden = false
                }
                else
                {
                  cell.tickImage.isHidden = true
                }
            }
        }
       else
        {
            cell.tickImage.isHidden = true
            if targetArray != nil
            {
                if indexPath.row < 9 && targetArray.count > 9 - indexPath.row - 1
                {
                    let plate = targetArray[9 - indexPath.row - 1]
                    let fileToLoad = plate.filename ?? "1.png"
                    //cell.cellImage.image = UIImage(named: "1.png")
                    cell.displayContent(image: fileToLoad)
                    cell.cellImage.alpha = 0.2
                }
            }
        }
        
        return cell
    }
    
    /// MARK: Setup
    func loadItems(){
        let request : NSFetchRequest<TriedFood> = TriedFood.fetchRequest()
        do{
            try
                foodArray = context.fetch(request)
            print("food array")
                print(foodArray)
        }
        catch{
            print("Error fetching data \(error)")
        }
        
        let request2 : NSFetchRequest<TargetFood> = TargetFood.fetchRequest()
        do{
            try
                targetArray = context.fetch(request2)
                print("target array")
                print(targetArray)
        }
        catch{
            print("Error fetching data \(error)")
        }
    }
    
    public func canHandle(_ session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "addFoodSegue" {
            
            let dvc = segue.destination as! dataInputViewController
            
            if let button = sender as? UIButton
            {
                dvc.sourceViewController = button.titleLabel?.text ?? "Dunno"
            
            }
            
        }
        if segue.identifier == "expandDetail" {
            
            let dvc = segue.destination as! DetailViewController
            
//            photoFilename = foodArray[buttonTag].filename ?? "chaos.jpg"
//            foodName = foodArray[buttonTag].name ?? ""
//            rating = foodArray[buttonTag].rating
//            triedOn = foodArray[buttonTag].dateTried!
//            notes = foodArray[buttonTag].motivation ?? " "
//
            dvc.detailToDisplay =  (photoFilename: photoFilename, foodName: foodName, rating: rating, triedOn: triedOn, notes: notes)
          // dvc.loadView()
          //  dvc.reloadInputViews()
            
            //print("I'm in")
            /// code to fill in
//            if let button = sender as? UIButton
//            {
//                
//                 print(button.tag )
//                
//                /// acess that record
//                // I've messed up with how i handle possibility of undefinded value
//               // let sentFood = foodArray[button.tag]
//                
//              //  dvc.detailView.detailToDisplay.photoFilename = sentFood.filename ?? ""
//                dvc.detailView.detailToDisplay.foodName = String(button.tag)
//                
//                
//               // dvc.detailView.detailToDisplay = (photoFilename: sentFood.filename, foodName: sentFood.name , rating: sentFood.rating, triedOn: sentFood.dateTried, notes: sentFood.motivation)
//                var presentState = Costume.Unknown
////                dvc.sourceViewController = button.titleLabel?.text ?? "Dunno"
////
//            }
            
        }
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "My target is to try: RICE. I tried CARROTS on TUESDAY. I tried CARROTS on THURSDAY. "
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return "My target is to try: RICE. I tried CARROTS on TUESDAY. I tried CARROTS on THURSDAY. "
    }
    
    @objc func share() {
        let whatHaveITried = "My target is to try: RICE. I tried CARROTS on TUESDAY. I tried CARROTS on THURSDAY. "
    
        let activityViewController =
        UIActivityViewController(activityItems: [whatHaveITried],
        applicationActivities: nil)
    
        present(activityViewController, animated: true)
    }
}

