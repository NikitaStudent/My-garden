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
    dynamic var destination: String? = nil
    dynamic var about: String? = nil
    dynamic var sort = ""
    dynamic var scedule = ""
    dynamic var waterTime = 0
    dynamic var timesOfWatering = 0
    dynamic var lastWatering = Date()
    dynamic var nextWatering = Date()
    dynamic var birthDay = Date()
    
    var images: Results<PlantImage>? {
        return realm?.objects(PlantImage.self).filter(NSPredicate(format: "owner == %@", self))
    }
    
    static func getPlantObject(name: String, sort: String, scedule: String, waterTime: Int, timesOfWatering: Int, lastWatering: Date, nextWatering: Date) -> Plant {
        let plant = Plant()
        
        plant.name = name
        plant.sort = sort
        plant.scedule = scedule
        plant.waterTime = waterTime
        plant.timesOfWatering = timesOfWatering
        plant.lastWatering = lastWatering
        plant.birthDay = Calendar.current.date(byAdding: .day, value: -10, to: Date())!
        plant.nextWatering = nextWatering
        
        return plant
    }
    
}
