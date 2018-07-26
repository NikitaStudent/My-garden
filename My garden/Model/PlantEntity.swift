//
//  PlantEntity.swift
//  My garden
//
//  Created by Александр Филимонов on 26/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import Foundation

import UIKit
import RealmSwift

@objcMembers
class PlantEntity: Object {
    
    dynamic var id = 0
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
    
    var images: Results<PlantImageEntity>? {
        return realm?.objects(PlantImageEntity.self).filter(NSPredicate(format: "owner == %@", self))
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(PlantEntity.self).max(ofProperty: "id") as Int? ?? 0) + 2
    }

    
    static func getPlantObject(name: String, sort: String, scedule: String, waterTime: Int, timesOfWatering: Int, birthDay: Date) -> PlantEntity {
        let plant = PlantEntity()
        
        let sceduleObj = Scedule(str: scedule)
        var curComponent = DateComponents()
        switch sceduleObj.sceduleDWM {
        case .day:
            curComponent.day = sceduleObj.count
        case .week:
            curComponent.weekOfMonth = sceduleObj.count
        case .month:
            curComponent.month = sceduleObj.count
        }
        let nextWatering = Calendar.current.date(byAdding: curComponent, to: Date())!
        
        plant.id = incrementID()
        plant.name = name
        plant.sort = sort
        plant.scedule = scedule
        plant.waterTime = waterTime
        plant.timesOfWatering = timesOfWatering
        plant.lastWatering = Date()
        plant.birthDay = birthDay
        plant.nextWatering = nextWatering
        
        return plant
    }
    
    static func getPlantObject(name: String, sort: String, scedule: String, waterTime: Int, timesOfWatering: Int, birthDay: Date, nextWatering: Date) -> PlantEntity {
        let plant = PlantEntity()
        
        plant.name = name
        plant.sort = sort
        plant.scedule = scedule
        plant.waterTime = waterTime
        plant.timesOfWatering = timesOfWatering
        plant.lastWatering = Date()
        plant.birthDay = birthDay
        plant.nextWatering = nextWatering
        
        return plant
    }
    
}
