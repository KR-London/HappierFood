import UIKit
import Foundation
import Darwin
import CoreData

class newMainViewController: UIViewController {
    

    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubview()
        showMessage(text: "HELLO, MY NAME IS HAPPY")
        displayStats(text: "3 login streak!")
        // Do any additional setup after loading the view.
    }
    
    //MARK: Layout subroutines
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
            bubbleBox.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
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
        myCollectionView.dataSource = self as! UICollectionViewDataSource
        //myCollectionView.backgroundColor = UIColor.cyan
        view.addSubview(myCollectionView)
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCollectionView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            myCollectionView.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
            myCollectionView.heightAnchor.constraint(equalTo: margins.widthAnchor),
            myCollectionView.widthAnchor.constraint(equalTo: margins.widthAnchor)
        ])
    }
    func showMessage(text: String) {
        let label =  UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        //label.textColor = .white
        label.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24)
        label.text = text

        let constraintRect = bubbleBox.frame.size
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: label.font],
                                            context: nil)
        label.frame.size = CGSize(width: ceil(boundingBox.width),
                                  height: ceil(boundingBox.height))

        let bubbleSize = CGSize(width: label.frame.width + 28,
                                     height: label.frame.height + 20)

        let bubbleView = BubbleView()
        bubbleView.frame.size = bubbleSize
        bubbleView.backgroundColor = .clear
        
        bubbleBox.addSubview(bubbleView)
        bubbleView.translatesAutoresizingMaskIntoConstraints = true

        label.center = bubbleView.center
        bubbleView.addSubview(label)
    }
    
    func displayStats(text: String){
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24)
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
            label.centerYAnchor.constraint(equalTo: statsView.centerYAnchor)
               ])
    }
    
    @objc func happyCoachingSegue(sender: UIButton!) {
         //performSegue(withIdentifier: "noTry", sender: self)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "dudeControlCentre")
        self.navigationController?.pushViewController(newViewController, animated: true)

     }
    
    @objc func addFood(sender: myButton!){
        print("Plus button pressed")
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
        cell.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        cell.cellImage!.image = UIImage(named: "chaos.jpg")
        return cell
        }
}
