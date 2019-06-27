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
   
    var presentState : Costume = Costume.Unknown
    
    let haptic = UINotificationFeedbackGenerator()
  
   
    var sourceViewController = ""
    
    @IBOutlet weak var containerView: topView!
    
    /// mode selecting buttons
    @IBOutlet weak var writtenInputElements: UIStackView!
    
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var nameOfFood: UITextField!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var cameraRollButton: UIButton!
    @IBOutlet weak var writeButton: UIButton!
    
    @IBOutlet weak var bottomStack: UIStackView!
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
        previewView.isHidden = true
        captureImageView.isHidden = true
        if image == nil 
        {
            ///image = UIImage(named: "databasePlaceholderImage.001.jpeg")!
            image = UIImage(named: "databasePlaceholderImage.001.jpeg")!
        }
        
        if  image == UIImage(named: "NoCameraPlaceholder.001.jpeg")
        {
            image = UIImage(named: "databasePlaceholderImage.001.jpeg")!
        }
        captureImageView.isHidden = true
        writtenInputElements.isHidden = false
        
    }
    
    lazy var topBar : topView = {
        let content = topView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    
    let imagePicker = UIImagePickerController()
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBarItems()
        //usedCamera = true

        imagePicker.allowsEditing = true
        writtenInputElements.isHidden = true
        pictureViewConstraints()
        nameOfFood.delegate = self
        

        
        switch sourceViewController
        {
            case "Try Food":
              // topBar.titleLabel.text = "Log a Try"
                // buttonOutlet.setTitle("Add Food", for: .normal)
                navigationItem.title = "What did you try?"
                presentState = Costume.AddFoodViewController
            case "Set Target":
             //  topBar.titleLabel.text = "Set a Target"
                //buttonOutlet.setTitle("Add Target", for: .normal)
                 navigationItem.title = "Set a target"
                presentState = Costume.SetTargetViewController
            default:
             //  topBar.titleLabel.text = "HappyFoods"
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
                dvc1.imagePlaceholder = image ?? UIImage(named: "databasePlaceholderImage.001.jpeg")!
                dvc1.presentState = presentState
//                if foodName != nil
//                {
                    dvc1.foodName = foodName
                   // dvc1.foodName = "Cherry tomatoes"
               // }
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
      //  previewView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
       // previewView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40).isActive = true
      //  previewView.bottomAnchor.constraint(lessThanOrEqualTo: buttonOutlet.topAnchor, constant: -20).isActive = true
        previewView.layer.cornerRadius = 5
        previewView.layer.masksToBounds = true
//        
//        writtenInputElements.translatesAutoresizingMaskIntoConstraints = false
//        writtenInputElements.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        writtenInputElements.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        writtenInputElements.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        writtenInputElements.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40).isActive = true
//        writtenInputElements.bottomAnchor.constraint(lessThanOrEqualTo: buttonOutlet.topAnchor, constant: -20).isActive = true
//        writtenInputElements.layer.cornerRadius = 5
//        writtenInputElements.layer.masksToBounds = true
//
//        captureImageView.backgroundColor = UIColor.green
//        captureImageView.translatesAutoresizingMaskIntoConstraints = false
//        captureImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        captureImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        captureImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        captureImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40).isActive = true
//        captureImageView.layer.cornerRadius = 5
//        captureImageView.layer.masksToBounds = true
//        captureImageView.contentMode = .scaleAspectFill
//        captureImageView.bottomAnchor.constraint(lessThanOrEqualTo: buttonOutlet.topAnchor, constant: -20).isActive = true
//        
//        
//       // bottomStack.isHidden = true
//        buttonStack.translatesAutoresizingMaskIntoConstraints = false
//        buttonStack.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
//        buttonStack.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
//        buttonStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//        buttonStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        buttonStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        buttonStack.topAnchor.constraint(greaterThanOrEqualTo: buttonOutlet.bottomAnchor).isActive = true
//        buttonStack.topAnchor.constraint(greaterThanOrEqualTo: writtenInputElements.bottomAnchor).isActive = true
//        buttonStack.layer.masksToBounds = true
//        
//        buttonOutlet.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
//        buttonOutlet.translatesAutoresizingMaskIntoConstraints = false
//        buttonOutlet.widthAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
//        buttonOutlet.layer.masksToBounds = true
//        
        
        //var dimension = 360
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func share() {
        
        var message = String()
        
        switch presentState {
        case .AddFoodViewController:
            let name = nameOfFood.text
            if name != nil && name != ""
            {
                message = "I've just tried " + (name ?? "something") + ". In the release version of the app, I will also report whether I liked the food or not!"
            }
            else
            {
                message = "I've just tried a new food!"
            }
        case .SetTargetViewController:
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
    
    
    /**
//     * Called when the user click on the view (outside the UITextField).
//     */
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.view.endEditing(true)
//    }
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
