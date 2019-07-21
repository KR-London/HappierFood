//
//  rateFoodViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 06/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import CoreML
import AVFoundation
import Vision
import CoreData

class rateFoodViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    var imagePlaceholder = UIImage()
    var imagePath: String?
    
    var rating = 0.0
    var foodName = String()
    var dateTargetSet = Date()
    var presentState = String()
    let datafilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let imagePickerView = UIImagePickerController()
    var firstPass = String()

    // MARK: Actions and outlets
    @IBAction func endedEnteringName(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBOutlet weak var nameOfFood: UITextField!
    @IBOutlet weak var faceView: FaceView!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var motivationText: UITextView!
    

    @IBOutlet weak var imageView: UIImageView!

    @IBAction func saveFood(_ sender: Any) {
        appsAndBiscuits(imageName: nameOfFood.text, image: foodImage.image ?? (UIImage(named: "tick.png") ?? nil)!, rating: rating)
    }
    
    // MARK: Core Data helpers
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var food: [NSManagedObject] = []
    var foodArray: [TriedFood]!
    var targetArray: [TargetFood]!


    // MARK: page lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePickerView.allowsEditing = true
        loadItems()
        imagePickerView.delegate = self
        nameOfFood.delegate = self
//        weak var main = (navigationController?.viewControllers[0] as! mainViewController)
//        presentState = main!.myNav!.currentStateAsString()
        if presentState == "SetTargetViewController"
        {
 //           motivationText.delegate = self
        }

        imagePlaceholder = cropImageToSquare(imagePlaceholder)
        foodImage.image = imagePlaceholder

        foodImage.translatesAutoresizingMaskIntoConstraints = false
        foodImage.contentMode = .scaleAspectFill
        foodImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        nameOfFood.text = foodName
        
        setUpNavigationBarItems()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "faceSegue" {
            if let customFaceController = segue.destination as? customFaceARViewController{
                // self.customFaceController = customFaceController
                customFaceController.sliderFeedback( handler:  {[weak self] value in
                    self?.rating = Double(-1 + 2*value )
                })
            }
        }
    }
    
    /// MARK: Setup
    func loadItems(){
        let request : NSFetchRequest<TriedFood> = TriedFood.fetchRequest()
        do{
            try
                foodArray = context.fetch(request)
        }
        catch{
            print("Error fetching data \(error)")
        }
        
        
        let request2 : NSFetchRequest<TargetFood> = TargetFood.fetchRequest()
        do{
            try
                targetArray = context.fetch(request2)
        }
        catch{
            print("Error fetching data \(error)")
        }
    }
    
    // MARK: Save data
    
    func saveItems(){
        do{ try
            context.save() }
        catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func appsAndBiscuits(imageName: String?, image: UIImage, rating: Double?){
        weak var main = (navigationController?.viewControllers[0] as! mainViewController)
        
        if firstPass == "Target" {
            presentState = "First Target"
            //self.navigationController?.navigationItem.hidesBackButton = true
            self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        }


        /// create an instance of filemanager
        let fileManager = FileManager.default
        
        /// make sure that this has a filename. Currently though this is a flawed implementation because it doesn't have a unique index for the food
        if let path = imagePath {print("Path is \(path)")}
        else{
            var imageExtension = imageName ?? ""
            if imageExtension == ""
            {
                imageExtension = "temp"
            }
            imageExtension = imageExtension + String(Date().timeIntervalSince1970) + ".png"
            
            imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageExtension) 
        }
        let image2 = image.resizeImage(targetSize: CGSize(width: 300, height: 300))
        let data = UIImage.pngData(image2)
        fileManager.createFile(atPath: imagePath!, contents: data(), attributes: nil)
        
        
        
        switch presentState {
            
        case "AddFoodViewController":
            /// this bit updates the database
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let menuItem = NSEntityDescription.insertNewObject(forEntityName: "TriedFood", into: managedObjectContext) as! TriedFood
                menuItem.filename = imagePath
                menuItem.name = imageName
                menuItem.rating = rating ?? 0
                menuItem.dateTried = Date()
                saveItems()
                /// now update the local display - so the user can immediately see the difference without me needing to dip into the database and reload the whole view
                main?.foodArray.append(menuItem)
                
                DispatchQueue.main.async{
                    main?.mainCollectionView.reloadData()
                }
            }
            
        case "ConvertTargetToTry":
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
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
                
                managedObjectContext.delete(targetArray[indexOfMyTimestamp!])
                
                let menuItem = NSEntityDescription.insertNewObject(forEntityName: "TriedFood", into: managedObjectContext) as! TriedFood
                menuItem.filename = imagePath
                menuItem.name = imageName
                menuItem.rating = rating ?? 0
                menuItem.dateTried = Date()
                saveItems()
                
                main?.foodArray.append(menuItem)
                main?.targetArray.remove(at: indexOfMyTimestamp!)
                
                DispatchQueue.main.async{
                    main?.mainCollectionView.reloadData()
                }
            }
            
        case "RetryTriedFood":
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                let menuItem = NSEntityDescription.insertNewObject(forEntityName: "TriedFood", into: managedObjectContext) as! TriedFood
                menuItem.filename = imagePath
                menuItem.name = imageName
                menuItem.rating = rating ?? 0
                menuItem.dateTried = Date()
                saveItems()
                
                main?.foodArray.append(menuItem)
                
                DispatchQueue.main.async{
                    main?.mainCollectionView.reloadData()
                }
            }
            
        case "SetTargetViewController":
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let menuItem = NSEntityDescription.insertNewObject(forEntityName: "TargetFood", into: managedObjectContext) as! TargetFood
                menuItem.filename = imagePath
                menuItem.name = imageName
                menuItem.dateAdded = Date()
                saveItems()
                
                main?.targetArray.append(menuItem)
                DispatchQueue.main.async{
                    main?.mainCollectionView.reloadData()
                }
            }
            
        case "First Pass":
            /// this bit updates the database
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let menuItem = NSEntityDescription.insertNewObject(forEntityName: "TriedFood", into: managedObjectContext) as! TriedFood
                menuItem.filename = imagePath
                menuItem.name = imageName
                menuItem.rating = rating ?? 0
                menuItem.dateTried = Date()
                saveItems()
                /// now update the local display - so the user can immediately see the difference without me needing to dip into the database and reload the whole view
                main?.foodArray = [menuItem]
                
                DispatchQueue.main.async{
                    main?.mainCollectionView.reloadData()
                }
            }
            
        case "First Target":
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let menuItem = NSEntityDescription.insertNewObject(forEntityName: "TargetFood", into: managedObjectContext) as! TargetFood
                menuItem.filename = imagePath
                menuItem.name = imageName
                menuItem.dateAdded = Date()
                saveItems()
                
                main?.targetArray = [menuItem]
                DispatchQueue.main.async{
                    main?.mainCollectionView.reloadData()
                }
            }
        default: return
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    

    // MARK: Image processing
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        dismiss(animated: true, completion: nil)
        
        guard (info["UIImagePickerControllerOriginalImage"] as? UIImage) != nil else {
            return
        }
    }
    
    func cropImageToSquare(_ image: UIImage) -> UIImage {
        let orientation: UIDeviceOrientation = UIDevice.current.orientation
        var imageWidth = image.size.width
        var imageHeight = image.size.height
        switch orientation {
        case .landscapeLeft, .landscapeRight:
            // Swap width and height if orientation is landscape
            imageWidth = image.size.height
            imageHeight = image.size.width
        default:
            break
        }
        
        // The center coordinate along Y axis
        let rcy = imageHeight * 0.5
        let rect = CGRect(x: rcy - imageWidth * 0.5, y: 0, width: imageWidth, height: imageWidth)
        let imageRef = image.cgImage?.cropping(to: rect)
        return UIImage(cgImage: imageRef!, scale: 1.0, orientation: image.imageOrientation)
    }
    
    // MARK: Layout
 
    func setUpNavigationBarItems(){
        let shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(named: "share.png")?.resize(to: CGSize(width: 50,height: 100)), for: .normal)
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
        
        weak var main = (navigationController?.viewControllers[0] as! mainViewController)
        presentState = main?.myNav?.currentStateAsString() ?? "First Pass"
        
     

        switch  main?.myNav?.presentState {
        case .AddFoodViewController?, .RetryTriedFood?, .ConvertTargetToTry? :
            navigationItem.title = "Rate It!";
        case .SetTargetViewController?:
            navigationItem.title = "Motivate It"
        default:
            navigationItem.title = "Report Bug"
        }
        
        if presentState == "First Pass"{navigationItem.title = ""}
    }
    
    // MARK: Handling user interaction
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @objc func share() {
        
        var message = String()
        
        switch presentState {
        case "AddFoodViewController":
            let name = nameOfFood.text
            if name != nil && name != "" {
                message = "I've just tried " + (name ?? "something") + ". In the release version of the app, I will also report whether I liked the food or not!"
            }
            else {
                message = "I've just tried a new food!"
            }
        case "SetTargetViewController":
            let name = nameOfFood.text
            if name != nil && name != "" {
                message = "I've just set myself a target of trying " + (name ?? "something") + ". In the release version of the app, I will also report my motivation for trying this food."
            }
            else {
                message = "I've just tried a new food!"
            }
        default:
            message = "Debug message"
        }
        
        let activityViewController =
            UIActivityViewController(activityItems: [message],
                                     applicationActivities: nil)
        
        present(activityViewController, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

