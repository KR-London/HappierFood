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
                "Log in every day to maintain your streak!",
                "Check out the stats and the history on the top bar!"
            ]
    
    let generalSupportiveMessages =
            [
                "Trying new foods is hard - you're doing great!",
                "You can do this!",
                "It’s ok if you can’t eat something, everything will be alright",
                "Remember to breathe",
                "You're really trying, I can tell",
                "If you're struggling, why not take half an hour out to play a game, and then come back?",
                "I know this is hard for you, but we can try new things together.", "Start with food you like, and move your comfort zone outwards"
            ]
    
    let targetMessages = ["Food is a multisensory experience" , "It can be helpful to target trying foods similar to ones you already like"]
    
    let celebrateRetryingMessages =   [   "It can take many tries to accept a new food",
                  "Wow - what perseverance",
                  "Stick with it - you'll get used to /(foodName)",
                  "Congratulations, that's /(tries) times. You're well on your way to making /(foodName) a safe food!"
              ]
    let celebrateUsageMessages =   [   "Yeahh - what a streak!!!",
        "Hot stuff!",
        "Keep up the good work!",
        "You're doing this for you!"
    ]
    
    let vegetableMessages =   [   "Congratulations, you're really looking after yourself by trying that food",
          "I'm super proud of you for trying a nourishing food",
          "Keep up the good work!",
           "Eating healthy is getting nearer"
      ]
    
    let mixedFoodMessages =   [   "These foods will make eating with friends and family easier for you",
          "Keep going like this, and restaurant menus will be a joy for you", "Mushy food! That's brave"
      ]
    
    let mainScreenComms =   [   "Tap on my tummy for more help", "Have you tried challenge mode? Tap on my tummy to learn more.", "Your target is to try 9 new foods a week!", "Login every day to maintain your streak"
         ]
    
    let afterChallengeScreenComms =   [   "Having fun with food can help reduce the fear", "Some people find it helps to play with food with no pressure to eat", "That's funny!", "You can share from the challenge screen", "Start with food you like, and move your comfort zone outwards", "Be a kid again - it's good for you", "Food is a multisensory experience"
            ]
    
    var foodName: String?
    var tries: Int?
    var logons: Int?
    
    
    /// define a function which screens the food input for if it is froma particular class - e.g. vegetables
    func identifyContext(foodName: String?, tryNumber: Int?, logonNumber: Int?, screen: screen) -> String{
        
        if screen == .challengeScreen {
            return afterChallengeScreenComms.randomElement()!
        }
        
        if [5, 10, 15, 20, 25].contains(tryNumber)
        {
            return celebrateRetrying(tryNumber: tryNumber!, name: foodName ?? "this food")
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
        
        if screen == .mainScreen && [8, 12, 16, 20].contains(logonNumber){
            return mainScreenComms[(logonNumber ?? 8)/4 - 2]
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



//Eg child indicates they are having a difficult food day/moment
//App then says something like:
//“oof!” (my teen’s slang suggestion),
//“This is hard for you (acknowledgement not platitudes) but we can try some things together.”
//Then says: “would you like to try a sensory tool”?
//Then random suggestion to:
//Smell, touch, lick, chew but not swallow, a food etc
//And a rating of how it went. These ratings to be logged to see progress over time.
//Perhaps even an info screen later on when your app is up and running about how sensory experiences help and how we need lots of them to feel safe with foods.

//You can play on the word “chain” and make jokes about “what rhymes with...” or something like that. The idea being to form a perception in the child’s mind about things that link together, so that they can start seeing the connection between foods and do food chaining.
//Then you can do the same as above but add food chaining as an option.
//Eg “would you like to build a food chain with me? Or “let’s build a food chain”
//The app then instructs the child to think of a food they like and then to think of something almost like it, made from the same ingredients or with the same sensory consistency. The app then offers the child the the same sensory strategies as above and the same rating and logging options.
//Christelle Gill I’ll also add that there needs to be humour as just a logging tool is pretty disheartening if you have nothing to log. And they lose interest in the app very quickly that way. Bad days need strategies to help them feel that a bad day is just one day, not life.
//When you are up and running you could throw some CBT in as options too. Things like examining thoughts: are they real or perceived (eg this food will make me sick - what evidence is there or is it your mind playing tricks on you), turning negative put downs into motivation etc. A good one for this is to direct the negatives they self-talk to an inanimate object - it soon becomes ridiculous and then humour can be used to turn negative into positive. Or they can “feed” their character in the app their own negative thoughts and it throws back positive phrases back at them. If they feed it positives it starts to glow or something.
//I don’t know how that would translate into some digital but we had a pet rock who could only say positive things. We would feed it negative self talk and then imagined it giving off positive words. It was a “sad words muncher” who pooped happy thought rainbows - bit graphic and odd for your app but that was our thing 😆 🤷🏻‍♀️


//u/negasonictracer
