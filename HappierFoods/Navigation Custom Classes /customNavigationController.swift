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
//        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 233, green: 2, blue: 3, alpha: 1.0)]
//        UINavigationBar.appearance().titleTextAttributes = textAttributes
        
        
        // MARK: Colour
        navigationBar.barTintColor = UIColor(red: 103/255, green: 230/255, blue: 194/255, alpha: 1)
        
        navigationBar.tintColor = UIColor(red: 3/255, green: 18/255, blue: 8/255, alpha: 1)
        
        
       // R103 G230 B194
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
