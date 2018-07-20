//
//  PlantsMainController.swift
//  My garden
//
//  Created by Александр Филимонов on 15/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift

class PlantsMainController: UIViewController {

    // MARK: - Properties
    
    var plants: [Plant] = []
    let itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    var sectionHeader: PlantsMainCollectionViewHeaderView?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - IBActions
    
    
    // MARK: - BaseClass
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationItem.title = "Полить сегодня"
//        navigationItem.largeTitleDisplayMode = .always
        
        // remove border and shadow
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
        
        scheduleNotification2()
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        loadPlantData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func scheduleNotification2() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default()
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    
    
    // MARK: - Internal methods
    
    func loadPlantData() {
        let realmInsance = try! Realm()
        var plants = [Plant]()
        for plant in realmInsance.objects(Plant.self) {
            plants.append(plant)
        }
        self.plants = plants
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension PlantsMainController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainPlantCell", for: indexPath) as? mainPlantCollectionViewCell
        
        let curPlant = plants[indexPath.row]
        
//        cell?.image.image = UIImage(data: curPlant.image)
        cell?.title.text = curPlant.name
        return cell ?? UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plants.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
//        switch kind {
//        case UICollectionElementKindSectionHeader:
//            if let header = sectionHeader {
//                return header
//            }
//            
//            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: PlantsMainCollectionViewHeaderView.self),                   for: indexPath) as? PlantsMainCollectionViewHeaderView else {
//                return UICollectionReusableView()
//            }
//            
//            sectionHeader = headerView
//            sectionHeader?.configure(with: plants)
//            
//            return headerView
//        default:
//            assert(false, "Unexpected element kind")
//        }
        
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let destinationVC = segue.destination as! PlantDetailController
            
            let cell = sender as! mainPlantCollectionViewCell
            if let indexPath = self.collectionView.indexPath(for: cell) {
                let thisPlant = plants[indexPath.row]
                destinationVC.plantName = thisPlant.name
                destinationVC.plant = thisPlant
            }
            
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PlantsMainController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}


