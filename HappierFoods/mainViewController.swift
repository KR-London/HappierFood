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

enum cellState : String {
    case TriedFood
    case TargetFood
    case Empty
    case Unknown
}

var whereAmINowBeacon = location.Unknown

class mainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var photoFilename = String()
    var foodName = String()
    var rating = Double()
    var triedOn = Date()
    var notes = String()
    
    var cellStatusDictionary = [ Int : cellState ]()

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    @IBAction func expandDetailButtonPressed(_ sender: UIButton) {
        let buttonTag = sender.tag
        if buttonTag < foodArray.count {
            photoFilename = foodArray[buttonTag].filename ?? "chaos.jpg"
            foodName = foodArray[buttonTag].name ?? ""
            rating = foodArray[buttonTag].rating
            triedOn = foodArray[buttonTag].dateTried!
            notes = foodArray[buttonTag].motivation ?? " "
        }
        
        //if buttonTag > 9 - targetArray.count
        performSegue(withIdentifier: "expandDetail", sender: sender)
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var food: [NSManagedObject] = []
    var foodArray: [TriedFood]!
    var targetArray: [TargetFood]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBarItems()
        loadItems()
        
        if let fruits = getPlist(withName: "UsageStatus") {
            print(fruits)
        }
        
        if let path = Bundle.main.path(forResource: "UsageStatus", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            if let dict = dictRoot  {
                if dict["CelebrationTriggered"] as! Bool == false && foodArray.count == 9
                {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "celebrationScreen")
                        self.present(newViewController, animated: true, completion: nil)
                    }
                    print("I'm ready to partay!!!")
                }
            }
        }
        
        let datafilepath = FileManager.default.urls(for: .documentDirectory,
                                                    in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        print(datafilepath!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return "HappyFoods Update"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "addFoodSegue" || segue.identifier == "setTargetSegue"{
            
            let dvc = segue.destination as! dataInputViewController
            
            if let button = sender as? UIButton{
                dvc.sourceViewController = button.titleLabel?.text ?? "Dunno"
            }
        }
        if segue.identifier == "expandDetail" {
            let dvc = segue.destination as! DetailViewController
            dvc.detailToDisplay =  (photoFilename: photoFilename, foodName: foodName, rating: rating, triedOn: triedOn, notes: notes)
        }
    }
    
    func setUpNavigationBarItems(){
        navigationItem.title = "HappyFoods"
        
        let shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(named: "share.png")?.resize(to: CGSize(width: 50,height: 100)), for: .normal)
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
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
        }
        catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    @objc func share() {
        
        var whatHaveITried = String()
        var whatItarget = String()
        
        if foodArray.count > 0 {
            let triedFoodReport = foodArray.compactMap{$0.name}.filter{$0 != ""}
            if triedFoodReport.count >= 0
            {
                whatHaveITried = "This week I have tried" + triedFoodReport.flatMap{" " + $0 + ","}
                whatHaveITried = String(whatHaveITried.dropLast())
                if triedFoodReport.count < foodArray.count{
                    whatHaveITried = whatHaveITried + " and " + String(foodArray.count - triedFoodReport.count) + " foods that I don't have a name stored for."
                }
                else{
                    whatHaveITried = whatHaveITried + "."
                }
            }
            else{
                whatHaveITried = "I have tried " + String(foodArray.count) + " foods that I don't have a name stored for."
            }
           
        }
        else {
            whatHaveITried = "I haven't tried anything new yet this week. "
        }
        
        if targetArray.count > 0 {
            let targetFoodReport = targetArray.compactMap{$0.name}.filter{$0 != ""}
            if targetFoodReport.count > 0
            {
                whatItarget = "This week my targets are to try" + targetFoodReport.flatMap{" " + $0 + ","}
                whatItarget = String(whatItarget.dropLast())
                if targetFoodReport.count < foodArray.count{
                    whatItarget = whatItarget + " and " + String(targetArray.count - targetFoodReport.count) + " foods that I don't have a name stored for."
                }
                else{
                    whatItarget = whatItarget + "."
                }
            }
            else{
              whatItarget = "I have targeted " + String(targetArray.count) + " foods that I don't have a name stored for."
            }
        }
        else {
            whatItarget = "I haven't set any targets this week."
        }
    
        let activityViewController = UIActivityViewController(activityItems: [whatHaveITried, whatItarget], applicationActivities: nil)
        present(activityViewController, animated: true)
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
        cell.cellImage.alpha = 1
        cell.tickImage.isHidden = true
        cell.showDetailButtonProperties.tag = indexPath.row
       
       // if indexPath.row < 6 {
            if foodArray != nil {
                if indexPath.row < foodArray.count {
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
      //  }
    //   else
     //   {
        
            if targetArray != nil {
                if indexPath.row < 9 && targetArray.count > 9 - indexPath.row - 1 {
                    let plate = targetArray[9 - indexPath.row - 1]
                    let fileToLoad = plate.filename ?? "1.png"
                    cell.displayContent(image: fileToLoad)
                    cell.cellImage.alpha = 0.2
                    cell.tickImage.isHidden = true
                }
            }
       // }
        
        return cell
    }
    
    /// MARK: Setup
    func loadItems(){
        let request : NSFetchRequest<TriedFood> = TriedFood.fetchRequest()
        do{
            try foodArray = context.fetch(request)
        }
        catch{
            print("Error fetching data \(error)")
        }
        
        let request2 : NSFetchRequest<TargetFood> = TargetFood.fetchRequest()
        do{
            try targetArray = context.fetch(request2)
        }
        catch{
            print("Error fetching data \(error)")
        }
    }
    
    public func canHandle(_ session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
//    func checkCelebrationStatus()
//    {
//        
//        
//    }
    
    
    func getPlist(withName name: String) -> [AnyObject]?
    {
        if  let path = Bundle.main.path(forResource: name, ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path)
        {
            return (try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)) as? [AnyObject]
        }
        
        return nil
    }
  
}

