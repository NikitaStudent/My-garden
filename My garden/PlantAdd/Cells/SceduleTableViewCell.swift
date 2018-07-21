//
//  SceduleTableViewCell.swift
//  My garden
//
//  Created by Александр Филимонов on 21/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

class SceduleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleView: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    
    fileprivate var repeatTitle = ["день", "неделя", "месяц"]
    fileprivate let repeatCount = [1, 2, 3, 4, 5, 6]
    fileprivate var repeatName = "каждый"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        picker.dataSource = self
        picker.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SceduleTableViewCell: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 1
        }else if component == 2 {
            return repeatTitle.count
        } else {
            return repeatCount.count
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    
}

extension SceduleTableViewCell: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return repeatName
        } else if component == 2 {
            return repeatTitle[row]
        } else {
            return String(repeatCount[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            // каждый
            switch repeatCount[row] {
            case 1:
                repeatName = "каждый"
            default:
                repeatName = "каждые"
            }
            picker.reloadComponent(0)
            
            // массив месяц/неделя/день
            switch repeatCount[row] {
            case 1:
                repeatTitle = ["день", "неделю", "месяц"]
            case 2...4:
                repeatTitle = ["дня", "недели", "месяца"]
            default:
                repeatTitle = ["дней", "недель", "месяцев"]
            }
            picker.reloadComponent(2)
        }
    }
    
}
