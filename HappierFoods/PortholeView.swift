import UIKit

@IBDesignable class PortholeView: UIView {
    @IBInspectable var innerCornerRadius: CGFloat = 10.0
    @IBInspectable var inset: CGFloat = 20.0
    @IBInspectable var fillColor: UIColor = UIColor.gray
    @IBInspectable var strokeWidth: CGFloat = 5.0
    @IBInspectable var strokeColor: UIColor = UIColor.black
    
    //    override func draw(_ rect: CGRect) {
    //        // Prep constants
    //        let roundRectWidth = rect.width - (2 * inset)
    //        let roundRectHeight = rect.height - (2 * inset)
    //
    //        // Use EvenOdd rule to subtract portalRect from outerFill
    //        // (See http://stackoverflow.com/questions/14141081/uiview-drawrect-draw-the-inverted-pixels-make-a-hole-a-window-negative-space)
    //        let outterFill = UIBezierPath(rect: rect)
    //        let portalRect = CGRect(
    //            x: rect.origin.x + inset, y:
    //            rect.origin.y + inset, width:
    //            roundRectWidth,
    //                                   height: roundRectHeight)
    //        fillColor.setFill()
    //        let portal = UIBezierPath(roundedRect: portalRect, cornerRadius: innerCornerRadius)
    //        outterFill.append(portal)
    //        outterFill.usesEvenOddFillRule = true
    //        outterFill.fill()
    //        strokeColor.setStroke()
    //        portal.lineWidth = strokeWidth
    //        portal.stroke()
    //    }
    
    override func draw(_ rect: CGRect) {
        //let circle = UIBezierPath(ovalIn: rect)
        UIColor.yellow.set()
        // circle.fill()
        
     //   pathForCircleCenteredAtPoint(midPoint: skullCenter, withRadius: //skullRadius).fill()
        
        UIColor.black.set()
        // circle.stroke()
    //    pathForEye(eye: .Left).stroke()
    //    pathForEye(eye: .Right).stroke()
    //    pathForMouth().stroke()
        
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
   //     context.addRect(boundingBox)
        
        // 5
        UIColor.red.setStroke()
        
        // 6
        context.strokePath()
        
        // 1
        UIColor.white.setStroke()
        
     //   if !leftEye.isEmpty {
            // 2
    //        context.addLines(between: leftEye)
            
            // 3
            context.closePath()
            
            // 4
            context.strokePath()
        }
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
    
//}

