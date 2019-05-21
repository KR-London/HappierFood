//
//  detailContainer3.swift
//  HappierFoods
//
//  Created by Kate Roberts on 14/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class detailContainer3: UIView {
    
    var rating = 0.0

    lazy var DateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont(name: "07891284.ttf", size: 22)
        dateLabel.text = "Your rating"
        dateLabel.textAlignment = .center
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()

    lazy var TopFaceView: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "eyeOpen_browDownLeft.png")
//contentView.image = UIImage(named: "chaos.jpg")
         contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    lazy var BottomFaceView: UIImageView = {
        let contentView = UIImageView()
        
        contentView.image = UIImage(named: "face.png")
        //contentView.image = UIImage(named: "chaos.jpg")
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    lazy var smileView1: UIView = {
       //let contentView = UIView()
        let contentView = smileView()
        contentView.backgroundColor = UIColor.clear
        contentView.draw(self.frame)
        contentView.mouthCurvature = rating
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
//    lazy var Smile: UIView = {
//        let contentView = smileView()
//        return contentView
//    }()
    
//    override func draw(_ rect: CGRect)
//    {
//        UIColor.black.set()
//       // pathForMouth().stroke()
//    }
//
//    func pathForMouth() -> UIBezierPath
//    {
//        let mouthWidth = Double(frame.height)
//        let mouthHeight = 50.0
//        let mouthOffset = 10.0
//
//       // let mouthRect = CGRect(x: 50, y: 100, width: mouthWidth, height: mouthHeight)
//
//                let mouthRect = CGRect(x: Double(BottomFaceView.center.x) - mouthWidth/2, y: Double(BottomFaceView.center.y) + mouthOffset, width: mouthWidth, height: mouthHeight)
//
//        let smileOffset = CGFloat(max(-1, min(0.4, 1))) * mouthRect.height
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customViewItems()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customViewItems()
    }
    
    func customViewItems(){
        backgroundColor = UIColor.clear
        addSubview(DateLabel)
        addSubview(BottomFaceView)
        addSubview(TopFaceView)
        addSubview(smileView1)
        //bringSubviewToFront(self.dr)
//addSubview()
        applyLayoutConstraints(view1: DateLabel, view2: TopFaceView, view3: BottomFaceView, view4: smileView1)
        //applyLayoutConstraints2(view2: TopFaceView)
        translatesAutoresizingMaskIntoConstraints = false
        // frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
  
        
    }
    
    func applyLayoutConstraints(view1 : UIView, view2: UIView, view3: UIView, view4: UIView)
    {
        NSLayoutConstraint.activate([
            view1.topAnchor.constraint(equalTo: topAnchor),
            view1.leadingAnchor.constraint(equalTo: leadingAnchor),
            view1.heightAnchor.constraint(equalTo: heightAnchor),
            view1.trailingAnchor.constraint(equalTo: view2.leadingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            view2.topAnchor.constraint(equalTo: topAnchor),
            view2.trailingAnchor.constraint(equalTo: trailingAnchor),
            view2.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            view2.widthAnchor.constraint(equalTo: heightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            view3.topAnchor.constraint(equalTo: view2.topAnchor),
            view3.bottomAnchor.constraint(equalTo: view1.bottomAnchor),
            view3.leadingAnchor.constraint(equalTo: view2.leadingAnchor),
            view3.trailingAnchor.constraint(equalTo: view2.trailingAnchor),
            ])
        
        NSLayoutConstraint.activate([
            view4.heightAnchor.constraint(equalTo: heightAnchor),
            view4.widthAnchor.constraint(equalTo: heightAnchor),
            view4.centerXAnchor.constraint(equalTo: view3.centerXAnchor),
            view4.centerYAnchor.constraint(equalTo: view3.centerYAnchor)
            ])
    }
    
    func applyLayoutConstraints2(view2: UIView)
    {
        NSLayoutConstraint.activate([
            view2.topAnchor.constraint(equalTo: topAnchor),
            view2.trailingAnchor.constraint(equalTo: trailingAnchor),
            view2.heightAnchor.constraint(equalTo: heightAnchor),
            view2.widthAnchor.constraint(equalTo: heightAnchor)
            ])
    }

}


