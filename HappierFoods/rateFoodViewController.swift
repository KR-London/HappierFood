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
    var rating = 0.0
    var foodName = String()
    var dateTargetSet = Date()
    
    //KIRBY
    
    var presentState = String()
   // var presentState: Costume = Costume.Unknown

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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var food: [NSManagedObject] = []
    var foodArray: [TriedFood]!
    var targetArray: [TargetFood]!

    let datafilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let imagePickerView = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePickerView.allowsEditing = true
        loadItems()
        imagePickerView.delegate = self
        nameOfFood.delegate = self
        weak var main = (navigationController?.viewControllers[0] as! mainViewController)
        presentState = main!.myNav!.currentStateAsString()
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
        //print(foodImage)
       // if foodName != nil{
            nameOfFood.text = foodName
        //}
        //detect(image: CIImage(image: imagePlaceholder)!)
        
        setUpNavigationBarItems()
        switch  main!.myNav!.presentState {
            case .AddFoodViewController:
                navigationItem.title = "Rate It!";
            case .SetTargetViewController:
                navigationItem.title = "Motivate It"
            default:
                navigationItem.title = "Report Bug"
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        dismiss(animated: true, completion: nil)
        
        guard (info["UIImagePickerControllerOriginalImage"] as? UIImage) != nil else {
            return
        }
    //    processImage(image)
    }
    
//    func processImage(_ image: UIImage) {
//        let model = Food101()
//        let size = CGSize(width: 299, height: 299)
//
//        guard let buffer = image.resize(to: size)?.pixelBuffer() else {
//            fatalError("Scaling or converting to pixel buffer failed!")
//        }
//
//        guard let result = try? model.prediction(image: buffer) else {
//            fatalError("Prediction failed!")
//        }
//
//        let confidence = result.foodConfidence["\(result.classLabel)"]! * 100.0
//        let converted = String(format: "%.2f", confidence)
//
//        foodImage.image = image
//        nameOfFood.text = "\(result.classLabel) - \(converted) %"
//    }

//   func detect(image: CIImage){
//        let model = try? VNCoreMLModel(for: Food101().model)
//        
//        let request = VNCoreMLRequest(model: model!){(request, error) in
//            let result = request.results as! [VNClassificationObservation]
//            
//            print(result)
//            
//            let topHit = result.first
//            
//            if Double((topHit?.confidence)!) >= 0.7
//            {
//                self.nameOfFood.text = topHit?.identifier
//            }
//  
//        }
//        
//        let handler = VNImageRequestHandler(ciImage: image)
//        
//        try! handler.perform([request])
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.resignFirstResponder()
    return true
    }
    
    func saveItems(){
        do{ try
            context.save() }
        catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            
        }
    }
    
    func appsAndBiscuits(imageName: String?, image: UIImage, rating: Double?){
        
        /// create an instance of filemanager
        let fileManager = FileManager.default
        
        /// make sure that this has a filename. Currently though this is a flawed implementation because it doesn't have a unique index for the foon
        var imageExtension = imageName ?? ""
        if imageExtension == ""
        {
           imageExtension = "temp"
        }
        imageExtension = imageExtension + String(Date().timeIntervalSince1970) + ".png"
        
        /// get the image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageExtension)
        let image2 = image.resizeImage(targetSize: CGSize(width: 300, height: 300))
        let data = UIImage.pngData(image2)
        fileManager.createFile(atPath: imagePath as String, contents: data(), attributes: nil)
        
        weak var main = (navigationController?.viewControllers[0] as! mainViewController)
        
        ///KIRBY
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
                        //weak var main = (navigationController?.viewControllers[0] as! mainViewController)
                      // let currentNumberTried = main?.foodArray.count ?? 0
                        main?.foodArray.append(menuItem)
                        
//                        main?.mainCollectionView.performBatchUpdates({
//                           // main?.foodArray.append(menuItem)
//                           // main?.mainCollectionView.reloadData()
//                            //main?.mainCollectionView.reloadSections([0])
//                            main?.mainCollectionView.deleteItems(at: [IndexPath(row: currentNumberTried, section: 0)])
//                            main?.mainCollectionView.insertItems(at: [IndexPath(row: currentNumberTried, section: 0)])
//                           // main?.mainCollectionView.reloadInputViews()
//                        })
                        
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
   
                /// now update the local display - so the user can immediately see the difference without me needing to dip into the database and reload the whole view
//                weak var main = (navigationController?.viewControllers[0] as! mainViewController)
//                let currentNumberTried = main?.foodArray.count ?? 0
//                main?.foodArray.append(menuItem)
//                
//                main?.mainCollectionView.performBatchUpdates({
//                    // main?.foodArray.append(menuItem)
//                    // main?.mainCollectionView.reloadData()
//                    //main?.mainCollectionView.reloadSections([0])
//                    main?.mainCollectionView.deleteItems(at: [IndexPath(row: currentNumberTried, section: 0)])
//                    main?.mainCollectionView.insertItems(at: [IndexPath(row: currentNumberTried, section: 0)])
//                    // main?.mainCollectionView.reloadInputViews()
//                })
                
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
            
            default: return
    }
        
//        if let _ = navigationController{
        navigationController?.popToRootViewController(animated: true)
//        }
//        else{
//           performSegue(withIdentifier: "takeMeHome", sender: self)
      //  }
    }
   
    
    /// MARK: Setup
    func loadItems(){
        let request : NSFetchRequest<TriedFood> = TriedFood.fetchRequest()
        do{
            try
                foodArray = context.fetch(request)
        }
        catch
        {
            print("Error fetching data \(error)")
        }
        
        
        let request2 : NSFetchRequest<TargetFood> = TargetFood.fetchRequest()
        do{
            try
                targetArray = context.fetch(request2)
        }
        catch
        {
            print("Error fetching data \(error)")
        }
    }
    
    public func canHandle(_ session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
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
    
    @objc func share() {
        
        var message = String()

        switch presentState {
        case "AddFoodViewController":
            let name = nameOfFood.text
            if name != nil && name != ""
            {
                message = "I've just tried " + (name ?? "something") + ". In the release version of the app, I will also report whether I liked the food or not!"
            }
            else
            {
                message = "I've just tried a new food!"
            }
        case "SetTargetViewController":
            let name = nameOfFood.text
            if name != nil && name != ""
            {
                message = "I've just set myself a target of trying " + (name ?? "something") + ". In the release version of the app, I will also report my motivation for trying this food."
            }
            else
            {
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
    
    func setUpNavigationBarItems(){
        
        //  navigationItem.title = "Title"
        
        //        let backButton = UIButton(type: .system)
        //        backButton.setTitle("< Back", for: .normal)
        //        backButton.addTarget(self, action: #selector(goBackToMain), for: .touchUpInside)
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        let shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(named: "share.png")?.resize(to: CGSize(width: 50,height: 100)), for: .normal)
        // shareButton.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        // shareButton.contentMode = .right
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
        
        //navigationItem.
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    deinit{
        print("OS reclaiming memory from rate food view")
    }
}

