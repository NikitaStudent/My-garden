//
//  PlantsMainController.swift
//  My garden
//
//  Created by Александр Филимонов on 15/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

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
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - IBActions
    
    
    // MARK: - BaseClass
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Полить сегодня"
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .red
//        navigationController?.navigationBar.
//        navigationController?.navigationBar.topItem?.title = "Мои цветы"
    }
    
    
    
    // MARK: - Internal methods

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension PlantsMainController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainPlantCell", for: indexPath) as? mainPlantCollectionViewCell
//        cell?.im
//        cell?.backgroundColor = .black
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
        //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "headerViewPlantsMainColectionView",
                                                                             for: indexPath) as! PlantsMainCollectionViewHeaderView
            return headerView
        default:
            //4
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
        
        return CGSize(width: widthPerItem, height: widthPerItem * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
    
}


