//
//  DB.swift
//  My garden
//
//  Created by Александр Филимонов on 20/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class DB {
    
    static let shared = DB()
    
    // MARK: - Methods
    
    func waterToday(plant: PlantEntity) {
        
        let curScedule = Scedule(str: plant.scedule)
        let lastWatering = Date()
        var nextWatering: Date
        
        switch curScedule.sceduleDWM {
        case .day:
            nextWatering = Calendar.current.date(byAdding: .day, value: curScedule.count, to: lastWatering)!
        case .week:
            nextWatering = Calendar.current.date(byAdding: .weekOfMonth, value: curScedule.count, to: lastWatering)!
        case .month:
            nextWatering = Calendar.current.date(byAdding: .month, value: curScedule.count, to: lastWatering)!
        }
        
        let realmInstatce = try! Realm()
        try! realmInstatce.write {
            plant.lastWatering = lastWatering
            plant.timesOfWatering += 1
            plant.nextWatering = nextWatering
        }
    }
    
    func editPlant(plant: PlantEntity, name: String, sort: String, birthDay: Date, waterTime: Int, scedule: String) -> Bool {
        
        do {
            var nextWatering = Date()
            if plant.scedule == scedule {
                nextWatering = plant.nextWatering
            } else {
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
                nextWatering = Calendar.current.date(byAdding: curComponent, to: Date())!
            }
            
            
            
            let realmInstatce = try Realm()
            try realmInstatce.write {
                plant.name = name
                plant.sort = sort
                plant.birthDay = birthDay
                plant.waterTime = waterTime
                plant.scedule = scedule
                plant.nextWatering = nextWatering
            }
            return true
        } catch {
            return false
        }
    }
    
    func save(photo: UIImage, for plant: PlantEntity) -> Bool {
        if let imageData = UIImageJPEGRepresentation(photo, 0.9) {
            let customImage = PlantImageEntity.getPlantImageEntity(image: imageData, owner: plant, date: Date())
            
            
            do {
                let realmInstatce = try Realm()
                try realmInstatce.write {
                    realmInstatce.add(customImage)
                }
                return true
            } catch {
                return false
            }
        } else {
            return false
        }
        
    }
    
    func getAllPlants() -> [PlantEntity] {
        var plants: [PlantEntity] = []
        
        let realmInsance = try! Realm()
        for plant in realmInsance.objects(PlantEntity.self).sorted(byKeyPath: "birthDay") {
            plants.append(plant)
        }
        
        return plants
    }
    
    func getAllPlantsSortByDate() -> [PlantEntity] {
        var plants: [PlantEntity] = []
        
        let realmInsance = try! Realm()
        for plant in realmInsance.objects(PlantEntity.self).sorted(byKeyPath: "nextWatering") {
            plants.append(plant)
        }
        
        return plants
    }
    
    func getImages(of plant: PlantEntity) -> [PlantImageEntity] {

        var images: [PlantImageEntity] = []

        guard let plantImages = plant.images else { return [] }
        for imageObject in Array(plantImages.sorted(byKeyPath: "date")).reversed() {
            // print(UIImage(data: imageObject.image))
            images.append(imageObject)
        }

        return images
    }
    
    func getMainImage(of plant: PlantEntity) -> UIImage? {
        guard let plantImages = plant.images else { return nil }
        for imageObject in Array(plantImages.sorted(byKeyPath: "date")) {
            // print(UIImage(data: imageObject.image))
            if let image = UIImage(data: imageObject.image) {
                return image
            }
        }
        
        return nil
    }
    
}
