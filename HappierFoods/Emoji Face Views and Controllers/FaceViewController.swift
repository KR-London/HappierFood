//
//  FaceViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 04/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import Vision
import AVFoundation
import Vision

@IBDesignable
class FaceViewController: UIViewController{

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var faceView: FaceView!
    @IBOutlet weak var slider: UISlider!
    @IBAction func sliderSliding(_ sender: Any) {
        updateUI(value: -1 + 2*slider!.value)
    }
    
     @IBOutlet weak var errmLabel: UILabel!
    @IBAction func reloadButton(_ sender: UIButton) {
       // faceView.isAnimate = false
      //  setUpCaptureSession()
       // faceView.isAnimate = true
        faceView.setNeedsDisplay()
    }
    
    
    /// face detection
 //   var sequenceHandler = VNSequenceRequestHandler()
    
  //  let session = AVCaptureSession()
  //  var previewLayer: AVCaptureVideoPreviewLayer!
    
//    let dataOutputQueue = DispatchQueue(
//        label: "video data queue",
//        qos: .userInitiated,
//        attributes: [],
//        autoreleaseFrequency: .workItem)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(value: 0.5)
         self.faceView.setNeedsDisplay()
      //  configureCaptureSession()
       // session.startRunning()
      // / self

        // Do any additional setup after loading the view.
    }
    
    private func updateUI(value: Float){
        
        /// do i need a bit of safety code here - if I get a crazy input? Or is this handled as standard.
        faceView.mouthCurvature = Double(value)
    }
}

//extension FaceViewController: AVCaptureVideoDataOutputSampleBufferDelegate{
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureSession){
//
//        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return }
//
//        let detectFaceRequest = VNDetectFaceLandmarksRequest(completionHandler: detectedFace)
//
//        do{
//            try sequenceHandler.perform([detectFaceRequest], on: imageBuffer)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    func convert(rect: CGRect) -> CGRect{
//        let origin = previewLayer.layerPointConverted(fromCaptureDevicePoint: rect.origin)
//        let size = previewLayer.layerPointConverted(fromCaptureDevicePoint: rect.size.cgPoint )
//        return CGRect(origin: origin, size: size.cgSize )
//        //CGPoint(x: 200, y: 200)
//        //CGSize(width: 200, height: 200)
//    }
//
//    func landmark(point: CGPoint, to rect: CGRect) -> CGPoint {
//        let absolute = point.absolutePoint(in: rect)
//
//        let converted = previewLayer.layerPointConverted(fromCaptureDevicePoint: absolute)
//
//        return converted
//    }
//
//    func landmark(points: [CGPoint]?, to rect: CGRect) -> [CGPoint]? {
//        return points?.compactMap { landmark(point: $0, to: rect) }
//    }
//
//    func detectedFace(request: VNRequest, error: Error?){
//        guard let results = request.results as? [VNFaceObservation],
//        let result = results.first
//            else{
//                print( "I've been told to clear FaceView")
//                return
//        }
//
////        let box = result.boundingBox
////        faceView.boundingBox = convert(rect: box)
////
////        DispatchQueue.main.async {
////            self.faceView.setNeedsDisplay()
////        }
//        updateFaceView(for: result)
//        guard let landmarks = result.landmarks else {
//            return
//        }
//
//        if let leftEye = landmark(
//            points: landmarks.leftEye?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.leftEye = leftEye
//        }
//
//    }
//
//    func updateFaceView(for result: VNFaceObservation) {
//        defer {
//            DispatchQueue.main.async {
//                self.faceView.setNeedsDisplay()
//            }
//        }
//
//        let box = result.boundingBox
//        faceView.boundingBox = convert(rect: box)
//
//        guard let landmarks = result.landmarks else {
//            return
//        }
//
//        if let leftEye = landmark(
//            points: landmarks.leftEye?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.leftEye = leftEye
//        }
//
//        if let rightEye = landmark(
//            points: landmarks.rightEye?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.rightEye = rightEye
//        }
//
//        if let leftEyebrow = landmark(
//            points: landmarks.leftEyebrow?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.leftEyebrow = leftEyebrow
//        }
//
//        if let rightEyebrow = landmark(
//            points: landmarks.rightEyebrow?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.rightEyebrow = rightEyebrow
//        }
//
//        if let nose = landmark(
//            points: landmarks.nose?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.nose = nose
//        }
//
//        if let outerLips = landmark(
//            points: landmarks.outerLips?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.outerLips = outerLips
//        }
//
//        if let innerLips = landmark(
//            points: landmarks.innerLips?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.innerLips = innerLips
//        }
//
//        if let faceContour = landmark(
//            points: landmarks.faceContour?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.faceContour = faceContour
//        }
//    }
//}
//
//extension FaceViewController {
//    func configureCaptureSession() {
//        // Define the capture device we want to use
//        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera,
//                                                   for: .video,
//                                                   position: .front) else {
//                                                    fatalError("No front video camera available")
//        }
//
//        // Connect the camera to the capture session input
//        do {
//            let cameraInput = try AVCaptureDeviceInput(device: camera)
//            session.addInput(cameraInput)
//        } catch {
//            fatalError(error.localizedDescription)
//        }
//
//        // Create the video data output
//        let videoOutput = AVCaptureVideoDataOutput()
//        videoOutput.setSampleBufferDelegate(self, queue: dataOutputQueue)
//        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
//
//        // Add the video output to the capture session
//        session.addOutput(videoOutput)
//
//        let videoConnection = videoOutput.connection(with: .video)
//        videoConnection?.videoOrientation = .portrait
//
//        // Configure the preview layer
//        previewLayer = AVCaptureVideoPreviewLayer(session: session)
//        previewLayer.videoGravity = .resizeAspectFill
//        previewLayer.frame = view.bounds
//        view.layer.insertSublayer(previewLayer, at: 0)
//
//        var faceLayer: CALayer{
//            return faceView.layer
//        }
//        view.layer.insertSublayer(faceLayer, at: 1)
//    }
//
//    func setUpCaptureSession(){
//
//        let  captureSession = AVCaptureSession()
//        // search for available capture devices
//
//        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video , position: .front).devices
//
//        /// set up capture device and add input to capture session
//        do{
//            if let captureDevice = availableDevices.first{
//                let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
//                captureSession.addInput(captureDeviceInput)
//            }
//        }
//        catch{
//            print(error.localizedDescription)
//        }
//
//        //setup output and add output to our capture session
//        let captureOutput = AVCaptureVideoDataOutput()
//        captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
//        captureSession.addOutput(captureOutput)
//
//        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//                previewLayer.frame = view.frame
//                previewLayer.isOpaque = true
//
//                //view.layer.addSublayer(previewLayer)
//               // self.view.bringSubviewToFront(faceView)
//      //  self.view.sendSubviewToBack(previewLayer as! UIView)
//        //view.layer.addSublayer(previewLayer)
//        captureSession.startRunning()
//    }
//
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//
//        //guard let model = try? VNCoreMLModel(for: CNNEmotions().model) else { return }
////        let request = VNCoreMLRequest(model: model){( finishedRequest, error) in
////            guard let results = finishedRequest.results as? [VNClassificationObservation] else {return }
////            guard let Observation = results.first else {return }
////            //            self.faceView.mouthCurvature = 0
////
////            DispatchQueue.main.async (execute: {
////                self.label.text = "\(Observation.identifier)"
////                print("\(Observation.identifier)")
////
////                let happyConfidence = results.filter{$0.identifier == "Happy"}.compactMap{$0.confidence}
////                print("happyConfidence is \(happyConfidence)")
////
////                let angryConfidence = results.filter{$0.identifier == "Angry"}.compactMap{$0.confidence}
////                print("angryConfidence is \(angryConfidence)")
////
////                let sadConfidence = results.filter{$0.identifier == "Sad"}.compactMap{$0.confidence}
////                print("sadConfidence is \(sadConfidence)")
//////                switch Observation.identifier{
//////                case "Happy": self.faceView.mouthCurvature = 1
//////                case "Neutral": self.faceView.mouthCurvature = 0
//////                case "Angry": self.faceView.mouthCurvature = -0.6
//////                case "Sad": self.faceView.mouthCurvature = -1
//////                case "Fear": self.faceView.mouthCurvature = -0.4
//////                case "Surprise": self.faceView.mouthCurvature = 0.1
//////                case "Disgust": self.faceView.mouthCurvature = -0.8
//////                default: self.faceView.mouthCurvature = 0.2
//////                }
////             //   self.faceView.mouthCurvature =
////                    self.faceView.mouthCurvature = min( 1 ,  3*Double(happyConfidence[0]) + Double(angryConfidence[0]))
////                        - Double(sadConfidence[0])
//////
////            guard let model = try? VNCoreMLModel(for: ImageClassifier().model) else { return }
////            let request = VNCoreMLRequest(model: model){( finishedRequest, error) in
////                        guard let results = finishedRequest.results as? [VNClassificationObservation] else {return }
//
//   //        guard let Observation = results.first else {return }
////              self.faceView.mouthCurvature = 0
////
////              DispatchQueue.main.async (execute: {
////                                //                self.label.text = "\(Observation.identifier)"
////                                //                print("\(Observation.identifier)")
////
////                switch Observation.identifier{
////                    case "PositiveEmotion":
////                        self.faceView.mouthCurvature = 1
////                        print("Happy with probability \(Observation.confidence)")
////                    case "NegativeEmotion":
////                        self.faceView.mouthCurvature = -1
////                        print("Unappy with probability \(Observation.confidence)")
////                    default:
////                        self.faceView.mouthCurvature = 0.2
////                 }
////                print("mouth curvature is \(self.faceView.mouthCurvature)")
////                  //   self.faceView.isAnimate = true
////
////                //self.faceView.reloadInputViews()
////              })
////
////        }
//
//     //   guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
//
//        // executes request
//      //  try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
//    }
//
//    func setupLabel() {
//        self.view.addSubview(label)
//        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
//
//    }
    
   // func emotionIdentified(){
      //    self.faceView.isAnimate = true
   // }
//}


