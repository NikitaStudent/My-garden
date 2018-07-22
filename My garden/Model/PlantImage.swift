//
//  PlantImage.swift
//  My garden
//
//  Created by Александр Филимонов on 20/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

@objcMembers
class PlantImage: Object {
    
    dynamic var image = Data()
    dynamic var owner: Plant?
    dynamic var date = Date()
    
    static func getPlantImage(image: Data, owner: Plant?, date: Date) -> PlantImage {
        let plantImage = PlantImage()
        plantImage.image = image
        plantImage.owner = owner
        plantImage.date = date
        return plantImage
    }
    
}

