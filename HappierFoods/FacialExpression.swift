//
//  FacialExpression.swift
//  HappierFoods
//
//  Created by Kate Roberts on 04/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import Foundation

struct FacialExpression{
    enum Mouth: Int {
        case Frown
        case Smirk
        case Neutral
        case Grin
        case Smile
        
        func sadderMouth() -> Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .Frown
        }
        func happierMouth() -> Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .Smile
        }
    }
    
   // var eyes: Eyes
   // var eyeBrows: EyeBrows
    var mouth: Mouth
}
