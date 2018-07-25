//
//  SceduleTableViewCell.swift
//  My garden
//
//  Created by Александр Филимонов on 21/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

protocol SceduleTableViewCellDelegate {
    func sceduleWasChanged(to scedule: Scedule)
}

class SceduleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    fileprivate var repeatTitle = ["день", "неделя", "месяц"]
    fileprivate let repeatCount = [1, 2, 3, 4, 5, 6]
    fileprivate var repeatName = "каждый"
    
    fileprivate var curScedule = Scedule(sceduleDWM: .day, count: 1)
    
    var delegate: SceduleTableViewCellDelegate?
    
    fileprivate var picker: UIPickerView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        picker.dataSource = self
//        picker.delegate = self
        
        textField.inputView = getDatePicker()
        textField.inputAccessoryView = getToolBar()
        
        textField.text = curScedule.prettyPrint()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: - Private methods

private extension SceduleTableViewCell {
    
    func getDatePicker() -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
//        picker.addTarget(self, action: #selector(pickerValueChanded(sender:)), for: .valueChanged)
        
        self.picker = picker
        
        return picker
    }
    
    func getToolBar() -> UIToolbar {
        let toolbar = UIToolbar()
        
        toolbar.isTranslucent = true
        //        toolbar.layer.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - 20.0)
        toolbar.barStyle = .default
        toolbar.tintColor = .black
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(donePressed(sender:)))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        textField.resignFirstResponder()
    }
    
//    @objc func pickerValueChanded(sender: UIPickerView) {
//        let curCount = sender.selectedRow(inComponent: 1)
//        let curDWM = sender.selectedRow(inComponent: 2)
//
////        let dateFormatted = DateFormatter()
////        dateFormatted.dateFormat = dateFormatString
////
////        textField.text = dateFormatted.string(from: curDate)
////        delegate?.dateWasChanget(to: curDate)
//    }
    
}

// MARK: -

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
            picker?.reloadComponent(0)
            
            // массив месяц/неделя/день
            switch repeatCount[row] {
            case 1:
                repeatTitle = ["день", "неделю", "месяц"]
            case 2...4:
                repeatTitle = ["дня", "недели", "месяца"]
            default:
                repeatTitle = ["дней", "недель", "месяцев"]
            }
            picker?.reloadComponent(2)
        }
        
        // формируем структуру Scedule
        
        if component == 1 {
            curScedule.count = repeatCount[row]
            textField.text = curScedule.prettyPrint()
            delegate?.sceduleWasChanged(to: curScedule)
        }
        
        if component == 2 {
            switch row {
            case 0:
                curScedule.sceduleDWM = .day
            case 1:
                curScedule.sceduleDWM = .week
            case 2:
                curScedule.sceduleDWM = .month
            default:
                print("no suxh column")
            }
            textField.text = curScedule.prettyPrint()
            delegate?.sceduleWasChanged(to: curScedule)
        }
    }
    
}
