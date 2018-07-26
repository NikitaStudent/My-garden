//
//  PlantsMainCollectionViewHeaderView.swift
//  My garden
//
//  Created by Александр Филимонов on 19/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

protocol PlantsMainCollectionViewHeaderViewDelegate {
    func plantWasWatered(at index: Int)
}

class PlantsMainCollectionViewHeaderView: UICollectionReusableView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - Properties

    var delegate: PlantsMainCollectionViewHeaderViewDelegate?
    fileprivate struct Constants {
        static let cellIdentifier = "customCell"
    }
    fileprivate var plants: [PlantEntity] = []
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 8.0, right: 0.0)
    fileprivate let cellWidth: CGFloat = 80
    
//    var contentSize = CGSize(width: frame.width, height: 214)

    
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
    
    func configure(with plants: [PlantEntity]) {
        self.plants = plants
    }
    
    func removeWaterToday() {
        collectionView.removeFromSuperview()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension PlantsMainCollectionViewHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? WaterTodayCell else {
            return UICollectionViewCell()
        }

        let curPlant = plants[indexPath.row]

        guard let image = DB.shared.getMainImage(of: plants[indexPath.row]) else { return UICollectionViewCell() }
//        cell.image.image = image
//        cell.title.text = curPlant.name

        // определяем просрочку
        let now = Date()
        let date = plants[indexPath.row].nextWatering

        if let days = daysDiffWithoutTime(from: date, to: now) {
            if days > 0 {
                cell.configure(image: image, title: curPlant.name, colorLabelString: String(days))
            } else {
                cell.configure(image: image, title: curPlant.name, colorLabelString: nil)
            }
        }

        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plants.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("water today \(plants[indexPath.row].name)")

        let alert = UIAlertController(title: "Вы полили цветок \(plants[indexPath.row].name)?", message: nil, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (action) in
            DB.shared.waterToday(plant: self.plants[indexPath.row])

            self.delegate?.plantWasWatered(at: indexPath.row)

//            self.plants.remove(at: indexPath.row)
//            self.collectionView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))

        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)

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
