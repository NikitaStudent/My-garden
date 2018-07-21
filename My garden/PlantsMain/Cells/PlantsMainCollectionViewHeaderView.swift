//
//  PlantsMainCollectionViewHeaderView.swift
//  My garden
//
//  Created by Александр Филимонов on 19/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

class PlantsMainCollectionViewHeaderView: UICollectionReusableView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    
    
    // MARK: - Properties
    
    fileprivate struct Constants {
        static let cellIdentifier = "customCell"
    }
    fileprivate var plants: [Plant] = []
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 8.0, right: 0.0)
    fileprivate let cellWidth: CGFloat = 80
    
    
    // MARK: - Base class

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // button add
        addButton.layer.cornerRadius = 18.0
        
        // collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "WaterTodayCell", bundle: nil), forCellWithReuseIdentifier: Constants.cellIdentifier)
    }
    
    // MARK: - Custom methods
    
    func configure(with plants: [Plant]) {
        self.plants = plants
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension PlantsMainCollectionViewHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? WaterTodayCell else {
            return UICollectionViewCell()
        }
        
        let curPlant = plants[indexPath.row]
        
        guard let image = DB.shared.getImages(of: curPlant).first else { return UICollectionViewCell() }
        cell.image.image = image
        cell.title.text = curPlant.name
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plants.count
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PlantsMainCollectionViewHeaderView: UICollectionViewDelegateFlowLayout {
    
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
