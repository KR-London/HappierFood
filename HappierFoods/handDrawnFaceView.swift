//
//  handDrawnFaceView.swift
//  customFace
//
//  Created by Kate Roberts on 11/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class handDrawnFaceView: UIView {
    
//    var scale: CGFloat = 0.90
//    var boundingBox = CGRect.zero
//    
//    @IBInspectable
//    var mouthCurvature: Double = 1.0 { didSet { setNeedsDisplay() } }
//    
//    private var skullRadius: CGFloat{
//        return min(bounds.size.width, bounds.size.height)/2
//    }
//    
//    private var skullCenter: CGPoint {
//        return CGPoint(x: bounds.midX, y: bounds.midY)
//    }
//    
// 
//    
//    private struct Ratios {
//        static let SkullRadiusToEyeOffset: CGFloat = 3
//        static let SkullRadiusToEyeRadius: CGFloat = 10
//        static let SkullRadiusToMouthWidth: CGFloat = 1
//        static let SkullRadiusToMouthHeight: CGFloat = 3
//        static let SkullRadiusToMouthOffset: CGFloat = 3
//    }
//    
//    override init(frame: CGRect){
//        super.init(frame: frame)
//    }

    lazy var backgroundView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    lazy var bottomFace: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "face.png")
        return contentView
    }()
    
    lazy var topFace: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "eyeOpen_browDownLeft.png")
        return contentView
    }()
    
//    lazy var smile: UIView = {
//
//        let contentView = UIView()
//
////        let path = UIBezierPath()
////        path.move(to: start)
////        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
////        path.lineWidth = 5.0
//
//            UIColor.green.set()
//            pathForMouth().stroke()
////
////        }
    
//       
//        return contentView
//    }()
//    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addSubview(topFace)
//        addSubview(smile)
//       // pathForMouth()
     //   backgroundView.addSubview(bottomFace)
    //    backgroundView.addSubview(topFace)
    //    addSubview(backgroundView)
        //backgroundView.isHidden = true
   //     sendSubviewToBack(backgroundView)
//        draw(backgroundView.frame)
//        backgroundView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate(
//            [
//                backgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//                backgroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//                backgroundView.widthAnchor.constraint(equalToConstant: 300),
//                backgroundView.heightAnchor.constraint(equalToConstant: 300)
//            ]
//        )
//
//        bottomFace.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate(
//            [
//                bottomFace.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//                bottomFace.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//                bottomFace.widthAnchor.constraint(equalToConstant: 300),
//                bottomFace.heightAnchor.constraint(equalToConstant: 300)
//            ]
//        )
        
        topFace.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                topFace.topAnchor.constraint(equalTo: self.topAnchor),
                //topFace.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                topFace.widthAnchor.constraint(equalToConstant: 300),
                topFace.heightAnchor.constraint(equalToConstant: 150)
            ]
        )
 
    
//    topFace.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate(
//    [
//    topFace.topAnchor.constraint(equalTo: self.topAnchor),
//    //topFace.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//    topFace.widthAnchor.constraint(equalToConstant: 300),
//    topFace.heightAnchor.constraint(equalToConstant: 300)
//    ]
//    )
    
//    smile.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate(
//    [
//    smile.topAnchor.constraint(equalTo: self.topAnchor),
//    //topFace.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//    smile.widthAnchor.constraint(equalToConstant: 300),
//    smile.heightAnchor.constraint(equalToConstant: 300)
//    ]
//    )
        
}
//
//   override func draw(_ rect: CGRect)
//    {
//        UIColor.green.set()
////        guard let context = UIGraphicsGetCurrentContext() else {
////            return
////        }
//         pathForMouth().stroke()
//
//    }
//
//   func pathForMouth() -> UIBezierPath
//    {
//        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
//        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
//        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset
//
//        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
//
//        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
//        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
//        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
//        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
//        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
//
//        let path = UIBezierPath()
//        path.move(to: start)
//        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
//        path.lineWidth = 5.0
//
//        return path
//    }
}
