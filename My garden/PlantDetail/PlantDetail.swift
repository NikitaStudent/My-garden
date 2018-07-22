//
//  PlantDetail.swift
//  My garden
//
//  Created by Александр Филимонов on 20/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit
import RealmSwift

class PlantDetail: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    fileprivate struct Constants {
        static let cellIdentifier = "customCell"
        static let photoTableViewCell = "photoCellId"
        static let defaultCell = "defaultCellID"
    }
    fileprivate let dateFormatString = "dd.MM.yyyy"
    fileprivate let imageHeight: CGFloat = 150
    var plant: Plant?
    fileprivate let cellsString = ["Вид", "Поливать", "Время полива", "Следующий полив", "Последний полив", "Возраст(дней)", "Полито(раз)", "Фотографий", "О виде"]
    var photosCollectionView: PhotoTableViewCell?
    
    // MARK: - Base class

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsetsMake(imageHeight, 0, 0, 0)
        tableView.register(UINib(nibName: "PlantDetailCell", bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.photoTableViewCell)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.defaultCell)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: imageHeight)
        view.addSubview(imageView)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return UIStatusBarStyle.lightContent
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Изменить", style: .done, target: self, action: #selector(editPlant))
        
        tableView.layoutIfNeeded()
    }
    
    // MARK: - Methods
    
    func setImage(with image: UIImage) {
        imageView.image = image
    }
    
}

// MARK: - Private methods

private extension PlantDetail {
    
    @objc private func editPlant() {
        let newVC = PlantAddViewController()
        if let plant = plant {
            newVC.configure(with: plant)
            navigationController?.pushViewController(newVC, animated: true)
        }
    }
    
}

extension PlantDetail: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section <= 1 {
            return 1
        }
        return cellsString.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.defaultCell, for: indexPath)
            guard let plant = plant else { return UITableViewCell() }
            
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 26)
            cell.textLabel?.text = plant.name
            cell.detailTextLabel?.text = plant.sort
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18)
            
            return cell
        } else if indexPath.section == 1 {
            
            if let photosView = photosCollectionView {
                return photosView
            }
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.photoTableViewCell, for: indexPath) as? PhotoTableViewCell {
                
                guard let plant = plant else { return UITableViewCell() }
                
                cell.configure(with: DB.shared.getImages(of: plant))
                cell.parent = self
                
                photosCollectionView = cell
                photosCollectionView?.delegate = self
                
                return cell
                
            } else {
                return UITableViewCell()
            }
            
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? PlantDetailCell, let plant = plant {
                
                cell.smallLabel.text = cellsString[indexPath.row]
                
                switch indexPath.row {
                case 0:
                    cell.largeLabel.text = plant.sort
                case 1:
                    cell.largeLabel.text = Scedule(str: plant.scedule).prettyPrint()
                case 2:
                    if plant.timesOfWatering == 0 {
                        cell.largeLabel.text = "Утро"
                    } else {
                        cell.largeLabel.text = "Вечер"
                    }
                case 3:
                    let date = plant.nextWatering
                    
                    cell.largeLabel.text = prettyPrintSmallDayDiffs(date: date, dateFormatString: dateFormatString)
                case 4:
                    let date = plant.lastWatering
                    
                    cell.largeLabel.text = prettyPrintSmallDayDiffs(date: date, dateFormatString: dateFormatString)
                case 5:
                    let date = plant.birthDay
                    let now = Date()
                    
                    let dateFormatted = DateFormatter()
                    dateFormatted.dateFormat = dateFormatString
                    
                    if let days = daysDiffWithoutTime(from: date, to: now) {
                        cell.largeLabel.text = String(days)
                    } else {
                        cell.largeLabel.text = "Нет данных"
                    }
                case 6:
                    cell.largeLabel.text = String(plant.timesOfWatering)
                case 7:
                    if let count = plant.images?.count {
                        cell.largeLabel.text = String(count)
                    } else {
                        cell.largeLabel.text = "Ошибка подсчета фотографий"
                    }
                case 8:
                    cell.largeLabel.text = plant.about ?? "нет данных"
                default:
                    print("no such column")
                }
                
                return cell
            } else {
                return UITableViewCell()
            }
        }
        
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let navBar = navigationController?.navigationBar else { return }
        
        let navBarHeight = navBar.frame.height + UIApplication.shared.statusBarFrame.height
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 0), 400)
        
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        
        var offset = y / (navBarHeight) - 1.0
        if offset > 1 {
            offset = 1
            let color = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 1 - offset)
            navBar.tintColor = UIColor(hue: 0, saturation: 0, brightness: offset, alpha: 1)
            navBar.backgroundColor = color
            navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(hue: 0, saturation: 0, brightness: offset, alpha: 1)]
            UIApplication.shared.statusBarView?.backgroundColor = color
        } else {
            let color = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 1 - offset)
            navBar.tintColor = UIColor(hue: 0, saturation: 0, brightness: offset, alpha: 1)
            navBar.backgroundColor = color
            navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(hue: 0, saturation: 0, brightness: offset, alpha: 1)]
            UIApplication.shared.statusBarView?.backgroundColor = color
        }
        
    }
    
}

// MARK: - PhotosDelegate

extension PlantDetail: PhotosDelegate {
    func photos(photoWasAdded photo: UIImage) {
        guard let plant = plant else { return }
        if DB.shared.save(photo: photo, for: plant) {
            photosCollectionView?.addImage(image: photo)
        } else {
            print("photo error saving to db")
        }
    }
}

