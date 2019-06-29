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
    var detailToDisplay = (photoFilename: "tick.jpg", foodName: "not initialised", rating: 0.0, triedOn: Date(), notes: "" )

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
        
        /// wrap this up so that it gives a placeholder when no food name provided.
        detail2VC.foodName.text = self.detailToDisplay.foodName
        
        detail2VC.foodPicture.image = UIImage(named: detailToDisplay.photoFilename)
        detail3VC.detailToDisplay = detailToDisplay
        if PresentState == Costume.AddFoodViewController {
             detail3VC.faceView.isHidden = false
            detail3VC.faceView.mouthCurvature = detailToDisplay.rating
        }
        else  {
            detail3VC.faceView.isHidden = true
        }
        detail5VC.detailToDisplay = detailToDisplay
        detail5VC.whereAmI = PresentState
        
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
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: #selector(delete), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: deleteButton)
    }

    @objc func goBackToMain(sender: UIButton!){
        performSegue(withIdentifier: "detailToMain", sender: self)
    }
    
    @objc func delete(sender: UIButton!){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        switch PresentState{
            case .AddFoodViewController:
                var foodArray: [TriedFood]!
                let dateTried = detailToDisplay.triedOn
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let targetSetString = formatter.string(from: dateTried)
                
                let request2 : NSFetchRequest<TriedFood> = TriedFood.fetchRequest()
                do{
                    try foodArray = context.fetch(request2)
                }
                catch{
                    print("Error fetching data \(error)")
                }
                
               // print(foodArray)
                
                let listOfTimestamps = foodArray.compactMap{formatter.string(from: $0.dateTried!)}
                print(listOfTimestamps)
                let indexOfMyTimestamp = listOfTimestamps.firstIndex(of: targetSetString)
                print("indexOfMyTimestamp")
                print(indexOfMyTimestamp!)
                print(foodArray[indexOfMyTimestamp!])
                do{ try
                    context.delete(foodArray[indexOfMyTimestamp!])
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            
                performSegue(withIdentifier: "detailToMain", sender: UIButton.self)
            case .SetTargetViewController:
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
                print(listOfTimestamps)
                let indexOfMyTimestamp = listOfTimestamps.firstIndex(of: targetSetString)
                print("indexOfMyTimestamp")
                print(indexOfMyTimestamp!)
                print(targetArray[indexOfMyTimestamp!])
                do{
                    try context.delete(targetArray[indexOfMyTimestamp!])
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
//                } catch{  }
            
                performSegue(withIdentifier: "detailToMain", sender: UIButton.self)
            
            
            default:  break
        }
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
