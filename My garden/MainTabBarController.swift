//
//  MainTabBarController.swift
//  My garden
//
//  Created by Александр Филимонов on 20/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabs()
    }

}

// MARK: - Provate methods

private extension MainTabBarController {
    
    func setupTabs() {
        // selected color
        UITabBar.appearance().tintColor = UIColor.darkGray
        
        viewControllers = [
            getPlantsTabVC(),
            getUserAreaTabVC()
        ]
        
    }
    
    func getPlantsTabVC() -> UIViewController {
        let vc = UINavigationController(rootViewController: PlantMainViewController())
        vc.tabBarItem.image = UIImage(named: "iconFlowerPot")
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return vc
    }
    
    func getUserAreaTabVC() -> UIViewController {
        let vc = UINavigationController(rootViewController: UserAreaController())
        vc.tabBarItem.image = UIImage(named: "iconUser")
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return vc
    }
    
}
