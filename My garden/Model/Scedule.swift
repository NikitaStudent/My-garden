//
//  Scedule.swift
//  My garden
//
//  Created by Александр Филимонов on 22/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import Foundation

enum SceduleDWM {
    case day
    case week
    case month
}

class Scedule {
    
    let sceduleDWM: SceduleDWM
    let count: Int
    
    init(str: String) {
        let partials = str.split(separator: "-")
        
        switch partials[0] {
        case "d":
            sceduleDWM = .day
        case "w":
            sceduleDWM = .week
        case "m":
            sceduleDWM = .month
        default:
            print("error creating SceduleDWM")
            sceduleDWM = .day
        }
        
        if let count = Int(partials[1]) {
            if count < 1 {
                self.count = 1
            } else if count > 6 {
                self.count = 6
            } else {
                self.count = count
            }
        } else {
            count = 0
        }
    }
    
    init(sceduleDWM: SceduleDWM, count: Int) {
        if count < 1 {
            self.count = 1
        } else if count > 6 {
            self.count = 6
        } else {
            self.count = count
        }
        self.sceduleDWM = sceduleDWM
    }
    
    func toString() -> String {
        let char: String
        
        switch sceduleDWM {
        case .day:
            char = "d"
        case .week:
            char = "w"
        case .month:
            char = "m"
        }
        
        
        return char + "-" + String(count)
    }
    
    func prettyPrint() -> String {
        
        var firstComp = ""
        var lastComp = ""
        var curCount = count
        
        switch count {
        case 1:
            firstComp = "Каждый"
        default:
            firstComp = "Каждые"
        }
        
        
        // массив месяц/неделя/день
        switch count {
        case 1:
            switch sceduleDWM {
            case .day:
                lastComp = "день"
            case .week:
                firstComp = "Каждую"
                lastComp = "неделю"
            case .month:
                lastComp = "месяц"
            }
            curCount = 0
        case 2...4:
            switch sceduleDWM {
            case .day:
                lastComp = "дня"
            case .week:
                lastComp = "недели"
            case .month:
                lastComp = "месяца"
            }
        default:
            switch sceduleDWM {
            case .day:
                lastComp = "дней"
            case .week:
                lastComp = "недель"
            case .month:
                lastComp = "месяцев"
            }
        }
        
        if curCount > 0 {
            return "\(firstComp) \(String(curCount)) \(lastComp)"
        } else {
            return "\(firstComp) \(lastComp)"
        }
        
    }
    
}
