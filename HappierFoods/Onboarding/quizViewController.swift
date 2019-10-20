//
//  quizViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 11/10/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class quizViewController: UIViewController {
    
    var howVariedIsYourDietValue = 0.5
    var willingnessToTryNewFood = 0
    //var result = (0.5, 0)

    @IBOutlet weak var howVariedIsYourDiet: UISlider!
    
    @IBAction func howVariedSlider(_ sender: UISlider) {
        howVariedIsYourDietValue = Double(sender.value)
        print("Slider value =" )
        print(howVariedIsYourDietValue)
    }
    
    @IBAction func yesTryNewFood(_ sender: UIButton) {
        willingnessToTryNewFood = 1
    }
    
    @IBAction func maybeTryNewFood(_ sender: Any) {
        willingnessToTryNewFood = 0
    }
    
    @IBAction func noTryNewFood(_ sender: Any) {
        willingnessToTryNewFood = -1
    }
    
    @IBAction func result(_ sender: myButton) {
        
        if willingnessToTryNewFood >= 0 && howVariedIsYourDietValue <= 0.55
        {
            performSegue(withIdentifier: "happyFoods", sender: self)
        }
        if willingnessToTryNewFood < 0 && howVariedIsYourDietValue <= 0.55
        {
            performSegue(withIdentifier: "cookingMama", sender: self)
        }
        if willingnessToTryNewFood >= 0 && howVariedIsYourDietValue > 0.55
        {
            performSegue(withIdentifier: "recipe", sender: self)
        }
        if willingnessToTryNewFood < 0 && howVariedIsYourDietValue > 0.55
        {
           performSegue(withIdentifier: "tesco", sender: self)
        }
    }
    
    
    @IBOutlet weak var yes: RadioButton!
    @IBOutlet weak var maybe: RadioButton!
    @IBOutlet weak var no: RadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yes?.isSelected = true
        maybe?.isSelected = true
        no?.isSelected = true
        
        yes?.alternateButton = [maybe!, no!]
        maybe?.alternateButton = [yes!, no!]
        no?.alternateButton = [maybe!, yes!]
    }
}
