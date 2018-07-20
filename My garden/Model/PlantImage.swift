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
    
//    dynamic var id = 0
    dynamic var image = Data()
    dynamic var owner: Plant?
    
    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
    
    static func getPlantImage(image: Data, owner: Plant?) -> PlantImage {
        let plantImage = PlantImage()
//        plantImage.id = incrementID()
        plantImage.image = image
        plantImage.owner = owner
        return plantImage
    }
    
//    static func incrementID() -> Int {
//        let realm = try! Realm()
//        return (realm.objects(PlantImage.self).max(ofProperty: "id") as Int? ?? 40) + 2
//    }
    
}

