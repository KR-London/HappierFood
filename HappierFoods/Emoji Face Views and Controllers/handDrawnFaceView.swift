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
    override init(frame: CGRect) {
        super.init(frame: frame)
        assembleFace()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assembleFace()

    }
    
    func assembleFace(){
        addSubview(bottomFace)
        addSubview(topFace)
        topFace.translatesAutoresizingMaskIntoConstraints = false
        bottomFace.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                topFace.topAnchor.constraint(equalTo: self.topAnchor),
                topFace.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                topFace.widthAnchor.constraint(equalToConstant: 300),
                topFace.heightAnchor.constraint(equalToConstant: 150)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                bottomFace.topAnchor.constraint(equalTo: self.topAnchor),
                bottomFace.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                bottomFace.widthAnchor.constraint(equalToConstant: 300),
                bottomFace.heightAnchor.constraint(equalToConstant: 300)
            ]
        )
        

        
    }
}
