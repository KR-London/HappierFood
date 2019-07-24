//
//  mainViewController.swift
//  HappierFoods
//  Created by Kate Roberts on 06/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import Foundation
import Darwin
import CoreData

let defaults = UserDefaults.standard

class mainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var photoFilename = String()
    var foodName = String()
    var rating = Double()
    var triedOn = Date()
    var notes = String()
    
    @IBAction func instructionReminder(_ sender: UIButton) {
        onboardingRoutine()
    }
    // MARK: Core Data variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var food: [NSManagedObject] = []
    var foodArray: [TriedFood]!
    var targetArray: [TargetFood]!
    
    unowned var myNav : customNavigationController?
    
    // MARK: Outlets
    @IBOutlet weak var targetButton: UIButton!
    @IBOutlet weak var tryButton: UIButton!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var happy: UIImageView!
    
    // MARK: Actions
    @IBAction func expandDetailButtonPressed(_ sender: UIButton) {
        let buttonTag = sender.tag
        
        var collectionViewSize = 9
        if foodArray.count + targetArray.count > 9{
            collectionViewSize = foodArray.count + targetArray.count
        }
        
        if buttonTag < foodArray.count {
            photoFilename = foodArray[buttonTag].filename ?? "chaos.jpg"
            foodName = foodArray[buttonTag].name ?? ""
            rating = foodArray[buttonTag].rating
            triedOn = foodArray[buttonTag].dateTried!
            notes = foodArray[buttonTag].motivation ?? " "
            myNav!.presentState = .AddFoodViewController
            performSegue(withIdentifier: "expandDetail", sender: sender)
        }
        else{
            if collectionViewSize - buttonTag <= targetArray.count{
                photoFilename = targetArray[collectionViewSize - buttonTag - 1 ].filename ?? "chaos.jpg"
                foodName = targetArray[collectionViewSize - buttonTag - 1 ].name ?? ""
                rating = 0.0
                triedOn = targetArray[9 - buttonTag - 1 ].dateAdded!
                notes = targetArray[collectionViewSize - buttonTag - 1 ].motivation ?? " "
                myNav!.presentState = .SetTargetViewController
                performSegue(withIdentifier: "expandDetail", sender: sender)
            }
        }
    }
    

    
    // MARK: Page lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.popToRootViewController(animated: false)
        myNav = navigationController as? customNavigationController
        setUpNavigationBarItems()
        loadItems()

    
        // initialise celebration status
        let dateNow = Date().timeIntervalSince1970
        if defaults.double(forKey: "Last Week Started")  == 0.0        {
            defaults.set(dateNow, forKey: "Last Week Started")
            defaults.set(false, forKey: "Celebration Status")
        }
        
        if dateNow - defaults.double(forKey: "Last Week Started") > 604800{
            cacheData()
        }
        

// let datafilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
// print(datafilepath!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if defaults.bool(forKey: "Celebration Status") == true {
            view.backgroundColor = UIColor(red: 0, green: 206/255, blue: 250/255, alpha: 1)
        }
        else
        {
            view.backgroundColor = UIColor.white
        }
        
        // do I REALLY need this?
        mainCollectionView.reloadData()

        
        if defaults.bool(forKey: "Celebration Status") == false && foodArray.count == 9
        {
            defaults.set(true, forKey: "Celebration Status")
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
               self.performSegue(withIdentifier: "celebrationSegue", sender: nil )
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
      ////  self.mainCollectionView.reloadInputViews()
        happyIcon()
        
        switch myNav!.presentState
        {
            case .FirstLaunch : print("In first launch.")
                //onboardingRoutine()
            case .ResetDataAtTheStartOfNewWeek : publicInformationBroadcast(didTheyReachTheirTarget: false)
            case .ReturnFromCelebrationScreen : publicInformationBroadcast(didTheyReachTheirTarget: true)
            default: break
        }
    
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return "HappyFoods Update"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "addFoodSegue" || segue.identifier == "setTargetSegue"{
            
            let dvc = segue.destination as! dataInputViewController
            /// I want the rate food screen to look different depending if I'm trying a food or setting a target. This is a marker I'm sending forward, so that I can largely reuse the same class with small changes.
            if let button = sender as? UIButton{
                dvc.sourceViewController = button.titleLabel?.text ?? "Dunno"
            }
        }
        if segue.identifier == "expandDetail" {
            let dvc = segue.destination as! DetailViewController
            dvc.detailToDisplay =  (photoFilename: photoFilename, foodName: foodName, rating: rating, triedOn: triedOn, notes: notes)
        }
    }
    
    // MARK: Widgets to communicate with the user
    
    func happyIcon(){
        // this subroutine animates the appearance/disappearance of the little Happy character in the top left corner, to 'reward' the user for trying 9 new foods.
        
        if foodArray.count >= 9 && defaults.bool(forKey: "Celebration Status") == true{
            print("commented while i decide what to do with happy")
//            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)){
//                let animator = UIViewPropertyAnimator(duration: 2, curve: .easeOut) {  [weak self] in
//                    self?.happy.alpha = 1
//                }
//                animator.startAnimation()
//            }
        }
        else
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)){
                let animator = UIViewPropertyAnimator(duration: 2, curve: .easeOut) {  [weak self] in
                    self?.happy.alpha = 0
                }
                animator.startAnimation()
            }
        }
    }
    
    func publicInformationBroadcast(didTheyReachTheirTarget: Bool){
        /// This subroutine is to make sure the user knows what's going on, and doesn;t worry when we remove their data from view
        let publicInformationText = UILabel()
        
        if didTheyReachTheirTarget == true{
            publicInformationText.text = "Well done! You tried 9 new foods. I'll keep tracking any new food you try. At the end of the week, I'll move the data to the history screen and reset. "
        }
        else {
            publicInformationText.text = "It's a new week! I've reset the log - but don't worry - the foods you've tried are still stored in the history page. Aim for 9 'tries' this week. It's okay to try the same new food several times!"
        }
        
        self.view.addSubview(publicInformationText)
        publicInformationText.font  = UIFont(name: "07891284.ttf", size: 24)
        publicInformationText.lineBreakMode = .byWordWrapping
        publicInformationText.numberOfLines = 5
        
        publicInformationText.translatesAutoresizingMaskIntoConstraints = false
        publicInformationText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        publicInformationText.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        publicInformationText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        publicInformationText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        publicInformationText.alpha = 0.0
        publicInformationText.backgroundColor = UIColor.white
        publicInformationText.cornerRadius = 5 
        
        
        /// fade it in & out with RH picture
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)){
            let animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
                publicInformationText.alpha = 1
            }
            animator.startAnimation()
        }
        
        /// fade it in & out with RH picture
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)){
            let animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
                publicInformationText.alpha = 0
            }
            animator.startAnimation()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)){
            self.reloadInputViews()
        }

        
    }
    
    func onboardingRoutine(){
        /// add image subview in the middle
        let onboardingInstruction: UIImage = UIImage(named: "onboarding1.png")!
        let onboardingImageView = UIImageView(image: onboardingInstruction)
        
        //  onboardingImageView
        self.view.addSubview(onboardingImageView)
        onboardingImageView.translatesAutoresizingMaskIntoConstraints = false
        onboardingImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        onboardingImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        onboardingImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        onboardingImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        onboardingImageView.contentMode = .scaleAspectFill
        onboardingImageView.alpha = 0.0
        
        /// pulse the RH button
      
        for i in 0 ... 0{
        /// fade it in & out with RH picture
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(7*i)){
            self.startAnimate(button: self.tryButton)
            let animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            onboardingImageView.alpha = 1
            }
            animator.startAnimation()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2 + 7*i)){
            let animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {
                onboardingImageView.alpha = 0
            }
            animator.startAnimation()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3 + 7*i)){
            self.stopAnimate(button: self.tryButton)
            onboardingImageView.image = UIImage(named: "onboarding2.png")
            self.startAnimate(button: self.targetButton)
            
            let animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
                onboardingImageView.alpha = 1
            }
            animator.startAnimation()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4 + 7*i)){
            let animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {
                onboardingImageView.alpha = 0
            }
            animator.startAnimation()
        }
        
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6 + 7*i)){
                self.stopAnimate(button: self.targetButton)
                onboardingImageView.image = UIImage(named: "onboarding1.png")
            }
        }
        
    }
    
    func startAnimate(button: UIButton) {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
        shakeAnimation.duration = 0.05
        shakeAnimation.repeatCount = 4
        shakeAnimation.autoreverses = true
        shakeAnimation.duration = 0.2
        shakeAnimation.repeatCount = 99999
        
        let startAngle: Float = (-2) * 3.14159/180
        let stopAngle = -startAngle
        
        shakeAnimation.fromValue = NSNumber(value: startAngle as Float)
        shakeAnimation.toValue = NSNumber(value: 3 * stopAngle as Float)
        shakeAnimation.autoreverses = true
        shakeAnimation.timeOffset = 290 * drand48()
        
        let layer: CALayer = button.layer
        layer.add(shakeAnimation, forKey:"animate")
 
    }
    
    func stopAnimate(button: UIButton) {
        let layer: CALayer = button.layer
        layer.removeAnimation(forKey: "animate")
    }
    
    func setUpNavigationBarItems(){
        navigationItem.title = "HappyFoods"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:  UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )!]
        navigationController?.navigationBar.tintColor = UIColor.black
        
        let shareButton = UIButton(type: .system)
    
        shareButton.setImage(UIImage(named: "appleShare" ), for: .normal)
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
        
        let historyButton = UIButton(type: .system)
        historyButton.setImage(UIImage(named: "appleHistory"), for: .normal)
        historyButton.addTarget(self, action: #selector(goHistory), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: historyButton)
        
        happy.alpha = 0
    }
    

    
    // MARK: Action functions
     @objc func goHistory() {
        performSegue(withIdentifier: "historySegue", sender: UIButton())
    }
    
    @objc func share() {
        
        var whatHaveITried = String()
        var whatItarget = String()
        
        if foodArray.count > 0 {
            let triedFoodReport = foodArray.compactMap{$0.name}.filter{$0 != ""}
            if triedFoodReport.count >= 0
            {
                whatHaveITried = "This week I have tried" + triedFoodReport.flatMap{" " + $0 + ","}
                whatHaveITried = String(whatHaveITried.dropLast())
                if triedFoodReport.count < foodArray.count{
                    whatHaveITried = whatHaveITried + " and " + String(foodArray.count - triedFoodReport.count) + " foods that I don't have a name stored for."
                }
                else{
                    whatHaveITried = whatHaveITried + "."
                }
            }
            else{
                whatHaveITried = "I have tried " + String(foodArray.count) + " foods that I don't have a name stored for."
            }
           
        }
        else {
            whatHaveITried = "I haven't tried anything new yet this week. "
        }
        
        if targetArray.count > 0 {
            let targetFoodReport = targetArray.compactMap{$0.name}.filter{$0 != ""}
            if targetFoodReport.count > 0
            {
                whatItarget = "This week my targets are to try" + targetFoodReport.flatMap{" " + $0 + ","}
                whatItarget = String(whatItarget.dropLast())
                if targetFoodReport.count < foodArray.count{
                    whatItarget = whatItarget + " and " + String(targetArray.count - targetFoodReport.count) + " foods that I don't have a name stored for."
                }
                else{
                    whatItarget = whatItarget + "."
                }
            }
            else{
              whatItarget = "I have targeted " + String(targetArray.count) + " foods that I don't have a name stored for."
            }
        }
        else {
            whatItarget = "I haven't set any targets this week."
        }
    
        let activityViewController = UIActivityViewController(activityItems: [whatHaveITried, whatItarget], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
    // MARK: Delete and archive functions
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        }
        catch let error {
            print("Delete all data in \(entity) error :", error)
        }
    }
    
    func cacheData(){

        deleteAllData("TriedFood")
        foodArray = []
        
        DispatchQueue.main.async{
            self.mainCollectionView.reloadData()
            self.mainCollectionView.reloadInputViews()
        }
        /// reset markers
        let dateNow = Date().timeIntervalSince1970
        defaults.set(dateNow, forKey: "Last Week Started")
        defaults.set(false, forKey: "Celebration Status")
        myNav!.presentState = .ResetDataAtTheStartOfNewWeek
    }
    
}

// MARK: Collection View extension
extension mainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width/3 - 8 , height: collectionView.bounds.size.width/3 - 8 )
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if foodArray.count + targetArray.count < 9
        {
            return 9
        }
        else
        {
            return foodArray.count + targetArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! mainCollectionViewCell
        cell.cellImage.isHidden = true
        cell.instructionReminder.isHidden = false
        cell.cellImage.alpha = 1
        cell.tickImage.isHidden = true
        cell.backgroundColor = UIColor().HexToColor(hexString: "#D3B99F", alpha: 1.0)
            //UIColor(hex: "#D3B99F")
        cell.showDetailButtonProperties.tag = indexPath.row
        
        var collectionViewSize = 9
        
        if foodArray.count + targetArray.count > 9
        {
            collectionViewSize = foodArray.count + targetArray.count
        }
    
        if foodArray != nil {
                if indexPath.row < foodArray.count {
                    cell.backgroundColor = UIColor.clear
                    cell.cellImage.isHidden = false
                  //  cell.cellImage.alpha = 1
                    let plate = foodArray[indexPath.row]
                    let fileToLoad = plate.filename ?? "1.png"
                    //cell.cellImage.image = UIImage(named: "1.png")
                    cell.displayContent(image: fileToLoad)
                    cell.tickImage.isHidden = false
                    cell.instructionReminder.isHidden = true
                
                }
                else
                {
                    cell.tickImage.isHidden = true
                    cell.instructionReminder.isHidden = false
                }
            }
        
            if targetArray != nil {
                if indexPath.row < collectionViewSize && targetArray.count > collectionViewSize - indexPath.row - 1 {
                    cell.cellImage.isHidden = false
                    cell.backgroundColor = UIColor.clear
                    let plate = targetArray[collectionViewSize
                        - indexPath.row - 1]
                    let fileToLoad = plate.filename ?? "1.png"
                    cell.displayContent(image: fileToLoad)
                    cell.cellImage.alpha = 0.2
                    cell.tickImage.isHidden = true
                    cell.instructionReminder.isHidden = true
                }
            }

        return cell
    }
    
    /// MARK: Setup
    func loadItems(){
        let request : NSFetchRequest<TriedFood> = TriedFood.fetchRequest()
        do{
            try foodArray = context.fetch(request)
        }
        catch{
            print("Error fetching data \(error)")
        }
        
        let request2 : NSFetchRequest<TargetFood> = TargetFood.fetchRequest()
        do{
            try targetArray = context.fetch(request2)
        }
        catch{
            print("Error fetching data \(error)")
        }
        
        /// clean data
        if foodArray.count > 0  {
            let foodArrayCount = foodArray.count
            for i in 0 ... (foodArray.count - 1){
                if UIImage(named: foodArray[foodArrayCount - 1  - i].filename ?? "neverUsed") == nil
                {
                    context.delete(foodArray[foodArrayCount - 1 - i])
                    do{
                        try context.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                    foodArray.remove(at: foodArrayCount - 1 - i)
                }
            }
        }
        if targetArray.count > 0  {
            let targetArrayCount = targetArray.count
            for i in 0 ... targetArrayCount - 1
            {
                if UIImage(named: targetArray[targetArrayCount - 1  - i].filename ?? "neverUsed") == nil
                {
                    context.delete(targetArray[targetArrayCount - 1 - i])
                    do{
                        try context.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                    targetArray.remove(at: targetArrayCount - 1 - i)
                }
            }
        }
    }
    
    
//    func getPlist(withName name: String) -> [AnyObject]?
//    {
//        if  let path = Bundle.main.path(forResource: name, ofType: "plist"),
//            let xml = FileManager.default.contents(atPath: path)
//        {
//            return (try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)) as? [AnyObject]
//        }
//
//        return nil
//    }
//

  
}

