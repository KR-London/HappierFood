import UIKit

class newMainViewController: UIViewController {
    
    /// declare my blocks
    
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
        collection.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return collection
    }()
    
    /// stats view
    lazy var statsView: UIView = {
        let stats = UIView()
        stats.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        return stats
    }()
    
    /// add fodd button
    
    lazy var addFoodButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubview()
        showMessage(text: "HELLO, MY NAME IS HAPPY")
        // Do any additional setup after loading the view.
    }
    
    //MARK: Layout subroutines
    func setUpSubview(){
        let margins = view.layoutMarginsGuide
        let myNav = self.navigationController
        
        let bubbleHeight = 0.25*(view.frame.height - view.frame.width - (myNav?.navigationBar.frame.height ?? 0 ) )
        
        view.addSubview(happyButton)
        happyButton.translatesAutoresizingMaskIntoConstraints = false
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
        NSLayoutConstraint.activate([
            addFoodButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            addFoodButton.heightAnchor.constraint(equalToConstant: bubbleHeight),
            addFoodButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            addFoodButton.widthAnchor.constraint(equalToConstant: bubbleHeight)
        ])

        view.addSubview(statsView)
        statsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statsView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            statsView.heightAnchor.constraint(equalToConstant: bubbleHeight),
            statsView.trailingAnchor.constraint(equalTo: addFoodButton.leadingAnchor),
            statsView.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        ])
        
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
        label.textColor = .white
        label.text = text

        let constraintRect = bubbleBox.frame.size
            //CGSize(width: 0.66 * bubbleBox.frame.width,
                                  //  height: .greatestFiniteMagnitude)
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
        //ubbleView.center = bubbleBox.center
       // bubbleView.leftAnchor = bubbleBox.leftAnchor
        
        bubbleBox.addSubview(bubbleView)
        bubbleView.translatesAutoresizingMaskIntoConstraints = true
        
//        NSLayoutConstraint.activate([
//              bubbleView.centerXAnchor.constraint(equalTo: bubbleBox.centerXAnchor),
//              bubbleView.centerYAnchor.constraint(equalTo: bubbleBox.centerYAnchor),
//              bubbleView.leadingAnchor.constraint(equalTo: bubbleBox.leadingAnchor)
//          ])
        

        label.center = bubbleView.center
        bubbleView.addSubview(label)
    }
}

