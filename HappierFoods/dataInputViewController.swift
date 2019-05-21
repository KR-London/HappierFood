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



class dataInputViewController: UIViewController, UIImagePickerControllerDelegate, AVCapturePhotoCaptureDelegate, UINavigationControllerDelegate {
    
    var image = UIImage()
    var foodName = String()
    
    var currentDataInputMode : dataInputMode = dataInputMode.camera
   
    var presentState : Costume = Costume.Unknown
    
    let haptic = UINotificationFeedbackGenerator()
  
   
    var sourceViewController = ""
    
    @IBOutlet weak var containerView: topView!
    
    /// mode selecting buttons
    @IBOutlet weak var writtenInputElements: UIStackView!
    
    @IBOutlet weak var nameOfFood: UITextField!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var cameraRollButton: UIButton!
    @IBOutlet weak var writeButton: UIButton!
    
    @IBAction func nameOfFoodInput(_ sender: Any) {
        foodName = nameOfFood.text ?? ""
        performSegue(withIdentifier: presentState.rawValue, sender: "dataInputViewController")
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
  //  @IBOutlet weak var publicInformationBroadcast: UILabel!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var captureImageView: UIImageView!
    @IBAction func didTakePhoto(_ sender: Any) {
        
        haptic.notificationOccurred(.success)
        if usedCamera == true
        {
            let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            stillImageOutput.capturePhoto(with: settings, delegate: self)
        }
        else
        {
             performSegue(withIdentifier: presentState.rawValue , sender: "dataInputViewController")
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        
    }
    
    @IBAction func launchCameraRollButton(_ sender: Any) {
        writtenInputElements.isHidden = true
        currentDataInputMode = .cameraRoll
        refreshButtonAppearance()
        if usedCamera == true
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
        if image == nil 
        {
            image = UIImage(named: "databasePlaceholderImage.001.jpeg")!
        }
        if  image == UIImage(named: "NoCameraPlaceholder.001.jpeg")
        {
            image = UIImage(named: "databasePlaceholderImage.001.jpeg")!
        }
        captureImageView.isHidden = true
        writtenInputElements.isHidden = false
        
    }
    let imagePicker = UIImagePickerController()
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        //usedCamera = true
        imagePicker.allowsEditing = true
        writtenInputElements.isHidden = true
        pictureViewConstraints()
       // containerView.titleLabel.text = "Input Food"
        
        switch sourceViewController
        {
            case "Try Food":
               // titleLabel.text = "You Tried A New Food"
                // buttonOutlet.setTitle("Add Food", for: .normal)
                presentState = Costume.AddFoodViewController
            case "Set Target":
               // titleLabel.text = "Let's set a target"
                //buttonOutlet.setTitle("Add Target", for: .normal)
                presentState = Costume.SetTargetViewController
            default:
               // titleLabel.text = "Did you try a new food"
             //   buttonOutlet.titleLabel?.text = "Click to proceed"
            presentState = Costume.Unknown
        }
        
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
   
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if usedCamera == true
        {
            recordTheFood()
        }
        haptic.prepare()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if usedCamera == true
        {
            self.captureSession.stopRunning()
        }
    }
    
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
        performSegue(withIdentifier: presentState.rawValue, sender: "dataInputViewController")
    }
    
    func recordTheFood() {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier != "back" {
            if let dvc1 = segue.destination as? rateFoodViewController
            {
                dvc1.imagePlaceholder = image
                dvc1.presentState = presentState
                if foodName != nil
                {
                    dvc1.foodName = foodName
                }
            }
      //  if let dvc2 = segue.destination as! topBarViewController
        
     }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        previewView.isHidden = true
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let userPickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage
        {
            captureImageView.image = userPickedImage
            image = userPickedImage
            
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
    
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
        previewView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        previewView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        previewView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        previewView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40).isActive = true
        previewView.layer.cornerRadius = 5
        previewView.layer.masksToBounds = true
        
        captureImageView.translatesAutoresizingMaskIntoConstraints = false
        captureImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        captureImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        captureImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        captureImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40).isActive = true
        captureImageView.layer.cornerRadius = 5
        captureImageView.layer.masksToBounds = true
        captureImageView.contentMode = .scaleAspectFill
        var dimension = 360
       // var dimension = 375.0
//        if previewView.frame.height < previewView.frame.width
//        {
//           dimension = dimension * ( Double(previewView.frame.height) / Double(previewView.frame.width) )
//        }
//        let maskView = UIView(frame: CGRect(x: 7, y: 165, width: dimension , height: dimension))
//        maskView.backgroundColor = .blue
//        maskView.layer.cornerRadius = 5
//        //view.addSubview(maskView)
//        maskView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        maskView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40).isActive = true
//        
      // previewView.mask = maskView
      // captureImageView.mask = maskView
    }
    
}

//extension UIButton{
//    override open var isHighlighted: Bool {
//        didSet {
//           // backgroundColor = isHighlighted ? UIColor.black : UIColor.white
//            alpha = isHighlighted ? 0.5 : 1
//        }
//    }
//
//
//
//}
