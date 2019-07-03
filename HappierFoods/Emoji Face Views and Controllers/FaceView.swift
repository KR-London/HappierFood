//
//  FaceView.swift
//  HappierFoods
//
//  Created by Kate Roberts on 04/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class FaceView: UIView {
    
    var isAnimate = true
    
    var leftEye: [CGPoint] = []
    var rightEye: [CGPoint] = []
    var leftEyebrow: [CGPoint] = []
    var rightEyebrow: [CGPoint] = []
    var nose: [CGPoint] = []
    var outerLips: [CGPoint] = []
    var innerLips: [CGPoint] = []
    var faceContour: [CGPoint] = []
    
    var scale: CGFloat = 0.90
    var boundingBox = CGRect.zero
    
    @IBInspectable
    var mouthCurvature: Double = 1.0 { didSet { setNeedsDisplay() } }

    private var skullRadius: CGFloat{
        return min(bounds.size.width, bounds.size.height)/3
    }
    
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY + 30 )
    }
    
    private struct Ratios {
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
    }
    
    private enum Eye {
        case Left
        case Right
    }
    
    private func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath
    {
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*Double.pi),
            clockwise: false
        )
        path.lineWidth = 5.0
        return path
    }
    
    private func getEyeCenter(eye: Eye) -> CGPoint
    {
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .Left: eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath
    {
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye: eye)
        return pathForCircleCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeRadius)
    }
    
    private func pathForMouth() -> UIBezierPath
    {
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = 5.0
        
        return path
    }
    
    override func draw(_ rect: CGRect)
    {
        UIColor.black.set()
        pathForEye(eye: .Left).stroke()
        pathForEye(eye: .Right).stroke()
        pathForMouth().stroke()
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        // 2
        context.saveGState()
        
        // 3
        defer {
            context.restoreGState()
        }
        
        // 4
        context.addRect(boundingBox)
        
        // 5
        UIColor.red.setStroke()
        
        // 6
        context.strokePath()
        
        // 1
        UIColor.white.setStroke()
        
        if !leftEye.isEmpty {
            // 2
            context.addLines(between: leftEye)
            
            // 3
            context.closePath()
            
            // 4
            context.strokePath()
        }
        
    }
    
    func startAnimate() {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
        shakeAnimation.duration = 0.05
        shakeAnimation.repeatCount = 4
        shakeAnimation.autoreverses = true
        shakeAnimation.duration = 0.2
        shakeAnimation.repeatCount = 99999
        
        let startAngle: Float = (-2) * 3.14159/180
        let stopAngle = -startAngle
        
        shakeAnimation.fromValue = NSNumber(value: startAngle as Float)
        shakeAnimation.toValue = NSNumber(value: 3 * stopAngle as Float)
        shakeAnimation.autoreverses = true
        shakeAnimation.timeOffset = 290 * drand48()
        
        let layer: CALayer = self.layer
        layer.add(shakeAnimation, forKey:"animate")
        isAnimate = true
    }
    
    func stopAnimate() {
        let layer: CALayer = self.layer
        layer.removeAnimation(forKey: "animate")
        isAnimate = false
    }

}
