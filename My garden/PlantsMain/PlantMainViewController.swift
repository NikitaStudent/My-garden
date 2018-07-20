//
//  PlantMainViewController.swift
//  My garden
//
//  Created by Александр Филимонов on 19/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit
import RealmSwift

class PlantMainViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    var plants: [Plant] = []
    var sectionHeader: PlantsMainCollectionViewHeaderView?
    
    fileprivate struct Constants {
        static let customCellIdentifier = "plantMainCell"
        static let headerViewIdentifier = "headerView"
    }
    
    // MARK: - Base class
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PlantMainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants.customCellIdentifier)
        collectionView.register(UINib(nibName: "PlantsMainCollectionViewHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Constants.headerViewIdentifier)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        loadPlantData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
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

extension PlantMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.customCellIdentifier, for: indexPath) as? PlantMainCollectionViewCell
        
        let curPlant = plants[indexPath.row]
        
        print("images: \(DB.shared.getImages(of: curPlant))")
        cell?.imageView.image = DB.shared.getImages(of: curPlant).first
        cell?.label.text = curPlant.name
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

            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.headerViewIdentifier, for: indexPath) as? PlantsMainCollectionViewHeaderView else {
                return UICollectionReusableView()
            }

            sectionHeader = headerView
            sectionHeader?.configure(with: plants)

            return headerView
        default:
            assert(false, "Unexpected element kind")
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newVC = PlantDetail()
        
        let curPlant = plants[indexPath.row]
        
        newVC.plant = curPlant
        newVC.plantName = curPlant.name
        
        guard let image = DB.shared.getImages(of: curPlant).first else { return }
        
        newVC.setImage(with: image)
        
        
        navigationController?.pushViewController(newVC, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PlantMainViewController: UICollectionViewDelegateFlowLayout {
    
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
