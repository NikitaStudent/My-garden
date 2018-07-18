//: Playground - noun: a place where people can play

import UIKit
import UserNotifications

//Create Date from picker selected value.
func createDate(weekday: Int, hour: Int, minute: Int, year: Int)->Date{
    
    var components = DateComponents()
    components.hour = hour
    components.minute = minute
    components.year = year
    components.weekday = weekday // sunday = 1 ... saturday = 7
    components.weekdayOrdinal = 10
    components.timeZone = .current
    
    let calendar = Calendar(identifier: .gregorian)
    return calendar.date(from: components)!
}

//Schedule Notification with weekly bases.
func scheduleNotification(at date: Date, body: String, titles:String) {
    
    let triggerWeekly = Calendar.current.dateComponents([.weekday,.hour,.minute,.second,], from: date)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
    
    let content = UNMutableNotificationContent()
    content.title = titles
    content.body = body
    content.sound = UNNotificationSound.default
    content.categoryIdentifier = "todoList"
    
    let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
    
//    UNUserNotificationCenter.current().delegate = self
    //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().add(request) {(error) in
        if let error = error {
            print("Uh oh! We had an error: \(error)")
        }
    }
}

scheduleNotification(at: createDate(weekday: 4, hour: 8, minute: 18, year: 2018), body: "Some", titles: "Title")



