//
//  detailViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 17/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController{

    var photoFilename = String()
    var foodName = String()
    var rating = Double()
    var triedOn = Date()
    var notes = String()
    var presentState = String()
    var detailToDisplay = (photoFilename: "tick.jpg", foodName: "not initialised", rating: 0.0, triedOn: Date(), notes: "" )
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var historyArray: [HistoryTriedFoods]?
    var foodArray: [TriedFood]!
    
    @IBOutlet weak var moveOnButton: UIButton!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var faceContainer: smileView!
    @IBOutlet weak var foodNameOutlet: UILabel!
    @IBOutlet weak var numberOfTries: UILabel!
    @IBOutlet weak var notesOutlet: UITextField!
    
    @IBAction func notesEdited(_ sender: Any) {
        detailToDisplay.notes = notesOutlet.text ?? ""
        notes = notesOutlet.text ?? ""
    }
    @IBOutlet weak var topFace: UIImageView!
    
    @IBAction func tryItAgainButton(_ sender: Any) {
        tryItAgain()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadItems()
        
        weak var main = navigationController?.viewControllers[0] as? mainViewController
        presentState = (main?.myNav?.currentStateAsString())!
        
        let filepath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(detailToDisplay.photoFilename)
        foodImage.image = UIImage(named: filepath)
        notesOutlet.borderStyle = UITextField.BorderStyle.none
        notesOutlet.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 20 )
        
        if detailToDisplay.notes == "" {
            notesOutlet.isHidden = true
        }
        else {
            notesOutlet.isHidden = false
        }
        
        // MARK: Colour
        
        moveOnButton.backgroundColor = UIColor(red: 186/255, green: 242/255, blue: 206/255, alpha: 1)
        
        switch detailToDisplay.rating {
            case -1...(-0.7) :
                topFace.image = UIImage(named: "eyesShut_browDownLeft.png")
            case -0.7...(-0.4) :
                topFace.image = UIImage(named: "eyeLookUpLeft_browDownLeft.png")
            case -0.4...(-0.1) :
                topFace.image = UIImage(named: "eyeLookOutLeft_browOuterUpLeft.png")
            case 0.1...(0.4) :
                topFace.image = UIImage(named: "eyeWideLeft_browDownLeft.png")
            case 0.4...(0.7) :
                topFace.image = UIImage(named: "eyeBlinkLeft_browOuterUpLeft.png")
            case 0.7...1 :
                topFace.image = UIImage(named: "eyeLookUpLeft_browDownLeft.png")
            default:
                topFace.image = UIImage(named: "eyeOpen_browDownLeft.png")
        }

        /// wrap this up so that it gives a placeholder when no food name provided.
        if detailToDisplay.foodName.count > 0{
            foodNameOutlet.text = detailToDisplay.foodName
        }
        else {
            //foodNameOutlet.text = "No food name stored, but"
            let unknownFood = ["Thingi-mi-bob", "Whatsit", "This", "That thing"]
            foodNameOutlet.text = unknownFood.randomElement()!
        }

        var countOfThisFood = Int()

        if foodName == "" {
            if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg" {
                countOfThisFood = foodArray.filter({ $0.filename == detailToDisplay.photoFilename }).count
            }
            else {
                countOfThisFood = 1
            }
        }
        else{
            if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg" {
                countOfThisFood = foodArray.filter({ $0.filename == detailToDisplay.photoFilename || $0.name == detailToDisplay.foodName }).count
            }
            else{
                 countOfThisFood = foodArray.filter({ $0.name == detailToDisplay.foodName }).count
            }
        }

        if let history = historyArray
        {
            
            if foodName == ""
            {
                
                if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg"
                {
                    countOfThisFood = countOfThisFood + history.filter({ $0.filename == detailToDisplay.photoFilename }).count
                }
            }
            else
            {
                
                if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg"
                {
                    countOfThisFood = countOfThisFood + history.filter({ $0.filename == detailToDisplay.photoFilename || $0.name == detailToDisplay.foodName }).count
                }
                else
                {
                    countOfThisFood = countOfThisFood + history.filter({ $0.name == detailToDisplay.foodName }).count
                }
            }
        }

        if countOfThisFood == 1
        {
            
           numberOfTries.text = ", tried once."
        }
        else
        {
            
             numberOfTries.text = ", tried \(countOfThisFood) times."
        }

        if presentState == "AddFoodViewController"
        {
           // faceContainer.isHidden = false
           // faceContainer.mouthCurvature = detailToDisplay.rating
            //faceContainer.drawSmile(mouthCurve: detailToDisplay.rating)
            //faceContainer.drawSmile(mouthCurve: <#T##Double#>)
        }
        else
        {
            faceContainer.isHidden = true
        }

        notesOutlet.text = detailToDisplay.notes
        setUpNavigationBarItems()
    }

    
    func setUpNavigationBarItems(){
        
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.titleLabel?.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 20 )
        deleteButton.addTarget(self, action: #selector(delete), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: deleteButton)
    }

    @objc func goBackToMain(sender: UIButton!){
        performSegue(withIdentifier: "detailToMain", sender: self)
    }
    
    @objc func delete(sender: UIButton!){
        
        weak var main = navigationController?.viewControllers[0] as? mainViewController
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        switch presentState{
            case "AddFoodViewController":
 
                let dateTried = detailToDisplay.triedOn
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let targetSetString = formatter.string(from: dateTried)
                
                let listOfTimestamps = foodArray.compactMap{formatter.string(from: $0.dateTried!)}
                let indexOfMyTimestamp = listOfTimestamps.firstIndex(of: targetSetString)
                  context.delete(foodArray[indexOfMyTimestamp!])
                do{
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }

                main?.foodArray.remove(at: indexOfMyTimestamp!)
                main?.mainCollectionView.reloadInputViews()
                
                navigationController?.popViewController(animated: true)

            case "SetTargetViewController":
                var targetArray: [TargetFood]!
                let dateTargetSet = detailToDisplay.triedOn
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let targetSetString = formatter.string(from: dateTargetSet)
                
                let request2 : NSFetchRequest<TargetFood> = TargetFood.fetchRequest()
                do{
                    try targetArray = context.fetch(request2)
                }
                catch{
                    print("Error fetching data \(error)")
                }
                
                let listOfTimestamps = targetArray.compactMap{formatter.string(from: $0.dateAdded!)}
                let indexOfMyTimestamp = listOfTimestamps.firstIndex(of: targetSetString)

                context.delete(targetArray[indexOfMyTimestamp!])
                do{
                    try context.save()
                }
                catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }

                main?.targetArray.remove(at: indexOfMyTimestamp!)
                main?.mainCollectionView.reloadInputViews()
                navigationController?.popViewController(animated: true)
    
            default:  break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailToRate"{
            let dvc = segue.destination as! rateFoodViewController
            let filepath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(detailToDisplay.photoFilename)
            dvc.imagePlaceholder = UIImage(named: filepath) ?? UIImage(named: "databasePlaceholderImage.001.jpg")!
            dvc.placeHolderImage = detailToDisplay.photoFilename
            dvc.imagePath = detailToDisplay.photoFilename
            dvc.foodName = detailToDisplay.foodName
            dvc.dateTargetSet = detailToDisplay.triedOn
            dvc.existingMotivationText = detailToDisplay.notes
        }
        
    }
    
    /// MARK: Setup
    func loadItems(){
        let request : NSFetchRequest<HistoryTriedFoods> = HistoryTriedFoods.fetchRequest()
        do{
            try historyArray = context.fetch(request)
        }
        catch{
            print("Error fetching data \(error)")
        }
        
        let request2 : NSFetchRequest<TriedFood> = TriedFood.fetchRequest()
        do{
            try foodArray = context.fetch(request2)
        }
        catch{
            print("Error fetching data \(error)")
        }

    }
    
    func tryItAgain(){
        
        weak var main = navigationController?.viewControllers[0] as? mainViewController
        if main?.myNav?.presentState == .AddFoodViewController{
            main?.myNav?.presentState = .RetryTriedFood
        }
        else{
            if main?.myNav?.presentState == .SetTargetViewController{
                main?.myNav?.presentState = .ConvertTargetToTry
            }
            else {
                main?.myNav?.presentState = .Unknown
            }
        }
        
        performSegue(withIdentifier: "detailToRate", sender: UIButton())
        
    }
}
