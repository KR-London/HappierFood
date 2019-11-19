//
//  personality.swift
//  HappierFoods
//
//  Created by Kate Roberts on 19/11/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import Foundation

struct happySays{
    
    let firstUseMessages =
            [   "Welcome to HappyFoods",
                "Click on my tummy if you ever need a bit more help",
                "Logon every day to maintain your streak!",
                "Check out the stats and the history on the top bar!"
            ]
    
    let generalSupportiveMessages =
            [
                "Trying new foods is hard - you're doing great!",
                "You can do this!"
            ]
    
    let celebrateRetryingMessages =   [   "It can take many tries to accept a new food",
                  "Wow - what perseverance",
                  "Stick with it - you'll get used to /(foodName)",
                  "Congratulations, that's /(tries) times. You're well on your way to making /(foodName) a safe food!"
              ]
    let celebrateUsageMessages =   [   "Yeahh - what a streak!!!",
        "Hot stuff!",
        "Keep up the good work!"
    ]
    
    let vegetableMessages =   [   "Congratulations, you're really looking after yourself by trying that food",
          "I'm super proud of you for trying a nourishing food",
          "Keep up the good work!",
           "Eating healthy is getting nearer"
      ]
    
    let mixedFoodMessages =   [   "These foods will make eating with friends and family easier for you",
          "Keep going like this, and restaurant menus will be a joy for you"
      ]
    
    var foodName: String?
    var tries: Int?
    var logons: Int?
    
    
    /// define a function which screens the food input for if it is froma particular class - e.g. vegetables
    func identifyContext(foodName: String?, tryNumber: Int?, logonNumber: Int?, screen: screen) -> String{
        if [5, 10, 15, 20, 25].contains(tryNumber)
        {
            return celebrateRetrying(tryNumber: tryNumber!, name: foodName ?? "this food")
        }
        if [5, 10, 15, 20, 25].contains(logonNumber)
        {
            return celebrateUsage(logonNumber: logonNumber!)
        }
        if [1,2,3,4].contains(logonNumber)
        {
                   return firstUseMessages[logonNumber! - 1]
        }
        if ["carrots", "broccoli", "tomatoes", "avocado", "cauliflower"].contains(foodName)
        {
            return celebrateVegetables(name: foodName ?? "this food")
        }
        
        if ["lasagna", "curry", "stew"].contains(foodName)
        {
            return celebrateMixedUpFood(name: foodName ?? "this food")
        }
        
        return generalSupportiveMessages.randomElement() ?? "Well done - you are doing great!"
    }
    
    func celebrateRetrying(tryNumber: Int, name: String) -> String{
        return celebrateRetryingMessages.randomElement()!
    }
    
    func celebrateUsage(logonNumber: Int) -> String{
           return celebrateUsageMessages.randomElement()!
       }
    
    func celebrateVegetables(name: String) -> String{
              return vegetableMessages.randomElement()!
          }
    
    func celebrateMixedUpFood(name: String) -> String{
              return mixedFoodMessages.randomElement()!
          }
}

enum screen{
    case mainScreen
    case afterTryingaFoodScreen
    case afterSettingTargetScreen
    case coachingScreen
}
