//
//  TableViewCell.swift
//  HappierFoods
//
//  Created by Kate Roberts on 30/10/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class statsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageForStat: UIImageView!
    @IBOutlet weak var titleOfStatistic: UILabel!
    @IBOutlet weak var valueOfStatistic: UILabel!
    
    
    public func displayContent(image: String){
        imageForStat.image = UIImage(named: image)
        //imageForStat.layer.cornerRadius = 5.0
        imageForStat.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setup()
    }
    
    func setup(){
        //cellImage.image
        self.layer.borderWidth = 1.0
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
       // self.layer.cornerRadius = 5.0
      // self.imageForStat.layer.cornerRadius = 5.0
    
            
        //self.backgroundColor = UIColor(red: 186/255, green: 242/255, blue: 206/255, alpha: 0.8) 
        self.layer.cornerRadius = 5.0
        
        //self.imageForStat.translatesAutoresizingMaskIntoConstraints = false
//self.imageForStat.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }

}
