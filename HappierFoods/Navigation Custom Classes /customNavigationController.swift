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

        // MARK: Colour
       navigationBar.barTintColor = UIColor(red: 103/255, green: 230/255, blue: 194/255, alpha: 1)
        navigationBar.tintColor = UIColor(red: 3/255, green: 18/255, blue: 8/255, alpha: 1)
        
      //  navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
       // navigationBar.backItem?.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: font!], for: .normal)

       // R103 G230 B194
        
      if #available(iOS 13.0, *) {
         let app = UINavigationBarAppearance()
              app.backButtonAppearance.normal.titleTextAttributes = [
                  NSAttributedString.Key.font: UIFont(name:"TwCenMT-CondensedExtraBold", size: 24)!
              ]
              UINavigationBar.appearance().standardAppearance = app
        }
//
//        UIBarButtonItem.appearance().setTitleTextAttributes(
//        [
//            NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Light", size: 12)!,
//            NSAttributedString.Key.foregroundColor : UIColor.white,
//        ], for: .normal )
//
//
//        UIBarButtonItem.appearance().setTitleTextAttributes(
//              [
//                  NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Light", size: 12)!,
//                  NSAttributedString.Key.foregroundColor : UIColor.white,
//        ], for: .disabled )
//
//        UIBarButtonItem.appearance().setTitleTextAttributes(
//              [
//                  NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Light", size: 12)!,
//                  NSAttributedString.Key.foregroundColor : UIColor.white,
//        ], for: .reserved )
//
//        UIBarButtonItem.appearance().setTitleTextAttributes(
//                     [
//                         NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Light", size: 12)!,
//                         NSAttributedString.Key.foregroundColor : UIColor.white,
//        ], for: .application )
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

//
//extension UIBarButtonItem {
//
//    var substituteFontName : String {
//        get { return self.style.font.fontName }
//        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
//    }
//
//}
