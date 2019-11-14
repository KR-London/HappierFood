import UIKit
import Foundation
import Darwin
import CoreData

let defaults = UserDefaults.standard

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
    var foodArray: [TriedFood]!
    var targetArray: [TargetFood]!
    var logons: [Logons]!
    
    unowned var myNav : customNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            //  self.present(nextViewController, animated: true, completion: nil)
        
        setUpSubview()
        
        showMessage(text: "HELLO, MY NAME IS HAPPY HELLO, MY NAME IS HAPPY HELLO, MY NAME IS HAPPY")
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
        view.backgroundColor = UIColor(red: 251/255, green: 254/255, blue: 252/255, alpha: 1)
        let datafilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        //print(datafilepath!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
      ////  self.mainCollectionView.reloadInputViews()
        //happyIcon()
        
        switch myNav!.presentState
        {
            case .FirstLaunch : print("In first launch.")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                           
                               let storyboard = UIStoryboard(name: "ExtraTutorial", bundle: nil)
                               let initialViewController = storyboard.instantiateViewController(withIdentifier: "p1" )
                               self.present(initialViewController, animated: true, completion: nil)
                           }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
                
                    let storyboard = UIStoryboard(name: "ExtraTutorial", bundle: nil)
                    let initialViewController = storyboard.instantiateViewController(withIdentifier: "p2" )
                    self.present(initialViewController, animated: true, completion: nil)
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

            let navBarHeight = navigationController?.navigationBar.frame.height
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Stats", style: .plain, target: self, action: #selector(goStats))
            
            let historyButton = UIButton(type: .system)
            historyButton.setImage(UIImage(named: "appleHistory")?.resize(to: CGSize(width: 0.55*(navBarHeight ?? 100),height: 0.55*(navBarHeight ?? 100) )), for: .normal)
            historyButton.addTarget(self, action: #selector(goHistory), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: historyButton)
        }
    
    func setUpSubview(){
        let margins = view.layoutMarginsGuide
        let myNav = self.navigationController
        
        let bubbleHeight = 0.25*(view.frame.height - view.frame.width - (myNav?.navigationBar.frame.height ?? 0 ) )
        
        view.addSubview(happyButton)
        happyButton.translatesAutoresizingMaskIntoConstraints = false
        happyButton.addTarget(self, action: #selector(happyCoachingSegue), for: .touchUpInside)
        NSLayoutConstraint.activate([
            happyButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            happyButton.heightAnchor.constraint(equalToConstant: bubbleHeight),
            happyButton.widthAnchor.constraint(equalToConstant: bubbleHeight),
            happyButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        ])
        
        view.addSubview(bubbleBox)
        bubbleBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bubbleBox.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            bubbleBox.heightAnchor.constraint(equalToConstant: bubbleHeight),
            bubbleBox.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10),
            bubbleBox.leadingAnchor.constraint(equalTo: happyButton.trailingAnchor)
        ])
        
        view.addSubview(addFoodButton)
        addFoodButton.translatesAutoresizingMaskIntoConstraints = false
        addFoodButton.addTarget(self, action: #selector(addFood), for: .touchUpInside)
        NSLayoutConstraint.activate([
            addFoodButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -10),
            addFoodButton.heightAnchor.constraint(equalToConstant: bubbleHeight),
            addFoodButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            addFoodButton.widthAnchor.constraint(equalToConstant: bubbleHeight)
        ])

        view.addSubview(statsView)
        statsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statsView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -10),
            statsView.heightAnchor.constraint(equalToConstant: bubbleHeight),
            statsView.trailingAnchor.constraint(equalTo: addFoodButton.leadingAnchor),
            statsView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
        ])
        
        myCollectionView.register(mainCollectionViewCell.self, forCellWithReuseIdentifier: "mainCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.backgroundColor = UIColor.clear
        view.addSubview(myCollectionView)
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCollectionView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            myCollectionView.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
            myCollectionView.heightAnchor.constraint(equalTo: margins.widthAnchor),
            myCollectionView.widthAnchor.constraint(equalTo: margins.widthAnchor)
        ])
    }
    
    ///MARK: Functions to communicate with the user
    
    func showMessage(text: String) {
        
       let bubbleHeight = 0.25*(view.frame.height - view.frame.width - (myNav?.navigationBar.frame.height ?? 0 ) )
        let label =  UILabel()
        
        label.numberOfLines = 0
        label.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24)
        label.text = text
        label.layoutIfNeeded()
        label.sizeToFit()

        let constraintRect = bubbleBox.frame.size
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: label.font],
                                            context: nil)
        label.frame.size = CGSize(width: ceil(view.frame.width - bubbleHeight - 30),
                                  height: ceil(bubbleHeight))

        let bubbleSize = CGSize(width: label.frame.width + 28,
                                     height: label.frame.height + 20)

        let bubbleView = BubbleView()
        bubbleView.frame.size = bubbleSize
        bubbleView.backgroundColor = .clear
        
        bubbleBox.addSubview(bubbleView)
        

        label.center = bubbleView.center
        bubbleView.addSubview(label)
        
        bubbleView.translatesAutoresizingMaskIntoConstraints = true
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: statsView.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: statsView.centerYAnchor)
//           ])
        
        
    }
    
    func displayStats(){
        
        var loginRecord = UserDefaults.standard.object(forKey: "loginRecord") as? [ Date ] ?? [ Date ]()
        
        var text = String()
        var streak = 1
        var streaking = true
        var dateBefore = Date()
        
        while streaking == true
        {
            if loginRecord.count > 0
            {
                let nextDateToCheck = loginRecord.popLast()!
                if Calendar.current.isDate(dateBefore.addingTimeInterval(86400), inSameDayAs: nextDateToCheck)
                {
                    loginRecord = loginRecord.dropLast()
                    streak = streak + 1
                    dateBefore = nextDateToCheck
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
        label.text = String(streak) + " Day Logon Streak!"
        label.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24)
      
        label.textColor = UIColor(red: 3/255, green: 18/255, blue: 8/255, alpha: 1)

        label.textAlignment = .center
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
    
    //MARK: Data handling subroutines
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
        deleteAllData("TriedFood")
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
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "p2" )
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
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "historyScreen" )
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
    
        
        
        return 9
        
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
        
        cell.backgroundColor = UIColor(red: 103/255, green: 228/255, blue: 154/255, alpha: 1)
        
        var collectionViewSize = 9
            
            if foodArray.count  > 9
            {
                collectionViewSize = foodArray.count
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
                    
                    }
                    else
                    {
                        cell.cellImage.isHidden = true

                    }
                }

        return cell
        }
}
