//
//  customNavigationController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 30/06/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class customNavigationController: UINavigationController {

    enum Costume: String{
        case SetTargetViewController
        case AddFoodViewController
        // I will refactor at some point to use the cases below for clearer code
        case ExpandingTriedFoodDetail
        case ExpandingTargetFoodDetail
        case ConvertTargetToTry
        case RetryTriedFood
        case FirstLaunch
        case ReturnFromCelebrationScreen
        case ResetDataAtTheStartOfNewWeek
        case Unknown
    }
    
    var presentState = Costume.Unknown
    
    var happyTracker = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func currentStateAsString()-> String{
        switch presentState
        {
            case .SetTargetViewController: return "SetTargetViewController"
            case .AddFoodViewController: return "AddFoodViewController"
            // I will refactor at some point to use the cases below for clearer code
            case .ExpandingTriedFoodDetail: return "ExpandingTriedFoodDetail"
            case .ExpandingTargetFoodDetail: return "ExpandingTargetFoodDetail"
            case .ConvertTargetToTry: return "ConvertTargetToTry"
            case .RetryTriedFood: return "RetryTriedFood"
            case .FirstLaunch: return "FirstLaunch"
            case .ReturnFromCelebrationScreen: return "ReturnFromCelebrationScreen"
            case .ResetDataAtTheStartOfNewWeek: return "ResetDataAtTheStartOfNewWeek"
            default: return "Unknown"
        }
    }
}
