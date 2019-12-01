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
    var existingMotivationText: String?
    var placeHolderImage: String? 
    var rating = 0.0
    var foodName = String()
    var dateTargetSet = Date()
    
    // this would have been so much better doen as an enum
    var presentState = Costume.Unknown
    let datafilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let imagePickerView = UIImagePickerController()
    var firstPass = String()
    
    var historyArray: [History]?

    // MARK: Actions and outlets
    @IBAction func endedEnteringName(_ sender: Any) {
        self.view.endEditing(true)
    }
  
    @IBOutlet weak var moveOnButton: myButton!
    @IBOutlet weak var nameOfFood: UITextField!
    @IBOutlet weak var faceView: FaceView!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var motivationText: UITextView!
    

    @IBOutlet weak var imageView: UIImageView!

    @IBAction func saveFood(_ sender: Any) {
        appsAndBiscuits(imageName: nameOfFood.text, image: foodImage.image ?? (UIImage(named: "tick.png") ?? nil)!, rating: rating, notes: motivationText?.text ?? existingMotivationText  )
    }
    
    // MARK: Core Data helpers
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var food: [NSManagedObject] = []
    var foodArray: [Tried]!
    var targetArray: [Target]!


    // MARK: page lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 224/255, green: 250/255, blue: 233/255, alpha: 1)
        imagePickerView.allowsEditing = true
        loadItems()
        imagePickerView.delegate = self
        nameOfFood.delegate = self
        
        formatImage()
        nameOfFood.text = foodName
        
        // MARK: Colour
        
        weak var main = (navigationController?.viewControllers[0] as! newMainViewController)
        presentState = main?.myNav?.presentState ?? Costume.FirstLaunch
        
        if presentState == .SetTargetViewController || presentState ==  .FirstTarget
        {
            motivationText.delegate = self
        }

        switch  main?.myNav?.presentState {
        case .AddFoodViewController?, .RetryTriedFood?, .ConvertTargetToTry? :
            navigationItem.title = "Rate It!";
        case .SetTargetViewController?:
            navigationItem.title = "Motivate It"
        default:
            navigationItem.title = "Report Bug"
        }
        
        if presentState == .FirstLaunch{navigationItem.title = ""}
        
        setUpNavigationBarItems()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "faceSegue" {
            if let customFaceController = segue.destination as? customFaceARViewController{
                customFaceController.sliderFeedback( handler:  {[weak self] value in
                    self?.rating = Double(-1 + 2*value )
                })
            }
        }
    }
    
    /// MARK: Setup
    func loadItems(){
        let request : NSFetchRequest<Tried> = Tried.fetchRequest()
        do{
            try
                foodArray = context.fetch(request)
        }
        catch{
            print("Error fetching data \(error)")
        }
        
        
        let request2 : NSFetchRequest<Target> = Target.fetchRequest()
        do{
            try
                targetArray = context.fetch(request2)
        }
        catch{
            print("Error fetching data \(error)")
        }
    }
    
    func formatImage(){
            imagePlaceholder = cropImageToSquare(imagePlaceholder)
             foodImage?.image = imagePlaceholder

             foodImage?.translatesAutoresizingMaskIntoConstraints = false
             foodImage?.contentMode = .scaleAspectFill
             foodImage?.widthAnchor.constraint(equalToConstant: 100).isActive = true
             foodImage?.heightAnchor.constraint(equalToConstant: 100).isActive = true
             foodImage?.cornerRadius = 5
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
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return false
//    }
    
    func appsAndBiscuits(imageName: String?, image: UIImage, rating: Double?, notes: String?){
        weak var main = (navigationController?.viewControllers[0] as! newMainViewController)
        
        if firstPass == "Target" {
            presentState = .FirstTarget
            //self.navigationController?.navigationItem.hidesBackButton = true
            self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        }


        /// create an instance of filemanager
        let fileManager = FileManager.default
        
        /// make sure that this has a filename. Currently though this is a flawed implementation because it doesn't have a unique index for the food
        if let path = imagePath {print("Path is \(path)")}
        else{
            if let imageExtension = placeHolderImage
            {
                 imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageExtension)
            }
            else{
                var imageExtension =  imageName ?? ""
                if imageExtension == ""
                {
                    imageExtension = "temp"
                }
                imageExtension = imageExtension + String(Date().timeIntervalSince1970) + ".png"
                
                placeHolderImage = imageExtension
            
                imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageExtension)
            }
        }
        let image2 = image.resizeImage(targetSize: CGSize(width: 300, height: 300))
        let data = UIImage.pngData(image2)
        fileManager.createFile(atPath: imagePath!, contents: data(), attributes: nil)
        
    
        switch presentState {
            
        case .AddFoodViewController:
            /// this bit updates the database
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let menuItem = NSEntityDescription.insertNewObject(forEntityName: "Tried", into: managedObjectContext) as! Tried
                //menuItem.filename = imagePath
                menuItem.filename = placeHolderImage
                menuItem.name = imageName
                menuItem.rating = rating ?? 0
                menuItem.date = Date()
                menuItem.type = entryType.triedThisWeek.rawValue
                saveItems()
                /// now update the local display - so the user can immediately see the difference without me needing to dip into the database and reload the whole view
                main?.foodArray.append(menuItem)
                foodArray.append(menuItem)
                
                DispatchQueue.main.async{
                    main?.myCollectionView.reloadData()
                }
            }
            /// I don't think I use this now - but I should...
        case .ConvertTargetToTry:
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let targetSetString = formatter.string(from: dateTargetSet)
                
                let request2 : NSFetchRequest<Target> = Target.fetchRequest()
                do{
                    try targetArray = context.fetch(request2)
                }
                catch{
                    print("Error fetching data \(error)")
                }
                
                let listOfTimestamps = targetArray.compactMap{formatter.string(from: $0.date!)}
                let indexOfMyTimestamp = listOfTimestamps.firstIndex(of: targetSetString)
                
                managedObjectContext.delete(targetArray[indexOfMyTimestamp!])
                
                let menuItem = NSEntityDescription.insertNewObject(forEntityName: "Tried", into: managedObjectContext) as! Tried
                menuItem.filename = placeHolderImage
                menuItem.name = imageName
                menuItem.rating = rating ?? 0
                menuItem.date = Date()
                menuItem.notes = existingMotivationText
                menuItem.type = entryType.triedThisWeek.rawValue
                saveItems()
                
                main?.foodArray.append(menuItem)
                foodArray.append(menuItem)
                main?.targetArray.remove(at: indexOfMyTimestamp!)
                
                /// and reflag the target record
                
                
                DispatchQueue.main.async{
                    main?.myCollectionView.reloadData()
                }
            }
            
        case .RetryTriedFood:
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                let menuItem = NSEntityDescription.insertNewObject(forEntityName: "Tried", into: managedObjectContext) as! Tried
                menuItem.filename = placeHolderImage
                menuItem.name = imageName
                menuItem.rating = rating ?? 0
                menuItem.date = Date()
                menuItem.notes = existingMotivationText
                menuItem.type = entryType.triedThisWeek.rawValue
                saveItems()
                foodArray.append(menuItem)
                
                main?.foodArray.append(menuItem)
                
                DispatchQueue.main.async{
                    main?.myCollectionView.reloadData()
                }
            }
            
        case .SetTargetViewController:
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let menuItem = NSEntityDescription.insertNewObject(forEntityName: "Target", into: managedObjectContext) as! Target
                menuItem.filename = placeHolderImage
                menuItem.name = imageName
                menuItem.date = Date()
                menuItem.notes = notes
                menuItem.type = entryType.target.rawValue
                saveItems()
                
                main?.targetArray.append(menuItem)
                DispatchQueue.main.async{
                    main?.myCollectionView.reloadData()
                }
            }
            
        case .FirstLaunch:
            /// this bit updates the database
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let menuItem = NSEntityDescription.insertNewObject(forEntityName: "Tried", into: managedObjectContext) as! Tried
                menuItem.filename = placeHolderImage
                menuItem.name = imageName
                menuItem.rating = rating ?? 0
                menuItem.date = Date()
                saveItems()
                /// now update the local display - so the user can immediately see the difference without me needing to dip into the database and reload the whole view
                main?.foodArray = [menuItem]
                foodArray = [menuItem]
                
                DispatchQueue.main.async{
                    if main?.myCollectionView != nil
                    {
                        main?.myCollectionView.reloadData()
                    }
                    else{
                        print("NIL MCV CAUGHT!!!!!")
                    }
                }
            }
            
        case .FirstTarget:
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let menuItem = NSEntityDescription.insertNewObject(forEntityName: "Target", into: managedObjectContext) as! Target
                menuItem.filename = placeHolderImage
                menuItem.name = imageName
                menuItem.date = Date()
                menuItem.notes = notes
                saveItems()
                
                
                main?.targetArray = [menuItem]
                DispatchQueue.main.async{
                    if let colView  = main?.myCollectionView{
                        colView.reloadData()
                        print("I have a collection view")
                    }
                }
            }
        default: return
        }
        
        //navigationController?.popToRootViewController(animated: true)
        let happyUtterance = happySays()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if foodArray.count == 9{
            let nextViewController = storyboard.instantiateViewController(withIdentifier: "celebrationScreen" ) as! celebrationScreenViewController
            //nextViewController.message = happyUtterance.identifyContext(foodName: imageName, tryNumber: nil, logonNumber: nil, screen: screen.afterTryingaFoodScreen )
            let myNav = self.navigationController
            myNav?.pushViewController(nextViewController, animated: true)
            
            // wanna release navigation stack 
        }
        else{
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "confettiViewController" ) as! confettiViewController
        nextViewController.message = happyUtterance.identifyContext(foodName: imageName, tryNumber: nil, logonNumber: nil, screen: screen.afterTryingaFoodScreen )
        let myNav = self.navigationController
        myNav?.pushViewController(nextViewController, animated: true)
        }
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
    }
    
    // MARK: Handling user interaction
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if(text == "\n") {
//            textView.resignFirstResponder()
//            return false
//        }
//        return true
//    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn _: NSRange, replacementText text: String) -> Bool {
        let resultRange = text.rangeOfCharacter(from: CharacterSet.newlines, options: .backwards)
        if text.count == 1 && resultRange != nil {
            textView.resignFirstResponder()
            // Do any additional stuff here
            return false
        }
        return true
    }
    
    @objc func share() {
        
        var message = String()
        
        switch presentState {
        case .AddFoodViewController:
            let name = nameOfFood.text
            if name != nil && name != "" {
                message = "I've just tried " + (name ?? "something") + ". In the release version of the app, I will also report whether I liked the food or not!"
            }
            else {
                message = "I've just tried a new food!"
            }
        case .SetTargetViewController:
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
    
    func countOfThisFood() -> Int{
        let countOfThisFood = Int()

        if foodName == "" {
//            if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg" {
//                countOfThisFood = foodArray.filter({ $0.filename == detailToDisplay.photoFilename }).count
//            }
//            else {
//                countOfThisFood = 1
//            }
//        }
//        else{
//            if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg" {
//                countOfThisFood = foodArray.filter({ $0.filename == detailToDisplay.photoFilename || $0.name == detailToDisplay.foodName }).count
//            }
//            else{
//                 countOfThisFood = foodArray.filter({ $0.name == detailToDisplay.foodName }).count
//            }
        }

        
        if let history = historyArray
        {
            print(history)
//            if foodName == ""
//            {
//
//                if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg"
//                {
//                    countOfThisFood = countOfThisFood + history.filter({ $0.filename == detailToDisplay.photoFilename }).count
//                }
//            }
//            else
//            {
//
//                if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg"
//                {
//                    countOfThisFood = countOfThisFood + history.filter({ $0.filename == detailToDisplay.photoFilename || $0.name == detailToDisplay.foodName }).count
//                }
//                else
//                {
//                    countOfThisFood = countOfThisFood + history.filter({ $0.name == detailToDisplay.foodName }).count
//                }
//            }
        }
        
        return countOfThisFood
    }
}

