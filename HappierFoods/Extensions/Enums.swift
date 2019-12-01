//
//  Enums.swift
//  HappierFoods
//
//  Created by Kate Roberts on 30/11/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import Foundation


enum Costume: String{
    case SetTargetViewController
    case AddFoodViewController
    // I will refactor at some point to use the cases below for clearer code
    case ExpandingTriedFoodDetail
    case ExpandingTargetFoodDetail
    case ConvertTargetToTry
    case RetryTriedFood
    case FirstLaunch
    case FirstTarget
    case ReturnFromCelebrationScreen
    case ResetDataAtTheStartOfNewWeek
    case Unknown
}

enum screen{
    case mainScreen
    case afterTryingaFoodScreen
    case afterSettingTargetScreen
    case coachingScreen
    case challengeScreen
}

enum dataInputMode: String{
    case camera
    case cameraRoll
    case write
    case unknown
}

enum entryType: String{
    case challenge
    case triedThisWeek
    case triedBeforeThisWeek
    case target
    case targetCompleted
}


