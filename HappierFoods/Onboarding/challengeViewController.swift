//
//  challengeViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 26/11/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import Foundation

class challengeViewController: UIViewController, UIImagePickerControllerDelegate, AVCapturePhotoCaptureDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var instructionLabel: UILabel!
  
        var imagePath: String?
        var placeHolderImage: String?
    
        /// initialise all the elements programatically
        lazy var triesCollectionView: UICollectionView = {
            
            let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .horizontal
            
            let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            collection.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
      
            return collection
        }()
        
        lazy var targetsCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            collection.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            return collection
          }()
        
        lazy var recordChallengeButton: myButton = {
            let button = myButton()
            button.setTitle("I did it!", for: .normal)
            button.addTarget(self, action: #selector(recordChallenge), for: .touchUpInside)
            return button
        }()
        
        lazy var previewView: UIImageView = {
            let imageView = UIImageView()
            return imageView
        }()
        
        lazy var foodImage: UIImageView = {
            let imageView = UIImageView()
            return imageView
        }()
        
        lazy var addButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = UIColor(red: 186/255, green: 242/255, blue: 206/255, alpha: 1)
            button.setTitle("+", for: .normal)
            button.titleLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            button.titleLabel?.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 106 )
            button.titleLabel?.textAlignment = .center
            button.layer.borderWidth = 5.0
            button.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            button.addTarget(self, action: #selector(pictureInput), for: .touchUpInside)
            return button
        }()
        lazy var textInput: UITextField = {
            let foodName = UITextField()
            foodName.layer.borderWidth = 5.0
            foodName.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            foodName.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            foodName.placeholder = "Name of food"
            foodName.adjustsFontSizeToFitWidth = true
            foodName.textAlignment = .center
            foodName.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 18 )
            foodName.setLeftPaddingPoints(5)
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
        
        var image: UIImage?
        let haptic = UINotificationFeedbackGenerator()
        unowned var myNav : customNavigationController?
        
        let placeholderImages = ["1plate.jpeg", "2plate.jpeg", "3plate.jpeg", "4plate.jpeg", "5plate.jpeg"]
        
        // MARK: AV init helpers
        let imagePicker = UIImagePickerController()
        var captureSession: AVCaptureSession!
        var stillImageOutput: AVCapturePhotoOutput!
        var videoPreviewLayer: AVCaptureVideoPreviewLayer!
        
        var nextViewController = confettiViewController()
        
        // MARK: Core Data variables
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var food: [NSManagedObject] = []
        var ChallengeFoodsArray: [Challenge]!
        
        var selectedIndexPath : IndexPath?
        var currentChallenge = String()
    
    let challenges = [
             "Make a dish containing only items beginning with 'T'", //1
             "What is the king of dips, and what can make it better?",
             "Balance three vegetables on top of each other and photograph it",
             "Make your dinner into a face",
             "Present and name your dinner like how it would look in a Michelin Restaurant",
             "The ugliest nugget",
             "Fry the weirdest thing you can",
             "Make a dish containing only items beginning with 'T'",
             "What is the king of dips, and what can make it better?",
             "Balance three vegetables on top of each other and photograph it",
             "Make your dinner into a face", //11
             "Present and name your dinner like how it would look in a Michelin Restaurant",
             "The ugliest nugget",
             "Fry the weirdest thing you can",
             "Make a dish containing only items beginning with 'T'",
             "What is the king of dips, and what can make it better?",
             "Balance three vegetables on top of each other and photograph it",
             "Make your dinner into a face",
             "Present and name your dinner like how it would look in a Michelin Restaurant",
             "The ugliest nugget",
             "Fry the weirdest thing you can", //21
             "Make a dish containing only items beginning with 'T'",
             "What is the king of dips, and what can make it better?",
             "Balance three vegetables on top of each other and photograph it",
             "Make your dinner into a face",
             "Present and name your dinner like how it would look in a Michelin Restaurant",
             "The ugliest nugget",
             "Fry the weirdest thing you can",
             "Make a dish containing only items beginning with 'T'",
             "What is the king of dips, and what can make it better?",
             "Balance three vegetables on top of each other and photograph it", //31
             "Make your dinner into a face",
             "Present and name your dinner like how it would look in a Michelin Restaurant",
             "The ugliest nugget",
             "Fry the weirdest thing you can",
             "Make a dish containing only items beginning with 'T'",
             "What is the king of dips, and what can make it better?",
             "Balance three vegetables on top of each other and photograph it",
             "Make your dinner into a face",
             "Present and name your dinner like how it would look in a Michelin Restaurant",
             "The ugliest nugget", //41
             "Fry the weirdest thing you can",
             "Make a dish containing only items beginning with 'T'",
             "What is the king of dips, and what can make it better?",
             "Balance three vegetables on top of each other and photograph it",
             "Make your dinner into a face",
             "Present and name your dinner like how it would look in a Michelin Restaurant",
             "The ugliest nugget",
             "Fry the weirdest thing you can",
             "Make a dish containing only items beginning with 'T'",
             "Best Christmassy snack", //51
             "Wildest Christmassy Plate of food", //christmas
             "Make your dinner into a face", //new year
         ]
        
    
    let challengeDictionary: [String:String] = [
        "Make a dish containing only items beginning with 'T'" :"A dish containing only items beginning with 'T'", //1
        "What is the king of dips, and what can make it better?" : "King of dips",
        "Balance three vegetables on top of each other and photograph it" : "Three vegetable tower",
        "Make your dinner into a face" : "Face dinner",
        "Present and name your dinner like how it would look in a Michelin Restaurant" : "Haute cuisine",
        "The ugliest nugget" : "Ugly nugget",
        "Fry the weirdest thing you can" : "Weird Fry",
                "Best Christmassy snack": "Christmas snacking!", //51
        "Wildest Christmassy Plate of food": "Boss Christmas dinner!", //christmas
        "Express a New Year Resolution as a plate of food": "New Years resolution" //new year
            ]
 override func viewDidLoad() {
       super.viewDidLoad()

      // loadItems()
       
       view.backgroundColor = UIColor(red: 224/255, green: 250/255, blue: 233/255, alpha: 1)
       
       setUpSubview()
       setUpNavigationBarItems()
       
     
    
       /// update this implementation to make it a 'challenge of the week' or 'challenge of the day' thing.
        /// I want a dictionary/mapping of week to challenge
    /// Hard code a week worth of challenges
    
    
    
        currentChallenge = thisWeeksChallenge()
        instructionLabel.text = currentChallenge
   }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            haptic.prepare()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
               super.viewWillDisappear(animated)
               if usedCamera == true {
                   self.captureSession?.stopRunning()
               }
           }
        
        //MARK: Data Input Subroutines
        func launchCamera(){
            previewView.isHidden = false
            recordTheFood()
        }
    
        func thisWeeksChallenge() -> String{
            let calendar = Calendar.current
            let weekOfYear = calendar.component(.weekOfYear, from: Date.init(timeIntervalSinceNow: 0))
            return challenges[weekOfYear - 1]
            
        }
        
        func pickFromCameraRoll(){
            imagePicker.delegate = self
                  imagePicker.sourceType = .photoLibrary
                  foodImage.isHidden = false
                  present(imagePicker, animated: true, completion: nil)
            
        }
        
        // MARK: Functions to manage the image input
          func setupLivePreview() {
            let layoutUnit = (self.view.frame.height - (self.navigationController?.navigationBar.frame.height ?? 0))/8
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer.videoGravity = .resizeAspectFill
            videoPreviewLayer.connection?.videoOrientation = .portrait
            videoPreviewLayer.cornerRadius = 1.5*layoutUnit
            previewView.layer.addSublayer(videoPreviewLayer)
          }
        
          func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
                guard let imageData = photo.fileDataRepresentation()
                  else { return }
            image = UIImage(data: imageData)?.cropImageToSquare() ?? UIImage(named: "chaos.jpg")!
                foodImage.image = image
                foodImage.layer.masksToBounds = true
              //  nextViewController.imagePlaceholder = image ?? UIImage(named: placeholderImages.randomElement()!)!
              //  nextViewController.foodName.text = textInput.text ?? ""
               // nextViewController.formatImage()
            
          }
          
          func presentCameraSettings() {
              let alertController = UIAlertController(title: "Error",
                                                      message: "Camera access is denied",
                                                      preferredStyle: .alert)
              alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
              alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
                  if let url = URL(string: UIApplication.openSettingsURLString) {
                      UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                      })
                  }
              })
              
              present(alertController, animated: true)
          }
          
          func checkCameraAccess() -> Bool {
              switch AVCaptureDevice.authorizationStatus(for: .video) {
              case .denied:
                  print("Denied, request permission from settings")
                  //presentCameraSettings()
                  pickFromCameraRoll()
                  return false
              case .restricted:
                  print("Restricted, device owner must approve")
              case .authorized:
                  print("Authorized, proceed")
              case .notDetermined:
                  AVCaptureDevice.requestAccess(for: .video) { success in
                      if success {
                          print("Permission granted, proceed")
                      } else {
                          print("Permission denied")
                      }
                  }
              }
              
              return true
          }
          
          func recordTheFood() {
            
              if checkCameraAccess() == true {
                  captureSession = AVCaptureSession()
                  captureSession.sessionPreset = .medium
              
//                  guard let backCamera = AVCaptureDevice.devices().filter({ $0.position == .back })
//                      .first else {
//                          fatalError("No front facing camera found")
//                      }
                
                guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) else{ fatalError("No camera")}
              
                  do {
                      let input = try AVCaptureDeviceInput(device: backCamera)
                      stillImageOutput = AVCapturePhotoOutput()
                  
                      if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                          captureSession.addInput(input)
                          captureSession.addOutput(stillImageOutput)
                        setupLivePreview()
                      }
                  }
                  catch let error  {
                      print("Error Unable to initialize back camera:  \(error.localizedDescription)")
                  }
              
                  DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
                      self.captureSession.startRunning()
                  }
              
                  DispatchQueue.main.async {
                      self.videoPreviewLayer.frame = self.previewView.bounds
                  }
              }
          }
          
          // MARK: User interaction handlers
          func textFieldShouldReturn(_ textField: UITextField) -> Bool {
              textField.resignFirstResponder()
              return true
          }
          
        //MARK: set up contstraints to lay them out
        func setUpSubview(){
            let layoutUnit = (self.view.frame.height - (self.navigationController?.navigationBar.frame.height ?? 0))/8
            let margins = view.layoutMarginsGuide
            
            view.addSubview(textInput)
            textInput.delegate = self
            textInput.translatesAutoresizingMaskIntoConstraints = false
            textInput.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            textInput.cornerRadius = 5
            NSLayoutConstraint.activate([
                textInput.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 50),
                textInput.heightAnchor.constraint(equalToConstant: 0.65*layoutUnit),
                textInput.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.85),
                textInput.centerXAnchor.constraint(equalTo: margins.centerXAnchor)
            ])

            view.addSubview(foodImage)
            foodImage.translatesAutoresizingMaskIntoConstraints = false
            foodImage.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            foodImage.layer.borderWidth = 6.0
            foodImage.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            
            NSLayoutConstraint.activate([
                foodImage.topAnchor.constraint(equalTo: textInput.bottomAnchor, constant: 10),
                foodImage.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                foodImage.heightAnchor.constraint(equalToConstant: 3*layoutUnit),
                foodImage.widthAnchor.constraint(equalTo: foodImage.heightAnchor)
            ])
            foodImage.cornerRadius = 1.5*layoutUnit
            
            view.addSubview(previewView)
            previewView.isHidden = true
                previewView.translatesAutoresizingMaskIntoConstraints = false
                previewView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                previewView.layer.borderWidth = 6.0
                previewView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                
            NSLayoutConstraint.activate([
                previewView.topAnchor.constraint(equalTo: textInput.bottomAnchor, constant: 6),
                previewView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                previewView.heightAnchor.constraint(equalToConstant: 3*layoutUnit),
                previewView.widthAnchor.constraint(equalTo: foodImage.heightAnchor)
            ])
            previewView.cornerRadius = 1.5*layoutUnit
            
            view.addSubview(addButton)
            addButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                addButton.topAnchor.constraint(equalTo: textInput.bottomAnchor, constant: 10),
                addButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
               addButton.heightAnchor.constraint(equalToConstant: 3*layoutUnit),
                addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor)
            ])
            addButton.cornerRadius = 1.5*layoutUnit
            
            view.addSubview(recordChallengeButton)
            recordChallengeButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate( [
                recordChallengeButton.topAnchor.constraint(greaterThanOrEqualTo: addButton.bottomAnchor, constant: 10),
                recordChallengeButton.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.9),
                recordChallengeButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                recordChallengeButton.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 1/6 ),
                recordChallengeButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -40)
            ])
        }

        // MARK: Boilerplate
        // Helper function inserted by Swift 4.2 migrator.
        fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
            return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
        }
        
        // Helper function inserted by Swift 4.2 migrator.
        fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
            return input.rawValue
        }
        
        @objc func pictureInput(){
            addButton.alpha = 0.2
            if previewView.isHidden
            {
                 previewView.isHidden = false
                  recordTheFood()
            }
            else{
                previewView.isHidden = true
                
                haptic.notificationOccurred(.success)
                if AVCaptureDevice.authorizationStatus(for: .video) != .denied {
                    let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
                    stillImageOutput.capturePhoto(with: settings, delegate: self)
                }
            }
          
        }
    
        func passData(dvc1: confettiViewController){
            dvc1.imagePlaceholder = image ?? UIImage(named: placeholderImages.randomElement()!)!
            dvc1.foodName.text = textInput.text ?? ""
            let happyUtterance = happySays()
            dvc1.message = happyUtterance.identifyContext(foodName: textInput.text ?? "", tryNumber: nil, logonNumber: nil, screen: screen.challengeScreen )
        }
    
        /// MARK: Setup
        func loadItems(){
            let request : NSFetchRequest<Challenge> = Challenge.fetchRequest()
            do{
                try ChallengeFoodsArray = context.fetch(request).reversed()
            }
            catch{
                print("Error fetching data \(error)")
            }
        }

        @objc func recordChallenge() -> Void {
            haptic.notificationOccurred(.success)
            if captureSession != nil
            {
                previewView.isHidden = true
                if AVCaptureDevice.authorizationStatus(for: .video) != .denied
                {
                    let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
                
                    stillImageOutput.capturePhoto(with: settings, delegate: self)
                    //foodImage.cornerRadius = 50
                    ///previewView.cornerRadius = 50
                }
                
                
                appsAndBiscuits(imageName: textInput.text ?? "", image: image ?? UIImage(named: placeholderImages.randomElement()!)!, rating: nil, notes: currentChallenge)
            }
            else{
                if image == nil && (textInput.text == nil || textInput.text == ""){
                         let alert = UIAlertController(title: "I need a little more", message: "Please input a food name or a photo to log what you did", preferredStyle: .alert)
                              alert.addAction(UIAlertAction(title: "I can do this!", style: .cancel, handler: nil))
                               self.present(alert, animated: true)
                     }
                else{
                    appsAndBiscuits(imageName: textInput.text ?? "", image: image ?? UIImage(named: placeholderImages.randomElement()!)!, rating: nil, notes: currentChallenge)
                }
            }
            
//            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
//            nextViewController = storyboard.instantiateViewController(withIdentifier: "postChallengeScreen" ) as! confettiViewController
//            passData(dvc1: nextViewController)
//            myNav = self.navigationController as? customNavigationController
//            myNav?.pushViewController(nextViewController, animated: true)
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
        
        func appsAndBiscuits(imageName: String?, image: UIImage, rating: Double?, notes: String?){
          //  weak var main = (navigationController?.viewControllers[0] as! newMainViewController)

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
            
            
                /// this bit updates the database
                if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                    let menuItem = NSEntityDescription.insertNewObject(forEntityName: "Challenge", into: managedObjectContext) as! Challenge
                    //menuItem.filename = imagePath
                    menuItem.filename = placeHolderImage
                    menuItem.name = imageName
                    menuItem.rating = rating ?? 0
                    menuItem.date = Date()
                    menuItem.type = entryType.challenge.rawValue
                    saveItems()
                    /// now update the local display - so the user can immediately see the difference without me needing to dip into the database and reload the whole view
                    ///main?.foodArray.append(menuItem)
                    if ChallengeFoodsArray == nil{
                        ChallengeFoodsArray = [menuItem]
                    }
                    else{
                        ChallengeFoodsArray.append(menuItem)
                    }
                    
//                    DispatchQueue.main.async{
//                        main?.myCollectionView.reloadData()
//                    }
                }
                
           
            
            //navigationController?.popToRootViewController(animated: true)
            let happyUtterance = happySays()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyboard.instantiateViewController(withIdentifier: "confettiViewController" ) as! confettiViewController
            nextViewController.message = happyUtterance.identifyContext(foodName: imageName, tryNumber: nil, logonNumber: nil, screen: screen.challengeScreen)
            let myNav = self.navigationController
            myNav?.pushViewController(nextViewController, animated: true)
        }
    
    func setUpNavigationBarItems(){
          let shareButton = UIButton(type: .system)
        if #available(iOS 13.0, *) {
            shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        } else {
           shareButton.setImage(UIImage(named: "share.png")?.resize(to: CGSize(width: 50,height: 100)), for: .normal)
        }
          shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
          navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
      }
    
     @objc func share() {
         
        var message = String()
         
        message = (challengeDictionary[thisWeeksChallenge()] ?? "") + (textInput.text ?? "") + "#happyFoods"
        let image = foodImage.image ?? #imageLiteral(resourceName: "little dude1.png")

        let activityViewController =
        UIActivityViewController(activityItems: [message, image],
                                      applicationActivities: nil)
         
        present(activityViewController, animated: true)
     }
    }

