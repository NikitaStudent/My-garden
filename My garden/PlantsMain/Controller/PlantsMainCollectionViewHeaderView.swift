//
//  PlantsMainCollectionViewHeaderView.swift
//  My garden
//
//  Created by Александр Филимонов on 15/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

class PlantsMainCollectionViewHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var waterCollectionView: UICollectionView!
    
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addButton.layer.cornerRadius = 18.0
    }
    
}
