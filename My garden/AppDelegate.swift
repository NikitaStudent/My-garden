//
//  AppDelegate.swift
//  My garden
//
//  Created by Александр Филимонов on 15/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        FileManager.default.removeItem(at:Realm.Configuration.defaultConfiguration.fileURL!)
        
        if !UserDefaults.standard.bool(forKey: "db_install") {
             loadDatabase()
        }
        
//        UIApplication.shared.statusBarView?.backgroundColor = .white
    
//        let realm = try! Realm()
//        try! realm.write {
//            realm.deleteAll()
//        }
//
        
        // ------ MIGRATION ------
        // -- !!! SET NEW VERSION !!! --
//        let config = Realm.Configuration(
//            // Set the new schema version. This must be greater than the previously used
//            // version (if you've never set a schema version before, the version is 0).
//            schemaVersion: 3,
//
//            // Set the block which will be called automatically when opening a Realm with
//            // a schema version lower than the one set above
//            migrationBlock: { migration, oldSchemaVersion in
//                // We haven’t migrated anything yet, so oldSchemaVersion == 0
//                if (oldSchemaVersion < 1) {
//                    // Nothing to do!
//                    // Realm will automatically detect new properties and removed properties
//                    // And will update the schema on disk automatically
//                }
//        })
//
//        // Tell Realm to use this new configuration object for the default Realm
//        Realm.Configuration.defaultConfiguration = config
//
//        // Now that we've told Realm how to handle the schema change, opening the file
//        // will automatically perform the migration
//        let realm = try! Realm()
        // ----- END MIGRATION
        
        // set app delegate as notification center delegate
//        UNUserNotificationCenter.current().delegate = self
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        /** First step create UIViewController with nib file without storyboard */
        let mainViewController = MainTabBarController()
        window?.rootViewController = mainViewController
        
        return true
    }
    
    func loadDatabase() {
        guard let image1 = UIImage(named: "plant1"), let image2 = UIImage(named: "plant2"), let image3 = UIImage(named: "plant3"), let image4 = UIImage(named: "plant4") else { return }
        guard let image1data = UIImageJPEGRepresentation(image1, 0.9), let image2data = UIImageJPEGRepresentation(image2, 0.9), let image3data = UIImageJPEGRepresentation(image3, 0.9), let image4data = UIImageJPEGRepresentation(image4, 0.9) else { return }
        
        let plant1 = Plant.getPlantObject(name: "Игорь", sort: "Фиалка", scedule: "w-1", waterTime: 0, timesOfWatering: 12, lastWatering: Date(timeIntervalSince1970: TimeInterval(132561726354)),nextWatering: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
        let plant2 = Plant.getPlantObject(name: "Миша", sort: "Кактус", scedule: "d-3", waterTime: 1, timesOfWatering: 12, lastWatering: Date(timeIntervalSince1970: TimeInterval(1325617263234)), nextWatering: Calendar.current.date(byAdding: .day, value: -10, to: Date())!)
        
        let realmInstatce = try! Realm()
        try! realmInstatce.write {
            realmInstatce.add(plant1)
            realmInstatce.add(plant2)
        }
        
        let customImage1 = PlantImage.getPlantImage(image: image1data, owner: plant1, date: Date())
        let customImage2 = PlantImage.getPlantImage(image: image2data, owner: plant1, date: Date())
        
        let customImage3 = PlantImage.getPlantImage(image: image3data, owner: plant2, date: Date())
        let customImage4 = PlantImage.getPlantImage(image: image4data, owner: plant2, date: Date())
        
        try! realmInstatce.write {
            realmInstatce.add(customImage1)
            realmInstatce.add(customImage2)
            realmInstatce.add(customImage3)
            realmInstatce.add(customImage4)
        }
        
        UserDefaults.standard.set(true, forKey: "db_install")
        
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // called when user interacts with notification (app not running in foreground)
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse, withCompletionHandler
//        completionHandler: @escaping () -> Void) {
//        
//        // do something with the notification
//        print(response.notification.request.content.userInfo)
//        
//        // the docs say you should execute this asap
//        return completionHandler()
//    }
//    
//    // called if app is running in foreground
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent
//        notification: UNNotification, withCompletionHandler completionHandler:
//        @escaping (UNNotificationPresentationOptions) -> Void) {
//        
//        // show alert while app is running in foreground
//        return completionHandler(UNNotificationPresentationOptions.alert)
//    }
    
}
