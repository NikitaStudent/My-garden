//
//  WaterTodayCell.swift
//  My garden
//
//  Created by Александр Филимонов on 19/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

class WaterTodayCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var colorLabel: PaddingLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        image.layer.cornerRadius = 10.0
        colorLabel.layer.cornerRadius = colorLabel.frame.height / 2
    }
    
    public func configure(image: UIImage, title: String, colorLabelString: String?) {
        if let colorLabelString = colorLabelString {
            colorLabel.isHidden = false
            colorLabel.text = colorLabelString
        } else {
            colorLabel.isHidden = true
        }
        self.image.image = image
        self.title.text = title
    }

}
