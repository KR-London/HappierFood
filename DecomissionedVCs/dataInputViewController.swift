//
//  dataInputViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 06/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//
 var usedCamera = false

import UIKit
import ARKit
import AVFoundation

enum dataInputMode: String{
    case camera
    case cameraRoll
    case write
    case unknown
}

class dataInputViewController: UIViewController, UIImagePickerControllerDelegate, AVCapturePhotoCaptureDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var image : UIImage?
    var foodName = String()
    var currentDataInputMode : dataInputMode = dataInputMode.camera
    var presentState : String?
    let haptic = UINotificationFeedbackGenerator()
    var sourceViewController = ""
    var placeholderImage: String?

    // MARK: Outlets & actions
    @IBOutlet weak var writtenInputElements: UIStackView!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var nameOfFood: UITextField!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var cameraRollButton: UIButton!
    @IBOutlet weak var writeButton: UIButton!
    
    let placeholderImages = ["1plate.jpeg", "2plate.jpeg", "3plate.jpeg", "4plate.jpeg", "5plate.jpeg"]
    
   

    @IBAction func nameOfFoodInput(_ sender: Any) {
        foodName = nameOfFood.text ?? ""
        
        if image == nil {
            ///image = UIImage(named: "databasePlaceholderImage.001.jpeg")!
            image = UIImage(named: foodName + ".jpeg") ?? UIImage(named:
               placeholderImages.randomElement()!)!
            
            if UIImage(named: foodName + ".jpeg") == nil
            {
                placeholderImage =  placeholderImages.randomElement()
            }
            else
            {
                placeholderImage = foodName + ".jpeg"
            }
        }
        
        if  image == UIImage(named: "NoCameraPlaceholder.001.jpeg"){
            image = UIImage(named: foodName + ".jpeg") ?? UIImage(named:  placeholderImages.randomElement()!)!
            
            if UIImage(named: foodName + ".jpeg") == nil
            {
                placeholderImage =  placeholderImages.randomElement()
            }
            else
            {
                placeholderImage = foodName + ".jpeg"
            }
        }
        
        performSegue(withIdentifier: presentState ?? "Undefined", sender: "dataInputViewController")
    }

    @IBOutlet weak var buttonOutlet: UIButton!
  //  @IBOutlet weak var publicInformationBroadcast: UILabel!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var captureImageView: UIImageView!
    @IBAction func didTakePhoto(_ sender: Any) {
        
        haptic.notificationOccurred(.success)
        if usedCamera == true {
            if AVCaptureDevice.authorizationStatus(for: .video) != .denied
            {   let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
                stillImageOutput.capturePhoto(with: settings, delegate: self)
            }
        }
        else {
            performSegue(withIdentifier: presentState ?? " Undefined " , sender: "dataInputViewController")
        }
//        DispatchQueue.main.async {
//            self.performSegue(withIdentifier: self.presentState ?? " Undefined " , sender: "dataInputViewController")
//        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
    }
    
    @IBAction func launchCameraRollButton(_ sender: Any) {
        writtenInputElements.isHidden = true
        currentDataInputMode = .cameraRoll
        refreshButtonAppearance()
        if usedCamera == true && AVCaptureDevice.authorizationStatus(for: .video) != .denied
        {
            self.captureSession.stopRunning()
        }
        usedCamera = false
       // publicInformationBroadcast.isHidden = true
       // publicInformationBroadcast.isHidden = false
        previewView.isHidden = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        captureImageView.isHidden = false
        present(imagePicker, animated: true, completion: nil)
      
    }
    
    @IBAction func launchCamera(_ sender: Any) {
        writtenInputElements.isHidden = true
        if usingSimulator == false
        {
            currentDataInputMode = .camera
            refreshButtonAppearance()
            usedCamera = true
            previewView.isHidden = false
            //  publicInformationBroadcast.isHidden = true
            usedCamera = true
            captureImageView.isHidden = false
            recordTheFood()
        }
        else{
            if image == nil
            {
                image = UIImage(named: "NoCameraPlaceholder.001.jpeg")!
                placeholderImage = "NoCameraPlaceholder.001.jpeg"
            }
            captureImageView.isHidden = false
            captureImageView.image = UIImage(named: "NoCameraPlaceholder.001.jpeg")
        }
    }
    
    @IBAction func writeTheFood(_ sender: Any) {
        currentDataInputMode = .write
        refreshButtonAppearance()
        self.captureSession?.stopRunning()
       // publicInformationBroadcast.isHidden = false
        previewView.isHidden = true
        captureImageView.isHidden = true
//        if image == nil {
//            ///image = UIImage(named: "databasePlaceholderImage.001.jpeg")!
//            image = UIImage(named: foodName + ".jpeg") ?? UIImage(named: "databasePlaceholderImage.001.jpeg")!
//
//            if UIImage(named: foodName + ".jpeg") == nil
//            {
//                placeholderImage = "databasePlaceholderImage.001.jpeg"
//            }
//            else
//            {
//                placeholderImage = foodName + ".jpeg"
//            }
//        }
//
//        if  image == UIImage(named: "NoCameraPlaceholder.001.jpeg"){
//            image = UIImage(named: foodName + ".jpeg") ?? UIImage(named: "databasePlaceholderImage.001.jpeg")!
//
//            if UIImage(named: foodName + ".jpeg") == nil
//            {
//                placeholderImage = "databasePlaceholderImage.001.jpeg"
//            }
//            else
//            {
//                placeholderImage = foodName + ".jpeg"
//            }
//        }
        captureImageView.isHidden = true
        writtenInputElements.isHidden = false
    }

    // MARK: AV init helpers
    let imagePicker = UIImagePickerController()
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!

    // MARK: Page lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBarItems()
        formatTextInput()
       
        
        if TARGET_IPHONE_SIMULATOR != 1 {
            usedCamera = true
        }

        imagePicker.allowsEditing = true
        writtenInputElements.isHidden = true
        pictureViewConstraints()
        nameOfFood.delegate = self
        refreshButtonAppearance()
}

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if usedCamera == true {
            recordTheFood()
        }
        haptic.prepare()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if usedCamera == true {
            self.captureSession?.stopRunning()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier != "back" {
            if let dvc1 = segue.destination as? rateFoodViewController {
                print(foodName + ".jpeg")
                dvc1.imagePlaceholder = image ?? UIImage(named: placeholderImages.randomElement()!)!
                dvc1.foodName = foodName
                dvc1.placeHolderImage = placeholderImage
            }
        }
    }
    
    // MARK: Functions to manage the image input
    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(videoPreviewLayer)
    }
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        image = UIImage(data: imageData) ?? UIImage(named: "chaos.jpg")!
        captureImageView.image = image
        performSegue(withIdentifier: presentState ?? "Undefined", sender: "dataInputViewController")
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
            presentCameraSettings()
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
        
            guard let backCamera = AVCaptureDevice.devices().filter({ $0.position == .back })
                .first else {
                    fatalError("No front facing camera found")
                }
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        previewView.isHidden = true
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let userPickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
            captureImageView.image = userPickedImage
            image = userPickedImage.scaleImage(toSize: CGSize(width: 150, height: 150))
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: User interaction handlers
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func share() {
        
        var message = String()
        
        switch presentState  {
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
    
    // MARK: Layout and appearance subroutines
    
    func refreshButtonAppearance(){
        switch currentDataInputMode
        {
        case .camera:
            cameraButton.alpha = 0.5
            cameraRollButton.alpha = 1
            writeButton.alpha = 1
        case .cameraRoll:
            cameraButton.alpha = 1
            cameraRollButton.alpha = 0.5
            writeButton.alpha = 1
        case .write:
            cameraButton.alpha = 1
            cameraRollButton.alpha = 1
            writeButton.alpha = 0.5
        default:
            cameraButton.alpha = 1
            cameraRollButton.alpha = 1
            writeButton.alpha = 1
        }
    }
    
    func pictureViewConstraints(){
        
        previewView.translatesAutoresizingMaskIntoConstraints = false
        writtenInputElements.translatesAutoresizingMaskIntoConstraints = false
        captureImageView.translatesAutoresizingMaskIntoConstraints = false
        
        previewView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        previewView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        previewView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        previewView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40).isActive = true
        
        writtenInputElements.widthAnchor.constraint(equalToConstant: 300).isActive = true
        writtenInputElements.heightAnchor.constraint(equalToConstant: 200).isActive = true
        writtenInputElements.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        writtenInputElements.bottomAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        nameOfFood.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 ) 
        //writtenInputElements.font = UIFont(name: "Courier", size: 24)
        //writtenInputElements.heightAnchor.constraint(equalToConstant: 200)
        
        captureImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        captureImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        captureImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        captureImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40).isActive = true

        previewView.layer.cornerRadius = 5
        previewView.layer.masksToBounds = true
        writtenInputElements.layer.cornerRadius = 5
        writtenInputElements.layer.masksToBounds = true
        //captureImageView.backgroundColor = UIColor.gray
        captureImageView.layer.cornerRadius = 5
        captureImageView.layer.masksToBounds = true
        captureImageView.contentMode = .scaleAspectFill

        previewView.bottomAnchor.constraint(lessThanOrEqualTo: buttonOutlet.topAnchor, constant: -20).isActive = true

        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        let buttonStackHeightAnchorConstraint = buttonStack.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2)
        buttonStackHeightAnchorConstraint.isActive = true
 
        buttonStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        buttonStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        buttonStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        buttonStack.topAnchor.constraint(greaterThanOrEqualTo: buttonOutlet.bottomAnchor, constant: 10).isActive = true
        buttonStack.layer.masksToBounds = true

        buttonOutlet.translatesAutoresizingMaskIntoConstraints = false
        buttonOutlet.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        buttonOutlet.widthAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        buttonOutlet.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        buttonOutlet.layer.masksToBounds = true
    }
    
    func setUpNavigationBarItems(){

        /// MARK: Set up nav bar items
        
        let navBarHeight = navigationController?.navigationBar.frame.height
        let shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(named: "share.png")?.resize(to: CGSize(width: 0.5*(navBarHeight ?? 100),height: navBarHeight ?? 100 )), for: .normal)
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
        
        weak var main = navigationController?.viewControllers[0] as? mainViewController
        presentState = main?.myNav?.currentStateAsString() ?? "First Pass"
        
        switch sourceViewController{
            case "Try Food":
                        navigationItem.title = "What did you try?"
                        main?.myNav?.presentState = .AddFoodViewController
                        presentState = "AddFoodViewController"
            
            case "Set Target":
                        navigationItem.title = "Set a target"
                        main?.myNav?.presentState = .SetTargetViewController
                        presentState = "SetTargetViewController"
            
            default:
                        main?.myNav?.presentState = .Unknown
                        presentState = "Unknown"
            
        }

    }
    
    func formatTextInput(){
        nameOfFood.backgroundColor = UIColor(red: 251/255, green: 254/255, blue: 252/255, alpha: 1)
        nameOfFood.textColor = UIColor(red: 3/255, green: 18/255, blue: 8/255, alpha: 1)
        nameOfFood.borderStyle = .roundedRect
        nameOfFood.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        nameOfFood.layer.borderWidth = 1.0
        
        
      //  nameOfFood.borderRect(forBounds: <#T##CGRect#>)
            //= UIFont(descriptor: <#T##UIFontDescriptor#>, size: <#T##CGFloat#>)
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
    

}

