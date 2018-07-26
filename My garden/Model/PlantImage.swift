//
//  PlantImage.swift
//  My garden
//
//  Created by Александр Филимонов on 20/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import Foundation
import UIKit

class PlantImage {
    
    let id: Int
    var image: UIImage
    var date: Date
    
    init(id: Int, image: UIImage, date: Date) {
        self.id = id
        self.image = image
        self.date = date
    }
    
    init(by plantImageEntity: PlantImageEntity) {
        self.id = plantImageEntity.id
        self.image = UIImage(data: plantImageEntity.image)!
        self.date = plantImageEntity.date
    }
    
}
