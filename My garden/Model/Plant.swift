//
//  Plant.swift
//  My garden
//
//  Created by Александр Филимонов on 15/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import Foundation
import RealmSwift

class Plant {
    
    let id: Int
    var name: String
    var destination: String?
    var about: String?
    var sort: String
    var scedule: String
    var waterTime: Int // 0 or 1
    var timesOfWatering: Int
    var lastWatering: Date
    var nextWatering: Date
    var birthDay: Date
    var images: [PlantImage] = []
    
    init(id: Int, name: String, destination: String?, about: String?, sort: String, scedule: String, waterTime: Int, timesOfWatering: Int, lastWatering: Date, nextWatering: Date, birthDay: Date, images: [PlantImage]) {
        self.id = id
        self.name = name
        self.destination = destination
        self.about = about
        self.sort = sort
        self.scedule = scedule
        self.waterTime = waterTime
        self.timesOfWatering = timesOfWatering
        self.lastWatering = lastWatering
        self.nextWatering = nextWatering
        self.birthDay = birthDay
        
        self.images = images
    }
    
    init(by id: Int) {
        let realmInsance = try! Realm()
        let plantEntity =  realmInsance.objects(PlantEntity.self).filter(NSPredicate(format: "id = %@", id)).first!
        
        self.id = plantEntity.id
        self.name = plantEntity.name
        self.destination = plantEntity.destination
        self.about = plantEntity.about
        self.sort = plantEntity.sort
        self.scedule = plantEntity.scedule
        self.waterTime = plantEntity.waterTime
        self.timesOfWatering = plantEntity.timesOfWatering
        self.lastWatering = plantEntity.lastWatering
        self.nextWatering = plantEntity.nextWatering
        self.birthDay = plantEntity.birthDay
        
        self.images = DB.shared.getImages(of: plantEntity).map { PlantImage(by: $0) }
    }
    
    init(by plantEntity: PlantEntity) {
        self.id = plantEntity.id
        self.name = plantEntity.name
        self.destination = plantEntity.destination
        self.about = plantEntity.about
        self.sort = plantEntity.sort
        self.scedule = plantEntity.scedule
        self.waterTime = plantEntity.waterTime
        self.timesOfWatering = plantEntity.timesOfWatering
        self.lastWatering = plantEntity.lastWatering
        self.nextWatering = plantEntity.nextWatering
        self.birthDay = plantEntity.birthDay
        
        self.images = DB.shared.getImages(of: plantEntity).map { PlantImage(by: $0) }
    }
    
    func getAllPlants() -> [Plant] {
        var plantsEntity: [PlantEntity] = []
        var plants: [Plant] = []
        
        let realmInsance = try! Realm()
        for plant in realmInsance.objects(PlantEntity.self).sorted(byKeyPath: "birthDay") {
            plantsEntity.append(plant)
        }
        
        for plantEntity in plantsEntity {
            let curPlant = Plant(by: plantEntity)
            plants.append(curPlant)
        }
        
        return plants
    }
    
}
