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
    
    func waterToday(plant: Plant) {
        
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
    
    func save(photo: UIImage, for plant: Plant) -> Bool {
        if let imageData = UIImageJPEGRepresentation(photo, 0.9) {
            let customImage = PlantImage.getPlantImage(image: imageData, owner: plant, date: Date())
            
            
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
    
    func getAllPlants() -> [Plant] {
        var plants: [Plant] = []
        
        let realmInsance = try! Realm()
        for plant in realmInsance.objects(Plant.self).sorted(byKeyPath: "birthDay") {
            plants.append(plant)
        }
        
        return plants
    }
    
    func getAllPlantsSortByDate() -> [Plant] {
        var plants: [Plant] = []
        
        let realmInsance = try! Realm()
        for plant in realmInsance.objects(Plant.self).sorted(byKeyPath: "nextWatering") {
            plants.append(plant)
        }
        
        return plants
    }
    
    func getImages(of plant: Plant) -> [UIImage] {

        var images: [UIImage] = []

        guard let plantImages = plant.images else { return [] }
        for imageObject in Array(plantImages.sorted(byKeyPath: "date")).reversed() {
            // print(UIImage(data: imageObject.image))
            if let image = UIImage(data: imageObject.image) {
                images.append(image)
            }
        }

        return images
    }
    
    func getMainImage(of plant: Plant) -> UIImage? {
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
