//
//  PlantsMainCollectionViewHeaderView.swift
//  My garden
//
//  Created by Александр Филимонов on 15/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

class PlantsMainCollectionViewHeaderViewOld: UICollectionReusableView {
    
    @IBOutlet weak var waterCollectionView: UICollectionView!
    
    @IBOutlet weak var addButton: UIButton!
    
    fileprivate var plants: [Plant] = []
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 8.0, right: 0.0)
    let cellWidth: CGFloat = 80
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addButton.layer.cornerRadius = 18.0
    }
    
    func configure(with plants: [Plant]) {
        self.plants = plants
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension PlantsMainCollectionViewHeaderViewOld: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WaterTodayCell.self), for: indexPath) as? WaterTodayCell
        
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
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PlantsMainCollectionViewHeaderViewOld: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    
}
