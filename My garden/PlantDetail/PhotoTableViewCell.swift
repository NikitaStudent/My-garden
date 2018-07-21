//
//  PhotoTableViewCell.swift
//  My garden
//
//  Created by Александр Филимонов on 21/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

protocol PhotosDelegate {
    func photos(photoWasAdded photo: UIImage)
}

class PhotoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var images: [UIImage] = []
    fileprivate struct Constants {
        static let cellIdentifier = "cellID"
        static let cameraIdentifier = "cameraID"
    }
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 8.0, right: 0.0)
    fileprivate let liseSpacingBetweenCells: CGFloat = 2
    fileprivate let itemsPerRow: CGFloat = 4
    
    public var delegate: PhotosDelegate?
    public var parent: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants.cellIdentifier)
        collectionView.register(UINib(nibName: "CameraCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants.cameraIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with images: [UIImage]) {
        self.images = images
    }
    
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension PhotoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cameraIdentifier, for: indexPath) as? CameraCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let curImage = images[indexPath.row - 1]
        
        cell.imageView.image = curImage
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let alert = UIAlertController(title: "Источник", message: "Откуда взять фотографию?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Камера", style: UIAlertActionStyle.default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .camera;
                    imagePicker.allowsEditing = false
                    self.parent?.present(imagePicker, animated: true, completion: nil)
                }
            }))
            alert.addAction(UIAlertAction(title: "Фото библиотка", style: UIAlertActionStyle.default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .photoLibrary;
                    imagePicker.allowsEditing = true
                    self.parent?.present(imagePicker, animated: true, completion: nil)
                }
            }))
            alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertActionStyle.cancel, handler: nil))
            
            parent?.present(alert, animated: true, completion: nil)
            
            
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotoTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = liseSpacingBetweenCells * (itemsPerRow - 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: collectionView.frame.height - 11)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return liseSpacingBetweenCells
    }
    
}

extension PhotoTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        images.insert(image, at: 0)
        delegate?.photos(photoWasAdded: image)
        collectionView.reloadData()
    }

}

