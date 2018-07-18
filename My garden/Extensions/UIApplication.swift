//
//  UIApplication.swift
//  My garden
//
//  Created by Александр Филимонов on 18/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}
