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
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var faceContainer: smileView!
    @IBOutlet weak var foodNameOutlet: UILabel!
    @IBOutlet weak var numberOfTries: UILabel!
    @IBOutlet weak var notesOutlet: UITextField!
    
    
    @IBAction func tryItAgainButton(_ sender: Any) {
        
        tryItAgain()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        weak var main = navigationController?.viewControllers[0] as? mainViewController
        presentState = (main?.myNav?.currentStateAsString())!
        
        foodImage.image = UIImage(named: detailToDisplay.photoFilename)
        faceContainer.mouthCurvature = -1
       // faceContainer.reloadI

        /// wrap this up so that it gives a placeholder when no food name provided.
        if detailToDisplay.foodName.count > 0{
            foodNameOutlet.text = detailToDisplay.foodName
        }
        else {
            foodNameOutlet.text = "No food name stored, but"
        }
//
        /// I'm going to do something else - I'm going to load in from history and count the number of tries
        ///
        ///

        var countOfThisFood = Int()

        if foodName == "" {
            if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg"
            {
                countOfThisFood = foodArray.filter({ $0.filename == detailToDisplay.photoFilename }).count
            }
            else
            {
                countOfThisFood = 1
            }
        }
        else{
            if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg"
            {
                countOfThisFood = foodArray.filter({ $0.filename == detailToDisplay.photoFilename || $0.name == detailToDisplay.foodName }).count
            }
            else{
                 countOfThisFood = foodArray.filter({ $0.name == detailToDisplay.foodName }).count
            }
        }

        if let history = historyArray{
            if foodName == "" {
                if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg"
                {
                    countOfThisFood = countOfThisFood + history.filter({ $0.filename == detailToDisplay.photoFilename }).count
                }
            }
             else{
                if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg"
                {
                    countOfThisFood = countOfThisFood + history.filter({ $0.filename == detailToDisplay.photoFilename || $0.name == detailToDisplay.foodName }).count
                }
                else{
                    countOfThisFood = countOfThisFood + history.filter({ $0.name == detailToDisplay.foodName }).count
                }
            }
        }

        if countOfThisFood == 1
        {
           numberOfTries.text = "tried once."
        }
        else
        {
             numberOfTries.text = "tried \(countOfThisFood) times."
        }


        if presentState == "AddFoodViewController" {
             faceContainer.isHidden = false
            faceContainer.mouthCurvature = detailToDisplay.rating
        }
        else  {
            faceContainer.isHidden = true
        }

        notesOutlet.text = detailToDisplay.notes
//
//        detail5VC.detailToDisplay = detailToDisplay
//        detail5VC.buttonPress( handler:  {[weak self] value in
//
//        if main?.myNav?.presentState == .AddFoodViewController{
//                main?.myNav?.presentState = .RetryTriedFood
//                }
//           else{
//                if main?.myNav?.presentState == .SetTargetViewController{
//                    main?.myNav?.presentState = .ConvertTargetToTry
//                }
//                else {
//                    main?.myNav?.presentState = .Unknown
//                }
//            }
//
//            self!.performSegue(withIdentifier: "detailToRate", sender: UIButton())
//
//        })
//
//        switch main!.myNav!.presentState {
//        case .AddFoodViewController:
//            detail5VC.tryButton.setTitle("Try it again?", for: .normal)
//        case .SetTargetViewController:
//            detail5VC.tryButton.setTitle("Try this food?", for: .normal)
//        default:
//            detail5VC.tryButton.setTitle("Bug", for: .normal)
//        }
        
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
                
//                let request2 : NSFetchRequest<TriedFood> = TriedFood.fetchRequest()
//                do{
//                    try foodArray = context.fetch(request2)
//                }
//                catch{
//                    print("Error fetching data \(error)")
//                }
                
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
            dvc.imagePlaceholder = UIImage(named: detailToDisplay.photoFilename) ?? UIImage(named: "databasePlaceholderImage.001.jpg")!
            dvc.imagePath = detailToDisplay.photoFilename
            dvc.foodName = detailToDisplay.foodName
            dvc.dateTargetSet = detailToDisplay.triedOn
            dvc.existingMotivationText = detailToDisplay.notes
        }
        
     //   if segue.identifier == "faceSegue" {
         //   if let customFaceController = segue.destination as? customFaceARViewController{
                // self.customFaceController = customFaceController
//                customFaceController.sliderFeedback( handler:  {[weak self] value in
//                    self?.rating = Double(-1 + 2*value )
             //   guard let dvc = segue.destination as! customFaceARViewController
             //       else {  dvc.updateUI(-1)}
              //  }
         //   }
      //  }
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
   
        
    
        
//        switch main!.myNav!.presentState {
//        case .AddFoodViewController:
//            detail5VC.tryButton.setTitle("Try it again?", for: .normal)
//        case .SetTargetViewController:
//            detail5VC.tryButton.setTitle("Try this food?", for: .normal)
//        default:
//            detail5VC.tryButton.setTitle("Bug", for: .normal)
//        }
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

    
    // MARK: Layout subroutines
    
//    private func setupLayoutNew( container1 : UIView, container2 : UIView) {
//
//        container1.translatesAutoresizingMaskIntoConstraints = false
//        container2.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            container1.topAnchor.constraint(equalTo: self.view.topAnchor),
//            container1.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//            container1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            container1.heightAnchor.constraint(equalTo: self.view.widthAnchor),
//            ])
//        NSLayoutConstraint.activate([
//            container2.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//            container2.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//            container2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            container2.topAnchor.constraint(equalTo: container1.bottomAnchor),
//            ])

//        NSLayoutConstraint.activate([
//            container3.topAnchor.constraint(equalTo: container2.bottomAnchor),
//            container3.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1 ),
//            container3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            container3.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3),
//            ])
//        NSLayoutConstraint.activate([
//            container4.topAnchor.constraint(equalTo: container3.bottomAnchor),
//            container4.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
//            container4.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            container4.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
//            ])
//
//        NSLayoutConstraint.activate([
//            container5.topAnchor.constraint(equalTo: container4.bottomAnchor),
//            container5.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
//            container5.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            container5.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
//            ])
//    }
//
//    private func setupLayout( container1 : UIView, container2 : UIView, container3 : UIView, container4 : UIView, container5 : UIView) {
//
//        container1.translatesAutoresizingMaskIntoConstraints = false
//        container2.translatesAutoresizingMaskIntoConstraints = false
//        container3.translatesAutoresizingMaskIntoConstraints = false
//        container4.translatesAutoresizingMaskIntoConstraints = false
//        container5.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            container1.topAnchor.constraint(equalTo: view.topAnchor),
//            container1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
//            container1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            container1.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1),
//            ])
//        NSLayoutConstraint.activate([
//            container2.topAnchor.constraint(equalTo: container1.bottomAnchor),
//            container2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1 ),
//            container2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            container2.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
//            ])
//
//        NSLayoutConstraint.activate([
//            container3.topAnchor.constraint(equalTo: container2.bottomAnchor),
//            container3.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1 ),
//            container3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            container3.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3),
//            ])
//        NSLayoutConstraint.activate([
//            container4.topAnchor.constraint(equalTo: container3.bottomAnchor),
//            container4.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
//            container4.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            container4.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
//            ])
//
//        NSLayoutConstraint.activate([
//            container5.topAnchor.constraint(equalTo: container4.bottomAnchor),
//            container5.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
//            container5.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            container5.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
//            ])
//    }
}
