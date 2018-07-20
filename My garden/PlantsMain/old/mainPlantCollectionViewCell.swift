//
//  mainPlantCollectionViewCell.swift
//  My garden
//
//  Created by Александр Филимонов on 15/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

class mainPlantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        image.layer.cornerRadius = 15.0
    }
    
}
