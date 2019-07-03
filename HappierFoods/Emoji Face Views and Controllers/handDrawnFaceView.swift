//
//  handDrawnFaceView.swift
//  customFace
//
//  Created by Kate Roberts on 11/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class handDrawnFaceView: UIView {

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        assembleFace()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assembleFace()
    }
    
    // MARK: Layout subroutines
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
