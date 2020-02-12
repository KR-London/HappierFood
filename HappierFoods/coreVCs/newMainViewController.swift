import UIKit
import Foundation
import Darwin
import CoreData
import MessageUI
//import SAConfettiView

let defaults = UserDefaults.standard
var bulkDelete = false

class newMainViewController: UIViewController {
    
    var photoFilename = String()
    var foodName = String()
    var rating = Double()
    var triedOn = Date()
    var notes = String()
    
    /// happy and his hidden button
    lazy var happyButton: UIButton = {
        var button = UIButton()
        button.setImage(#imageLiteral(resourceName: "little dude1.png"), for: .normal)
        return button
    }()
    
    /// bubble view
    lazy var bubbleBox: UIView = {
        let bubble = UIView()
        bubble.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        return bubble
    }()
    
    /// collection view
        /// do I want to initialise this here...? Or do it in the main code...?
    
    lazy var myCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        return collection
    }()
    
    /// stats view
    lazy var statsView: UIView = {
        let stats = UIView()
        //stats.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return stats
    }()
    
    /// add fodd button
    
    lazy var addFoodButton: myButton = {
       let button = myButton()
        //button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 72)
        return button
    }()
    
    // MARK: Core Data variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var food: [NSManagedObject] = []
    var foodArray: [Tried]!
    var targetArray: [Target]!
    var logons: [Logons]!
    
    // MARK: Confetti variables
    var confettiView: SAConfettiView!
    var isRainingConfetti = false
    
    unowned var myNav : customNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            //  self.present(nextViewController, animated: true, completion: nil)
        loadItems()
        setUpSubview()
       // self.becomeFirstResponder()
        // MARK: UI customisations
       // showMessage()
       displayStats()

        
        if  UserDefaults.standard.bool(forKey: "launchedBefore") == false
        {
             UserDefaults.standard.set(true, forKey: "launchedBefore")
            launchExtraTutorial()       // if myNav?.presentState ==
        }
            //performSegue(withIdentifier: "celebrationSegue", sender: nil )
        
        navigationController?.popToRootViewController(animated: false)
        myNav = navigationController as? customNavigationController
    
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//              let nextViewController = storyboard.instantiateViewController(withIdentifier: "newDataInputViewController" )
//        myNav?.pushViewController(nextViewController, animated: true)
//        
        setUpNavigationBarItems()
       

        // initialise celebration status
        let dateNow = Date().timeIntervalSince1970
        if defaults.double(forKey: "Last Week Started")  == 0.0        {
            defaults.set(dateNow, forKey: "Last Week Started")
            defaults.set(false, forKey: "Celebration Status")
        }
        
        if dateNow - defaults.double(forKey: "Last Week Started") > 604800{
            cacheData()
        }
        view.backgroundColor = UIColor(red: 251/255, green: 254/255, blue: 252/255, alpha: 1)
      //  let datafilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        //print(datafilepath!)
    }
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
          if motion == .motionShake {
              showFeedbackDialog()
          }
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        showMessage()
        
        if foodArray.count<16 { addFoodButton.isHidden = true}
        
        
        if defaults.bool(forKey: "Celebration Status") == true {
            view.backgroundColor = UIColor(red: 224/255, green: 250/255, blue: 233/255, alpha: 1)
      
        }
        else
        {
            view.backgroundColor = UIColor.white
        }
        
        // do I REALLY need this?
        myCollectionView.reloadData()

        
        if defaults.bool(forKey: "Celebration Status") == false && foodArray.count == 9
        {
            defaults.set(true, forKey: "Celebration Status")
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
               //self.performSegue(withIdentifier: "celebrationSegue", sender: nil )
            }
        }
        
        if foodArray.count > 15{
             let margins = view.layoutMarginsGuide
            view.addSubview(addFoodButton)
            addFoodButton.translatesAutoresizingMaskIntoConstraints = false
              addFoodButton.addTarget(self, action: #selector(addFood), for: .touchUpInside)
              NSLayoutConstraint.activate([
                  addFoodButton.topAnchor.constraint(equalTo: myCollectionView.bottomAnchor, constant: 8),
                  addFoodButton.heightAnchor.constraint(equalTo:   margins.widthAnchor, multiplier: 0.25, constant: -8),
                  addFoodButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -8),
                  addFoodButton.widthAnchor.constraint(equalTo:   margins.widthAnchor, multiplier: 0.25, constant: -8)
              ])
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
      ////  self.mainCollectionView.reloadInputViews()
        //happyIcon()
       // bubbleBox.subviews.removeAll()
       
        
        if isRainingConfetti == true{
            confettiView.isHidden = false
            confettiView.alpha = 1 
            confettiView.startConfetti()
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeIn) {  [weak self] in
                    self?.confettiView.alpha = 0
            }
            animator.startAnimation()
            
             DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                self.confettiView.stopConfetti()
                self.isRainingConfetti = false
                self.confettiView.isHidden = true
            }
        }
        
        switch myNav!.presentState
        {
            case .FirstLaunch : print("In first launch.")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                           
              let storyboard = UIStoryboard(name: "ExtraTutorial", bundle: nil)
              let initialViewController = storyboard.instantiateViewController(withIdentifier: "p0" ) as! secondTutorialPageViewController
                initialViewController.firstTry = true
               self.present(initialViewController, animated: false, completion: nil)
          }
            case .ResetDataAtTheStartOfNewWeek : //publicInformationBroadcast(didTheyReachTheirTarget: false)
                print("Should be a comiseration message here")
            case .ReturnFromCelebrationScreen :
                 print("Should be a congrats message here")//publicInformationBroadcast(didTheyReachTheirTarget: true)
            default: break
        }
 
    }

    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
          return "HappyFoods Update"
      }
    
    //MARK: Layout subroutines
        func setUpNavigationBarItems(){
            navigationItem.title = "HappyFoods"
            //navigationItem.titleView?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

            let navBarHeight = navigationController?.navigationBar.frame.height
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Stats", style: .plain, target: self, action: #selector(goStats))
            
            let historyButton = UIButton(type: .system)
            historyButton.setImage(UIImage(named: "appleHistory")?.resize(to: CGSize(width: 0.55*(navBarHeight ?? 100),height: 0.55*(navBarHeight ?? 100) )), for: .normal)
            historyButton.addTarget(self, action: #selector(goHistory), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: historyButton)
        }
    
    func setUpSubview(){
        let margins = view.layoutMarginsGuide
       // let myNav = self.navigationController
        
       
        
        let bubbleHeight = 0.3*(view.frame.height - view.frame.width - (myNav?.navigationBar.frame.height ?? 0 ) )
        
        view.addSubview(happyButton)
        happyButton.translatesAutoresizingMaskIntoConstraints = false
        happyButton.addTarget(self, action: #selector(happyCoachingSegue), for: .touchUpInside)
        NSLayoutConstraint.activate([
            happyButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0.3*bubbleHeight),
            happyButton.heightAnchor.constraint(equalToConstant: bubbleHeight),
            happyButton.widthAnchor.constraint(equalToConstant: bubbleHeight),
            happyButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        ])
        
        view.addSubview(bubbleBox)
        bubbleBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bubbleBox.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            bubbleBox.heightAnchor.constraint(equalToConstant: bubbleHeight),
            bubbleBox.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -40),
            bubbleBox.leadingAnchor.constraint(equalTo: happyButton.trailingAnchor)
        ])

        view.addSubview(statsView)
        statsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statsView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -10),
            statsView.heightAnchor.constraint(equalToConstant: bubbleHeight),
            statsView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -bubbleHeight ),
            statsView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
        ])
   
        myCollectionView.register(mainCollectionViewCell.self, forCellWithReuseIdentifier: "mainCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.backgroundColor = UIColor.clear
        if let layout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        view.addSubview(myCollectionView)
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCollectionView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            myCollectionView.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
            myCollectionView.heightAnchor.constraint(equalTo: margins.widthAnchor),
            myCollectionView.widthAnchor.constraint(equalTo: margins.widthAnchor)
        ])
        
     
        
        confettiView = SAConfettiView()
                        // Create confetti view
                         confettiView = SAConfettiView(frame: self.view.bounds)
                         confettiView.colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
                                                      UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
                                                      UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
                                                      UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
                                                      UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
                               
                       // Set intensity (from 0 - 1, default intensity is 0.5)
                       confettiView.intensity = 0.9
                               
                       // Set type
                       confettiView.type = .diamond
                       //triangle,  star,  diamond
                       // For custom image
                       // confettiView.type = .Image(UIImage(named: "diamond")!)
                               
                       // Add subview
           view.addSubview(confettiView)
           confettiView.isHidden = !isRainingConfetti
      
    }
    
    ///MARK: Functions to communicate with the user
    
    func showMessage() {
        
        let happyUtterance = happySays()
        let logonCount = UserDefaults.standard.object(forKey: "loginRecord") as? [ Date ]
    
        let text = happyUtterance.identifyContext(foodName: nil, tryNumber: nil, logonNumber: logonCount?.count ?? 0 , screen: .mainScreen)
        let bubbleHeight = 0.3*(view.frame.height - view.frame.width - (myNav?.navigationBar.frame.height ?? 0 ) )
        let label =  bubbleLabel()
        
        label.numberOfLines = 0
        label.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 18)
        label.text = text
        label.textColor = UIColor(red: 3/255, green: 18/255, blue: 8/255, alpha: 1)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true

        label.layoutIfNeeded()
        label.sizeToFit()
        label.frame.size = CGSize(width: ceil(view.frame.width - bubbleHeight - 50),
                                  height: ceil(bubbleHeight))
        let bubbleSize = CGSize(width: label.frame.width + 10  ,
                                     height: label.frame.height + 20)

        let bubbleView = BubbleView()
        bubbleView.frame.size = bubbleSize
        bubbleView.backgroundColor = .clear
        
        bubbleBox.addSubview(bubbleView)
        label.center = bubbleView.center
        bubbleView.addSubview(label)
        
    }
    
    func displayStats(){
        
        var loginRecord = UserDefaults.standard.object(forKey: "loginRecord") as? [ Date ] ?? [ Date ]()
        var streak = 1
        var streaking = true
        var dateBefore = Date()
        
        while streaking == true
        {
            if loginRecord.count > 0
            {
                let nextDateToCheck = loginRecord.popLast()!
                if Calendar.current.isDate(dateBefore.addingTimeInterval(86400), inSameDayAs: nextDateToCheck) || Calendar.current.isDate(dateBefore, inSameDayAs: nextDateToCheck)
                {
                    loginRecord = loginRecord.dropLast()
                    dateBefore = nextDateToCheck
                    if Calendar.current.isDate(dateBefore.addingTimeInterval(86400), inSameDayAs: nextDateToCheck)
                    {
                        streak = streak + 1
                    }
                }
                else
                {
                    streaking = false
                }
            }
            else
            {
                streaking = false
            }
        }
        
        let label = UILabel()
        label.text = String(streak) + " Day Log In Streak!"
        label.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24)
        label.textColor = UIColor(red: 3/255, green: 18/255, blue: 8/255, alpha: 1)
        label.textAlignment = .right
        label.baselineAdjustment = .alignCenters
        
        //let constraintRect = statsView.frame.size
       // let boundingBox = text.boundingRect(with: constraintRect,
                                          //  options: .usesLineFragmentOrigin,
                                              //   attributes: [.font: label.font],
                                              //   context: nil)
       // label.frame.size = CGSize(width: ceil(boundingBox.width),
                                     //  height: ceil(boundingBox.height))
        statsView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: statsView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: statsView.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    // MARK: Animations
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
    
    //MARK: Data handling subroutines
        func loadItems(){
            let request : NSFetchRequest<Tried> = Tried.fetchRequest()
            do{
                try foodArray = context.fetch(request)
            }
            catch{
                print("Error fetching data \(error)")
            }
            
            let request2 : NSFetchRequest<Target> = Target.fetchRequest()
            do{
                try targetArray = context.fetch(request2)
            }
            catch{
                print("Error fetching data \(error)")
            }
            
            let request3 : NSFetchRequest<Logons> = Logons.fetchRequest()
                  do{
                      try logons = context.fetch(request3)
                  }
                  catch{
                      print("Error fetching data \(error)")
                  }
        }
    
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
        deleteAllData("Tried")
        foodArray = []
        
        DispatchQueue.main.async{
            self.myCollectionView.reloadData()
            self.myCollectionView.reloadInputViews()
        }
        /// reset markers
        let dateNow = Date().timeIntervalSince1970
        defaults.set(dateNow, forKey: "Last Week Started")
        defaults.set(false, forKey: "Celebration Status")
        myNav!.presentState = .ResetDataAtTheStartOfNewWeek
    }
    
    
    //MARK: programatic segues
    
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
    
    
    func launchExtraTutorial(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                let storyboard = UIStoryboard(name: "ExtraTutorial", bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "p0" ) as! secondTutorialPageViewController
                initialViewController.firstTry = true
                self.present(initialViewController, animated: true, completion: nil)
            }    }
    
    @objc func happyCoachingSegue(sender: UIButton!) {
         //performSegue(withIdentifier: "noTry", sender: self)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "dudeControlCentre")
        self.navigationController?.pushViewController(newViewController, animated: true)

     }
    
    @objc func addFood(sender: myButton!){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "newDataInputViewController" ) as! newDataInputViewController
        myNav?.pushViewController(nextViewController, animated: true)
       // let storyboard = UIStoryboard(name: "Main", bundle: nil)
       // let nextViewController = storyboard.instantiateViewController(withIdentifier: "newDataInputViewController" ) as! newDataInputViewController
       // self.present(nextViewController, animated: true, completion: nil)
        
    }
     @objc func goHistory() {
        //performSegue(withIdentifier: "historySegue", sender: UIButton())
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "historyScreen" ) as! historyTableViewController
        initialViewController.main = self
        self.present(initialViewController, animated: true, completion: nil)
       // print("History button pressed")
    }

     @objc func goStats() {
       // performSegue(withIdentifier: "statsSegue", sender: UIButton())
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "statsScreen" )
        self.present(initialViewController, animated: true, completion: nil)
       // print("Stats button pressed")
    }
    
    
}

extension newMainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: collectionView.bounds.size.width/4 - 8 , height: collectionView.bounds.size.width/4 - 8 )
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
         return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
     }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        
        
        return max(16, foodArray.count)
        
//        if foodArray.count + targetArray.count < 9
//        {
//            return 9
//        }
//        else
//        {
//            return foodArray.count + targetArray.count
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! mainCollectionViewCell
//        let label = UILabel()
//        label.text = "Hello"
//        cell.addSubview(label)
        
//        let expandDetailButton = UIButton(frame: CGRect(x:0, y:0, width:      cell.frame.width,height:cell.frame.height))
//        //editButton.setImage(UIImage(named: "editButton.png"), for: UIControlState.normal)
//        editButton.tag = indexPath.row
//        editButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
//        cell.addSubview(editButton)
        cell.backgroundColor = UIColor(red: 103/255, green: 228/255, blue: 154/255, alpha: 1)
        cell.instructionReminder.removeTarget(self, action: nil, for: .allEvents)
        cell.cellLabel.text = ""
        cell.cellLabel.isHidden = true
        
       var collectionViewSize = 16
            

            if foodArray.count  > 15
            {
                collectionViewSize = foodArray.count + 1
            }
            else{
                if indexPath.row >= foodArray.count{
                   // cell.cellLabel.text = "+"
                   // cell.cellLabel.isHidden = false
                print(indexPath.row)
                    switch indexPath.row{
                        case 15:
                            cell.cellLabel.text = "+"
                            cell.instructionReminder.addTarget(self, action: #selector(addFood), for: .touchUpInside)
                            cell.cellLabel.isHidden = false
                        case 3:
//                            cell.cellLabel.text = "How will this app help me?"
//                            ///
//                            cell.cellLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
//                            cell.cellLabel.isHidden = false
                                cell.backgroundColor = UIColor.clear
                                cell.cellImage.isHidden = false
                                //cell.displayContent(image: "button_labels.001.jpeg")
                                cell.cellImage.image = UIImage(named: "button_labels.001.jpeg")
                                cell.layer.borderWidth = 2.0
                                cell.layer.borderColor = UIColor(red: 103/255, green: 228/255, blue: 154/255, alpha: 1).cgColor
                                cell.instructionReminder.addTarget(self, action: #selector(info), for: .touchUpInside)
                        case 6:
//                            cell.cellLabel.text = "Hold my hand - I'm gonna try something"
//                            cell.cellLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
//                            cell.cellLabel.isHidden = false
                                cell.backgroundColor = UIColor.clear
                                cell.cellImage.isHidden = false
                                cell.displayContent(image: "button_labels.002.jpeg")
                                cell.layer.borderWidth = 2.0
                                cell.layer.borderColor = UIColor(red: 103/255, green: 228/255, blue: 154/255, alpha: 1).cgColor
                                cell.instructionReminder.addTarget(self, action: #selector(trying), for: .touchUpInside)
                        case 9:
//                            cell.cellLabel.text = "I'm feeling down"
//                            cell.cellLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
//                            cell.cellLabel.isHidden = false
                                cell.backgroundColor = UIColor.clear
                                cell.cellImage.isHidden = false
                                cell.displayContent(image: "button_labels.003.jpeg")
                                cell.layer.borderWidth = 2.0
                                cell.layer.borderColor = UIColor(red: 103/255, green: 228/255, blue: 154/255, alpha: 1).cgColor
                        cell.instructionReminder.addTarget(self, action: #selector(motivate), for: .touchUpInside)
                        case 12:
//                            cell.cellLabel.text = "Gimme a target! "
//                            cell.cellLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
//                            cell.cellLabel.isHidden = false
                                cell.backgroundColor = UIColor.clear
                                cell.cellImage.isHidden = false
                                cell.displayContent(image: "button_labels.004.jpeg")
                                cell.layer.borderWidth = 2.0
                                cell.layer.borderColor = UIColor(red: 103/255, green: 228/255, blue: 154/255, alpha: 1).cgColor
                        cell.instructionReminder.addTarget(self, action: #selector(noTry), for: .touchUpInside)
                        case 14:
//                            cell.cellLabel.text = "Fun challenge!"
//                            cell.cellLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
//                            cell.cellLabel.isHidden = false
                                cell.backgroundColor = UIColor.clear
                                cell.cellImage.isHidden = false
                                cell.displayContent(image: "button_labels.005.jpeg")
                                cell.layer.borderWidth = 2.0
                                cell.layer.borderColor = UIColor(red: 103/255, green: 228/255, blue: 154/255, alpha: 1).cgColor
                                cell.instructionReminder.addTarget(self, action: #selector(play), for: .touchUpInside)
                        default:
                            cell.instructionReminder.titleLabel!.text = ""
                            cell.instructionReminder.addTarget(self, action: #selector(addFood), for: .touchUpInside)
                            cell.cellImage.isHidden = true
                   }
                }
            }
        
            if foodArray != nil {
                    if indexPath.row < foodArray.count {
                        cell.backgroundColor = UIColor.clear
                        cell.cellImage.isHidden = false
                      //  cell.cellImage.alpha = 1
                        let plate = foodArray[indexPath.row]
                        let fileToLoad = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(plate.filename ?? "1.png")
                        //cell.cellImage.image = UIImage(named: "1.png")
                        cell.displayContent(image: fileToLoad)
//
//                        let expandDetailButton = UIButton(frame: CGRect(x:0, y:0, width:cell.frame.width,height:cell.frame.width))
//                         //editButton.setImage(UIImage(named: "editButton.png"), for: UIControlState.normal)
//
//                        /// alter this if i have uneven filling
//                        expandDetailButton.tag = indexPath.row
//                        expandDetailButton.addTarget(self, action: #selector(expandDetailButtonTapped), for: .touchUpInside)
//                        cell.addSubview(expandDetailButton)
//
                        cell.instructionReminder.tag = indexPath.row
    
                        cell.instructionReminder.addTarget(self, action: #selector(expandDetailButtonTapped), for: .touchUpInside)
                    }
                    else
                    {
                      ///  cell.cellImage.isHidden = true
//                        cell.instructionReminder.addTarget(self, action: #selector(addFood), for: .touchUpInside)
//                          if indexPath.row == 15{
//                            cell.instructionReminder.titleLabel!.text = "+"
//                            cell.instructionReminder.titleLabel?.tintColor = #colorLiteral(red: 0.05645794421, green: 0.001110887388, blue: 0, alpha: 1)
//                            cell.backgroundColor?.withAlphaComponent(0.5)
//                                      }
                        

                    }
                }
        
//        /// move this to main thread
//        if indexPath.row == 15{
//            let cellHeaight = cell.frame.height
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: cellHeaight, height: cellHeaight))
//                           //label.frame = cell.frame
//                           label.text = "+"
//            label.textAlignment = .center
//            label.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 60 )
//                            label.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            
//                           label.alpha = 0.6
//                           cell.addSubview(label)
//                       }

        return cell
        }
    
    @objc func expandDetailButtonTapped(sender: UIButton){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "detailVC" ) as! DetailViewController
        let buttonTag = sender.tag
        detailViewController.detailToDisplay.photoFilename = foodArray[buttonTag].filename ?? "chaos.jpg"
        detailViewController.detailToDisplay.foodName = foodArray[buttonTag].name ?? ""
        detailViewController.detailToDisplay.rating = foodArray[buttonTag].rating
        detailViewController.detailToDisplay.triedOn = foodArray[buttonTag].date!
        detailViewController.detailToDisplay.notes = foodArray[buttonTag].notes ?? " "
        detailViewController.presentState = "AddFoodViewController"
        myNav?.presentState = .AddFoodViewController

        myNav?.pushViewController(detailViewController, animated: true)
       // present(detailViewController, animated: true, completion: nil)
  
                
    }
    
        func showFeedbackDialog() {
            //Creating UIAlertController and
            //Setting title and message for the alert dialog
            let alertController = UIAlertController(title: "Can you give us some feedback?", message: "It really helps us to get the product right for you and for future users.", preferredStyle: .alert)
            
            //the confirm action taking the inputs
            let confirmAction = UIAlertAction(title: "Email feedback", style: .default) { (_) in
                
                //getting the input values from user
                let thisBestThingAboutThisAppIs = alertController.textFields?[0].text
                let theMostFrustratungThingAboutThisAppIs = alertController.textFields?[1].text
                let iWishThisAppDid = alertController.textFields?[2].text
                ///let email = alertController.textFields?[1].text
                self.sendEmail(thisBestThingAboutThisAppIs: thisBestThingAboutThisAppIs, theMostFrustratungThingAboutThisAppIs: theMostFrustratungThingAboutThisAppIs, iWishThisAppDid: iWishThisAppDid)
              ///  self.labelMessage.text = "Name: " + name! + "Email: " + email!
                
            }
            
            //the cancel action doing nothing
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            
            //adding textfields to our dialog box
            alertController.addTextField { (textField) in
                textField.placeholder = "Best Thing About This App Is"
            }
            alertController.addTextField { (textField) in
                textField.placeholder = "Most Frustrating Thing Is"
            }
            alertController.addTextField { (textField) in
                textField.placeholder = "I Wish This App Could "
            }
            
            //adding the action to dialogbox
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            //finally presenting the dialog box
            self.present(alertController, animated: true, completion: nil)
        }
    
            @objc func trying(sender: UIButton!) {
                //performSegue(withIdentifier: "reTry", sender: self)
                let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
                                               let initialViewController = storyboard.instantiateViewController(withIdentifier: "reTry" )
                                               self.present(initialViewController, animated: false, completion: nil)
            }
            
            
            @objc func noTry(sender: UIButton!) {
                //performSegue(withIdentifier: "reNoTry", sender: self)
                let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
                                let initialViewController = storyboard.instantiateViewController(withIdentifier: "reNoTry" )
                                self.present(initialViewController, animated: false, completion: nil)
            }
        
            @objc func info(sender: UIButton!) {
                  let storyboard = UIStoryboard(name: "ExtraTutorial", bundle: nil)
                  let initialViewController = storyboard.instantiateViewController(withIdentifier: "p0" )
                  self.present(initialViewController, animated: false, completion: nil)
            }
              
            @objc func motivate(sender: UIButton!) {
                 // performSegue(withIdentifier: "motivate", sender: self)
                let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "resources" )
                self.present(initialViewController, animated: false, completion: nil)
            }
        
            @objc func settings(sender: UIButton!) {
                     performSegue(withIdentifier: "settingSegue", sender: self)
            }
        
            @objc func play(sender: UIButton!) {
                let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
                              let initialViewController = storyboard.instantiateViewController(withIdentifier: "play" )
                              self.present(initialViewController, animated: false, completion: nil)
            }
        

}

extension newMainViewController : MFMailComposeViewControllerDelegate{
    
    func sendEmail(thisBestThingAboutThisAppIs: String?, theMostFrustratungThingAboutThisAppIs: String?, iWishThisAppDid: String?) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["kate@saltformysquid.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
