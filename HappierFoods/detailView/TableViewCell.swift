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
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        self.layer.cornerRadius = 5.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }

}
