//
//  certificateViewController.swift
//  
//
//  Created by Kate Roberts on 16/10/2019.
//

import UIKit

class certificateViewController: UIViewController {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDate = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yyyy"

        date.text = formatter.string(from: currentDate)
        message.text = "You're doing great!"
    }
    

}
