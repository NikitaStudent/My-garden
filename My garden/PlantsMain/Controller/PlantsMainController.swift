//
//  PlantsMainController.swift
//  My garden
//
//  Created by Александр Филимонов on 15/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit
import UserNotifications

class PlantsMainController: UIViewController {

    // MARK: - Properties
    
    let plants: [Plant] = {
        var retArray: [Plant] = []
        
        let names = ["Фиалка", "Фикус", "Альстрамерия", "Кактус"]
        let images = [#imageLiteral(resourceName: "plant1"), #imageLiteral(resourceName: "plant2"), #imageLiteral(resourceName: "plant3"), #imageLiteral(resourceName: "plant4")]
        for index in 0..<4 {
            let curPlant = Plant(name: names[index], image: images[index])
            retArray.append(curPlant)
        }
        for index in 0..<4 {
            let curPlant = Plant(name: names[index], image: images[index])
            retArray.append(curPlant)
        }
        return retArray
    }()
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

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension PlantsMainController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainPlantCell", for: indexPath) as? mainPlantCollectionViewCell
            
        cell?.image.image = plants[indexPath.row].image
        cell?.title.text = plants[indexPath.row].name
        return cell ?? UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            if let header = sectionHeader {
                return header
            }
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: PlantsMainCollectionViewHeaderView.self),                   for: indexPath) as? PlantsMainCollectionViewHeaderView else {
                return UICollectionReusableView()
            }
            
            sectionHeader = headerView
            sectionHeader?.configure(with: plants)
            
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
        
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PlantsMainController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        print("sizeForItem")
        return CGSize(width: widthPerItem, height: widthPerItem * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}


