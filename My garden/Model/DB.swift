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
    
    func getAllPlants() -> [Plant] {
        var plants: [Plant] = []
        
        let realmInsance = try! Realm()
        for plant in realmInsance.objects(Plant.self) {
            plants.append(plant)
        }
        
        return plants
    }
    
    func getImages(of plant: Plant) -> [UIImage] {
//        guard let plantId = Plant.primaryKey() as? Int else { return [] }

        var images: [UIImage] = []

        guard let plantImages = plant.images else { return [] }
        for imageObject in Array(plantImages) {
            // print(UIImage(data: imageObject.image))
            if let image = UIImage(data: imageObject.image) {
                images.append(image)
            }
        }

        return images
    }
    
}
