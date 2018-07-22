//
//  PlantAddViewController.swift
//  My garden
//
//  Created by Александр Филимонов on 21/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit
import RealmSwift
import NotificationCenter

class PlantAddViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Views
    
    fileprivate var photoTableViewCell: PhotoTableViewCell?
    
    // MARK: - Properties
    
    fileprivate var plant: Plant?
    
    fileprivate var name = ""
    fileprivate var images: [UIImage] = []
    fileprivate var sort = ""
    
    fileprivate let cellsString = ["Имя", "Вид", "Поливать", "Время полива", "Посажен"]
    fileprivate struct Constants {
        static let cellIdentifier = "customCell"
        static let photoTableViewCell = "photoCellId"
        static let defaultCell = "defaultCellID"
        static let dateCell = "dateCellID"
        static let segmentedCell = "segmentedCellId"
        static let sceduleCell = "sceduleCellId"
    }
    
    // KARK: - Base classs
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AddPlantTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.photoTableViewCell)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.defaultCell)
        tableView.register(UINib(nibName: "DateTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.dateCell)
        tableView.register(UINib(nibName: "TimeForWateringTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.segmentedCell)
        tableView.register(UINib(nibName: "SceduleTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.sceduleCell)
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
        }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: UIBarButtonItemStyle.done, target: self, action: #selector(savePlant))
        
        UIApplication.shared.statusBarView?.backgroundColor = .white
    }
    
    // MARK: - Custom methods
    
    public func configure(with plant: Plant) {
        self.plant = plant
    }
    
    @objc private func savePlant() {
        
        if let plant = plant {
            // если это редактирование предыдущего объекта
            
            let realmInstatce = try! Realm()
            try! realmInstatce.write {
                if name.count > 0 {
                    plant.name = name
                }
                if sort.count > 0 {
                    plant.sort = sort
                }
            }
            
            // сохраняем фотки
//            for image in images {
//                let imageData = UIImageJPEGRepresentation(image, 0.9)
//                if let imageData = imageData {
//                    let customImage = PlantImage.getPlantImage(image: imageData, owner: plant)
//                    try! realmInstatce.write {
//                        realmInstatce.add(customImage)
//                    }
//                } else {
//                    print("не удалось получить data from image")
//                }
//
//            }
            
            navigationController?.popViewController(animated: true)
            
        } else {
            // это создание нового объекта
            guard name.count > 0, sort.count > 0, images.count > 0 else { return }
            
            // сохраняем объект
//            let plant = Plant.getPlantObject(name: name, sort: sort, scedule: "some", waterTime: 0, timesOfWatering: 12, lastWatered: Date(timeIntervalSince1970: TimeInterval(132561726354)))
            
//            let realmInstatce = try! Realm()
//            try! realmInstatce.write {
//                realmInstatce.add(plant)
//            }
            
            // сохраняем фотки
//            for image in images {
//                let imageData = UIImageJPEGRepresentation(image, 0.9)
//                if let imageData = imageData {
//                    let customImage = PlantImage.getPlantImage(image: imageData, owner: plant)
//                    try! realmInstatce.write {
//                        realmInstatce.add(customImage)
//                    }
//                } else {
//                    print("не удалось получить data from image")
//                }
//                
//            }
            
            navigationController?.popToRootViewController(animated: true)
            
        }
        
    }
    
    @objc func nameWasChanged(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let plant = plant {
            plant.name = text
        } else {
            name = text
        }
        
    }
    
    @objc func sortWasChanged(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let plant = plant {
            plant.sort = text
        } else {
            sort = text
        }
        
    }

}

extension PlantAddViewController: UITableViewDataSource, UITableViewDelegate {
    
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.photoTableViewCell, for: indexPath) as? PhotoTableViewCell {
                
                if photoTableViewCell == nil {
                    photoTableViewCell = cell
                    photoTableViewCell?.delegate = self
                    
                    cell.parent = self
                    
                    if let plant = plant {
                        cell.configure(with: DB.shared.getImages(of: plant))
                        
                        return cell
                    } else {
                        return cell
                    }
                } else {
                    return photoTableViewCell ?? UITableViewCell()
                }
                
            } else {
                return UITableViewCell()
            }
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.defaultCell, for: indexPath)
            
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 26)
            cell.textLabel?.text = "О растении"
            
            return cell
            
        } else {
            
            var cell: UITableViewCell?
            
            switch indexPath.row {
            case 0:
                let curCell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? AddPlantTableViewCell
                curCell?.titleLabel.text = cellsString[indexPath.row]
                
                if let plant = plant {
                    curCell?.inputField.text = plant.name
                }
                
                curCell?.inputField.addTarget(self, action: #selector(nameWasChanged(_:)), for: .editingChanged)
                
                cell = curCell
            case 1:
                let curCell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? AddPlantTableViewCell
                curCell?.titleLabel.text = cellsString[indexPath.row]
                
                if let plant = plant {
                    curCell?.inputField.text = plant.sort
                }
                
                curCell?.inputField.addTarget(self, action: #selector(sortWasChanged(_:)), for: .editingChanged)
                
                cell = curCell
            case 2:
                let curCell = tableView.dequeueReusableCell(withIdentifier: Constants.sceduleCell, for: indexPath) as? SceduleTableViewCell
                
                curCell?.titleView.text = cellsString[indexPath.row]
                
                cell = curCell
            case 3:
                let curCell = tableView.dequeueReusableCell(withIdentifier: Constants.segmentedCell, for: indexPath) as? TimeForWateringTableViewCell
                
                curCell?.titleLabel.text = cellsString[indexPath.row]
                
                cell = curCell
            case 4:
                let curCell = tableView.dequeueReusableCell(withIdentifier: Constants.dateCell, for: indexPath) as? DateTableViewCell
                
                curCell?.titleLabel.text = cellsString[indexPath.row]
                
                cell = curCell
            default:
                print("no such column")
            }
            
            return cell ?? UITableViewCell()
        }
        
    }
    
}

extension PlantAddViewController: PhotosDelegate {
    func photos(photoWasAdded photo: UIImage) {
        print("photo was added")
        images.append(photo)
    }
}
