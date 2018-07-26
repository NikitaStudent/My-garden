//
//  PhotoTableViewCell.swift
//  My garden
//
//  Created by Александр Филимонов on 21/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit
import SKPhotoBrowser

protocol PhotosDelegate {
    func photos(photoWasAdded photo: UIImage)
}

class PhotoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var images: [UIImage] = []
    fileprivate struct Constants {
        static let cellIdentifier = "cellID"
    }
    fileprivate let sectionInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 10.0, right: 16.0)
    fileprivate let liseSpacingBetweenCells: CGFloat = 6
    fileprivate let itemsPerRow: CGFloat = 4
    
    public var delegate: PhotosDelegate?
    public var parent: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants.cellIdentifier)
        
        addPhotoButton.layer.cornerRadius = 18.0
        
        addPhotoButton.addTarget(self, action: #selector(addPhotoHandle), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with images: [UIImage]) {
        self.images = images
    }
    
    public func addImage(image: UIImage) {
        images.insert(image, at: 0)
        collectionView.reloadData()
    }
    
    @objc private func addPhotoHandle() {
        
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


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension PhotoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let curImage = images[indexPath.row]
        
        cell.imageView.image = curImage
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let curIndex = indexPath.row
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell, let originImage = cell.imageView.image else { return }
        
        var skImages = [SKPhoto]()
        
        for image in images {
            let photo = SKPhoto.photoWithImage(image)// add some UIImage
            skImages.append(photo)
        }
        
        SKPhotoBrowserOptions.displayStatusbar = true
        
        let browser = SKPhotoBrowser(originImage: originImage, photos: skImages, animatedFromView: cell)
        browser.initializePageIndex(curIndex)
        browser.delegate = self
        parent?.present(browser, animated: true, completion: {})
    
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotoTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = liseSpacingBetweenCells * (itemsPerRow - 1) + sectionInsets.left + sectionInsets.right
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: collectionView.frame.height - sectionInsets.top - sectionInsets.bottom)
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
        
       
        delegate?.photos(photoWasAdded: image)
    }

}

// MARK: -

extension PhotoTableViewCell: SKPhotoBrowserDelegate {
    
    func didShowPhotoAtIndex(_ browser: SKPhotoBrowser, index: Int) {
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
    }
    
}

