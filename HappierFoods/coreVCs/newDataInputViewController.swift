//
//  newDataInputViewController.swift
//
//
//  Created by Kate Roberts on 13/11/2019.
//
import UIKit
import CoreData
import AVFoundation

class newDataInputViewController: UIViewController,UIImagePickerControllerDelegate, AVCapturePhotoCaptureDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    /// initialise all the elements programatically
    lazy var triesCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        collection.registerClass(dataInputCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader , withReuseIdentifier: "someRandomIdentifierString"))
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
    
    lazy var eatNowButton: myButton = {
        let button = myButton()
        button.setTitle("Eat Now", for: .normal)
        button.addTarget(self, action: #selector(eatNowSegue), for: .touchUpInside)
        return button
    }()

    lazy var eatLaterButton: myButton = {
        let button = myButton()
        button.setTitle("Eat Later", for: .normal)
        button.addTarget(self, action: #selector(eatLaterSegue), for: .touchUpInside)
        return button
      }()
    
    lazy var previewView: UIImageView = {
        let imageView = UIImageView()
        /// stretch
        return imageView
    }()
    
    lazy var tryCollectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 18 )
        label.backgroundColor = UIColor.white
        label.text = "Retry?"
        label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        label.alpha = 0.6
        return label
        
    }()
    lazy var targetCollectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 18 )
        label.backgroundColor = UIColor.white
        label.text = "Target?"
        label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        label.alpha = 0.6
        return label
        
    }()
    
    lazy var foodImage: UIImageView = {
        let imageView = UIImageView()
        
        /// stretch
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
    
    var nextViewController = rateFoodViewController()
    
    // MARK: Core Data variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var food: [NSManagedObject] = []
    var foodArray: [Tried]!
    var historyArray: [History]!
    var targetArray: [Target]!
    var logons: [Logons]!

    
    var selectedIndexPath : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        view.backgroundColor = UIColor(red: 224/255, green: 250/255, blue: 233/255, alpha: 1)
        setUpSubview()
        
  
        nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rateFoodVC" ) as! rateFoodViewController
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
            image = UIImage(data: imageData) ?? UIImage(named: "chaos.jpg")!
            foodImage.image = image
            foodImage.layer.masksToBounds = true
         /// performSegue(withIdentifier: presentState ?? "Undefined", sender: "dataInputViewController")
            passData(dvc1: nextViewController)
            nextViewController.formatImage()
           // nextViewController.foodImage.image = image
        
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
          
//              guard let backCamera = AVCaptureDevice.devices().filter({ $0.position == .back })
//                  .first else {
//                      fatalError("No front facing camera found")
//                  }
            
            guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back)
                else{ fatalError("no camera")}
          
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
            
            nextViewController.presentState = .AddFoodViewController
          }
      }
      
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
          // Local variable inserted by Swift 4.2 migrator.
          let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
          
          if let userPickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
              foodImage.image = userPickedImage
            image = userPickedImage.scaleImage(toSize: CGSize(width: 150, height: 150)) ?? UIImage(named: "chaos.jpg")!
          }
          imagePicker.dismiss(animated: true, completion: nil)
      }
      
      // MARK: User interaction handlers
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
      //  textField.endEditing(true)
          return true
      }
      
    
    //MARK: set up contstraints to lay them out
    func setUpSubview(){
        let layoutUnit = (self.view.frame.height - (self.navigationController?.navigationBar.frame.height ?? 0))/8 
        let margins = view.layoutMarginsGuide
        //let fullScreen = view.
        
            triesCollectionView.register(mainCollectionViewCell.self, forCellWithReuseIdentifier: "tryCell")
            triesCollectionView.delegate = self
            triesCollectionView.dataSource = self
            triesCollectionView.allowsSelection = true
        
        
        view.addSubview(triesCollectionView)
            triesCollectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                triesCollectionView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
                triesCollectionView.heightAnchor.constraint(equalToConstant: 0.7*layoutUnit),
                triesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                triesCollectionView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor)
            ])
        
            targetsCollectionView.register(mainCollectionViewCell.self, forCellWithReuseIdentifier: "tryCell")
            targetsCollectionView.delegate = self
            targetsCollectionView.dataSource = self
            targetsCollectionView.allowsSelection = true
        
        view.addSubview(targetsCollectionView)
            targetsCollectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                targetsCollectionView.topAnchor.constraint(equalTo: triesCollectionView.bottomAnchor, constant: 10),
                targetsCollectionView.heightAnchor.constraint(equalToConstant: 0.7*layoutUnit),
                targetsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                targetsCollectionView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor)
            ])
        
        view.addSubview(textInput)
            textInput.delegate = self
            textInput.translatesAutoresizingMaskIntoConstraints = false
            textInput.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            textInput.cornerRadius = 5
            NSLayoutConstraint.activate([
                textInput.topAnchor.constraint(equalTo: targetsCollectionView.bottomAnchor, constant: 10),
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
           // foodImage.image = UIImage(named: "cracker.jpeg")
            previewView.layer.borderWidth = 6.0
            previewView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            
            NSLayoutConstraint.activate([
                previewView.topAnchor.constraint(equalTo: textInput.bottomAnchor, constant: 6),
                previewView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                previewView.heightAnchor.constraint(equalToConstant: 3*layoutUnit + 2),
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
        

        buttonStackView.addArrangedSubview(eatNowButton)
        buttonStackView.addArrangedSubview(eatLaterButton)
        
        view.addSubview(buttonStackView)
            buttonStackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                buttonStackView.bottomAnchor.constraint(greaterThanOrEqualTo: margins.bottomAnchor, constant: -10),
                buttonStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: layoutUnit),
                buttonStackView.widthAnchor.constraint(equalTo: margins.widthAnchor),
                buttonStackView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                buttonStackView.topAnchor.constraint(lessThanOrEqualTo: foodImage.bottomAnchor, constant: 10)
            ])
        
        if foodArray != nil
        {
            if foodArray.count > 0
            {
            view.addSubview( tryCollectionLabel )
            tryCollectionLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                       tryCollectionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0.3*layoutUnit),
                       tryCollectionLabel.centerYAnchor.constraint(equalTo: triesCollectionView.centerYAnchor),
                       tryCollectionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            }
        }
        
        if targetArray != nil
              {
                if targetArray.count > 0
                {
                  view.addSubview( targetCollectionLabel )
                  targetCollectionLabel.translatesAutoresizingMaskIntoConstraints = false
                  NSLayoutConstraint.activate([
                             targetCollectionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0.3*layoutUnit),
                             targetCollectionLabel.centerYAnchor.constraint(equalTo: targetsCollectionView.centerYAnchor),
                             targetCollectionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                  ])
                }
              }
    }
    
    
    /// fill in the data for the two collection view sources
    
    /// make a click on the collection view send a message to populate the main screen
    
    /// define the segue out of the screen
}

extension newDataInputViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.triesCollectionView {
                return min((foodArray?.count ?? 0) + (historyArray?.count ?? 0), 20)
        }
        
        if collectionView == self.targetsCollectionView {
                       return targetArray?.count ?? 0
        }
        
        return 0
    }
    
//    func collectionView(collectionView: UICollectionView, viewFor HeaderInSection section: Int) -> UIView?{
//        return headeCell
//    }
//
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tryCell", for: indexPath) as! mainCollectionViewCell
        
        if collectionView == self.triesCollectionView
                   {
                    if indexPath.row < (foodArray?.count ?? 0){
                      let plate = foodArray[indexPath.row]
                      let fileToLoad = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(plate.filename ?? "1.png")
                      cell.displayContent(image: fileToLoad)
                    }
                    else{
                        let plate = historyArray[indexPath.row - (foodArray?.count ?? 0)]
                        let fileToLoad = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(plate.filename ?? "1.png")
                        cell.displayContent(image: fileToLoad)
                    }
                    
                    let editButton = UIButton(frame: CGRect(x:0, y:20, width:40,height:40))
                    editButton.tag = indexPath.row
                    editButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
                    cell.addSubview(editButton)
                    // cell.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
                   }
             
             if collectionView == self.targetsCollectionView
                          {
                             let plate = targetArray[indexPath.row]
                                                  let fileToLoad = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(plate.filename ?? "1.png")
                                                  cell.displayContent(image: fileToLoad)
                            
                            let editButton = UIButton(frame: CGRect(x:0, y:20, width:40,height:40))
                            //editButton.setImage(UIImage(named: "editButton.png"), for: UIControlState.normal)
                            editButton.tag = indexPath.row
                            editButton.addTarget(self, action: #selector(targetTryButtonTapped), for: .touchUpInside)
                            cell.addSubview(editButton)
                          }
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: collectionView.bounds.size.height - 8 , height: collectionView.bounds.height - 8 )
    }
    
    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 0)
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        var cellsToReload = [indexPath]
        
        if let selected = selectedIndexPath {
              cellsToReload.append(selected)
        }
        
        selectedIndexPath = indexPath
        collectionView.reloadItems(at: cellsToReload)
    }
    
 func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "dataInputCollectionReusableView", for: indexPath)
            // Customize headerView here
            return headerView
        }
        fatalError()
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        addToList.append(objectsArray[indexPath.row])
////        let cell = collectionView.cellForItem(at: indexPath)
////        cell?.layer.borderWidth = 2.0
////        cell?.layer.borderColor = UIColor.gray.cgColor
//
//        if collectionView == self.triesCollectionView
//                         {
//        }
//
//        if collectionView == self.targetsCollectionView
//        {
//
//        }
//    }
//
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
            if AVCaptureDevice.authorizationStatus(for: .video) != .denied
            {
                let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
                stillImageOutput.capturePhoto(with: settings, delegate: self)
            }
        }
      
    }
    
    @objc func eatNowSegue(){
        haptic.notificationOccurred(.success)
        if captureSession != nil
        {
            if AVCaptureDevice.authorizationStatus(for: .video) != .denied
            {    let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            
                stillImageOutput.capturePhoto(with: settings, delegate: self)
            }
        }
        

        if image == nil && (textInput.text == nil || textInput.text == ""){
            let alert = UIAlertController(title: "Please tell me what you tried", message: "I need either a food name or a photo to proceed", preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                  self.present(alert, animated: true)
        }
        else
        {
            passData(dvc1: nextViewController)
        

            myNav = (self.navigationController as! customNavigationController)
          /// this will nedd more nuance if I pull foods off the ribbons
            if nextViewController.presentState != .Unknown {
                myNav?.presentState = nextViewController.presentState
            } else {
                myNav?.presentState = Costume.AddFoodViewController
            }
            myNav?.pushViewController(nextViewController, animated: true)
        }
    }
    
    @objc func eatLaterSegue(){
        haptic.notificationOccurred(.success)
        if captureSession != nil
        {
            if AVCaptureDevice.authorizationStatus(for: .video) != .denied
            {
                let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
                stillImageOutput.capturePhoto(with: settings, delegate: self)
            }
        }

       if image == nil && (textInput.text == nil || textInput.text == ""){
                let alert = UIAlertController(title: "Please tell me the target", message: "I need either a food name or a photo to proceed", preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                      self.present(alert, animated: true)
            }
        else
       {
            nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "targetSettingScreen" ) as! rateFoodViewController
        
            nextViewController.presentState = .SetTargetViewController
            myNav?.presentState = nextViewController.presentState
       
            passData(dvc1: nextViewController)
            myNav = self.navigationController as? customNavigationController
        
            /// this will nedd more nuance if i pull foods off the ribbons
            myNav?.presentState = .SetTargetViewController
            myNav?.pushViewController(nextViewController, animated: true)
        }
       }
    
    func passData(dvc1: rateFoodViewController){
        dvc1.imagePlaceholder = image ?? UIImage(named: placeholderImages.randomElement()!)!
        dvc1.foodName = textInput.text ?? ""
    }
    
            /// MARK: Setup
            func loadItems(){
                let request : NSFetchRequest<Tried> = Tried.fetchRequest()
                    do{
                        try foodArray = context.fetch(request).reversed()
                    }
                    catch{
                        print("Error fetching data \(error)")
                    }

                let request2 : NSFetchRequest<Target> = Target.fetchRequest()
                    do{
                        try targetArray = context.fetch(request2).reversed()
                    }
                    catch{
                        print("Error fetching data \(error)")
                    }

                let request3 : NSFetchRequest<Logons> = Logons.fetchRequest()
                      do{
                          try logons = context.fetch(request3)
                      }
                      catch{
                          print("Error fetching data \(error)")
                      }
                
                let request4 : NSFetchRequest<History> = History.fetchRequest()
                      do{
                            try historyArray = context.fetch(request4).reversed()
                      }
                      catch{
                            print("Error fetching data \(error)")
                      }
    }
    
    @objc func retryButtonTapped(sender: mainCollectionViewCell) -> Void {

        if sender.tag < (foodArray?.count ?? 0)
        {
        let plate = foodArray[sender.tag]
        let fileToLoad = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(plate.filename ?? "1.png")
        foodImage.image = UIImage(named: fileToLoad)
        foodImage.layer.masksToBounds = true
        image = UIImage(named: fileToLoad)
        textInput.text = foodArray![sender.tag].name ?? ""
        addButton.alpha = 0.2
        passData(dvc1: nextViewController)
        nextViewController.formatImage()
        }
        else{
            let plate = historyArray[sender.tag - (foodArray?.count ?? 0)]
            let fileToLoad = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(plate.filename ?? "1.png")
            foodImage.image = UIImage(named: fileToLoad)
            foodImage.layer.masksToBounds = true
            image = UIImage(named: fileToLoad)
            textInput.text = historyArray![sender.tag - (foodArray?.count ?? 0)].name ?? ""
            addButton.alpha = 0.2
            nextViewController.historyArray = historyArray
            passData(dvc1: nextViewController)
            nextViewController.formatImage()
            nextViewController.presentState = .RetryTriedFood
        }
    }
    
    @objc func targetTryButtonTapped(sender: mainCollectionViewCell) -> Void {
        print("Hello retarget Button")
        print(sender.tag)
        let plate = targetArray[sender.tag]
        let fileToLoad = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(plate.filename ?? "1.png")
        
        foodImage.image = UIImage(named: fileToLoad)
        image = UIImage(named: fileToLoad)
        foodImage.layer.masksToBounds = true
        textInput.text = targetArray![sender.tag].name ?? ""
        addButton.alpha = 0.2
        passData(dvc1: nextViewController)
        nextViewController.formatImage()
        nextViewController.presentState = .ConvertTargetToTry
        nextViewController.dateTargetSet = plate.date!
        /// now here I need to put a hold on this one, and if I save it, I need to delete the target
    }
}
