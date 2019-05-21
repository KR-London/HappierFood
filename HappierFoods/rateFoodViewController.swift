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
    
    var presentState: Costume = Costume.Unknown
    
    
    @IBOutlet weak var containerViewAddFood: topView!
    @IBOutlet weak var containerView: topView!
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
        
        //performSegue(withIdentifier: "takeMeHome", sender: self)
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var food: [NSManagedObject] = []
    var foodArray: [TriedFood]!
    var targetArray: [TargetFood]!

    
    /// where am I using this....?
    let datafilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let imagePickerView = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//faceView.isHidden = true
        imagePickerView.allowsEditing = true
        
        loadItems()
        imagePickerView.delegate = self
        nameOfFood.delegate = self
        if presentState == .SetTargetViewController
        {
            motivationText.delegate = self
        }
        
        imagePlaceholder = cropImageToSquare(imagePlaceholder)
        foodImage.image = imagePlaceholder
        
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        foodImage.contentMode = .scaleAspectFill
        foodImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        if foodName != nil{
            nameOfFood.text = foodName
        }
        
        
      //  detect(image: CIImage(image: imagePlaceholder)!)
        
        
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        dismiss(animated: true, completion: nil)
        
        guard let image = info["UIImagePickerControllerOriginalImage"] as? UIImage else {
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
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageExtension ?? "")
        
        let image2 = image.resizeImage(targetSize: CGSize(width: 300, height: 300))
        
        let data = UIImage.pngData(image2)
        
        fileManager.createFile(atPath: imagePath as String, contents: data(), attributes: nil)
        
        
        switch presentState {
     
            case .AddFoodViewController:
                    if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                        let menuItem = NSEntityDescription.insertNewObject(forEntityName: "TriedFood", into: managedObjectContext) as! TriedFood
                        menuItem.filename = imagePath
                        menuItem.name = imageName
                        menuItem.rating = rating ?? 0
                        menuItem.dateTried = Date()
                        saveItems()
                    }
        case .SetTargetViewController:
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let menuItem = NSEntityDescription.insertNewObject(forEntityName: "TargetFood", into: managedObjectContext) as! TargetFood
                menuItem.filename = imagePath
                menuItem.name = imageName
                saveItems()
            }
            
            default: return
    }
        
        performSegue(withIdentifier: "takeMeHome", sender: self)
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
    
}
