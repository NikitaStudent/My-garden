//
//  PlantImageEntity.swift
//  My garden
//
//  Created by Александр Филимонов on 26/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

@objcMembers
class PlantImageEntity: Object {
    
    dynamic var id = 0
    dynamic var image = Data()
    dynamic var owner: PlantEntity?
    dynamic var date = Date()
    
    static func getPlantImageEntity(image: Data, owner: PlantEntity?, date: Date) -> PlantImageEntity {
        let plantImage = PlantImageEntity()
        plantImage.id = incrementID()
        plantImage.image = image
        plantImage.owner = owner
        plantImage.date = date
        return plantImage
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(PlantEntity.self).max(ofProperty: "id") as Int? ?? 0) + 2
    }
    
}
