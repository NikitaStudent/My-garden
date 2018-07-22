//
//  UsefulFunctions.swift
//  My garden
//
//  Created by Александр Филимонов on 22/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import Foundation

func daysDiffWithoutTime(from: Date, to: Date) -> Int? {
    
    let calendar = Calendar(identifier: .gregorian)
    
    let componentsDateFrom = calendar.dateComponents([.month, .day, .year], from: from)
    let componentsDateTo = calendar.dateComponents([.month, .day, .year], from: to)
    
    guard let newFrom = calendar.date(from: componentsDateFrom), let newTo = calendar.date(from: componentsDateTo) else { return nil }
    
    if let days = calendar.dateComponents([.day], from: newFrom, to: newTo).day {
        return days
    } else {
        return nil
    }
    
}

func prettyPrintSmallDayDiffs(date: Date, dateFormatString: String) -> String {
    let now = Date()
    
    let dateFormatted = DateFormatter()
    dateFormatted.dateFormat = dateFormatString
    
    if let days = daysDiffWithoutTime(from: now, to: date) {
        switch days {
        case -2:
            return "Позавчера"
        case -1:
            return "Вчера"
        case 0:
            return "Сегодня"
        case 1:
            return "Завтра"
        case 2:
            return "Послезавтра"
        default:
            return dateFormatted.string(from: date)
        }
    }
    
    return dateFormatted.string(from: date)
    
}
