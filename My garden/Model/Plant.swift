//
//  Plant.swift
//  My garden
//
//  Created by Александр Филимонов on 15/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

@objcMembers
class Plant: Object {
    
    dynamic var name = ""
    dynamic var sort = ""
    dynamic var scedule = ""
    dynamic var waterTime = 0
    dynamic var timesOfWatering = 0
    dynamic var lastWatered = Date()
    
    var images: Results<PlantImage>? {
        return realm?.objects(PlantImage.self).filter(NSPredicate(format: "owner == %@", self))
    }
    
    static func getPlantObject(name: String, sort: String, scedule: String, waterTime: Int, timesOfWatering: Int, lastWatered: Date) -> Plant {
        let plant = Plant()
        plant.name = name
        plant.sort = sort
        plant.scedule = scedule
        plant.waterTime = waterTime
        plant.timesOfWatering = timesOfWatering
        plant.lastWatered = lastWatered
        return plant
    }
    
}
