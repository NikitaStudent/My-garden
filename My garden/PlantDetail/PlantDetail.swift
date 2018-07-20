//
//  PlantDetail.swift
//  My garden
//
//  Created by Александр Филимонов on 20/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

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
    }
    fileprivate let imageHeight: CGFloat = 150
    var plant: Plant?
    var plantName: String?
    fileprivate let cellsString = ["Вид", "Поливать", "Время полива", "Следующий полив", "Возраст", "Полито раз", "Фотографий", "Последний полив"]
    
    // MARK: - Base class

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsetsMake(imageHeight, 0, 0, 0)
        tableView.register(UINib(nibName: "PlantDetailCell", bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: imageHeight)
        view.addSubview(imageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let plantName = plantName {
            navigationItem.title = plantName
        }
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        tableView.layoutIfNeeded()
    }
    
    // MARK: - Methods
    
    func setImage(with image: UIImage) {
        imageView.image = image
    }
    
}

extension PlantDetail: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsString.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? PlantDetailCell {
            
            cell.smallLabel.text = cellsString[indexPath.row]
            
            switch indexPath.row {
            case 0:
                cell.largeLabel.text = plant?.sort
            case 1:
                print("")
            case 2:
                print("")
            case 3:
                print("")
            case 4:
                print("")
            case 5:
                print("")
            case 6:
                print("")
            case 7:
                print("")
            default:
                print("no such column")
            }
            
            return cell
        } else {
            return UITableViewCell()
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

