//
//  PlantDetailController.swift
//  My garden
//
//  Created by Александр Филимонов on 17/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

class PlantDetailController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let imageView = UIImageView()
    let imageHeight: CGFloat = 300
    var plant: PlantEntity!
    var plantName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.contentInset = UIEdgeInsetsMake(imageHeight, 0, 0, 0)
        
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: imageHeight)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.title = plantName
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }

}



extension PlantDetailController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let navBar = navigationController?.navigationBar else { return }
        
        let navBarHeight = navBar.frame.height + UIApplication.shared.statusBarFrame.height
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, navBarHeight), 400)
        
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
