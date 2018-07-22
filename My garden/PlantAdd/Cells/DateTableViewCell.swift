//
//  DateTableViewCell.swift
//  My garden
//
//  Created by Александр Филимонов on 21/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let dateFormatString = "dd.MM.yyyy"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Base class
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.inputView = getDatePicker()
        textField.inputAccessoryView = getToolBar()
    }
    
}

// MARK: - Private methods

private extension DateTableViewCell {
    
    func getDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.locale = Locale(identifier: "ru_RU")
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanded(sender:)), for: .valueChanged)
        
        return datePicker
    }
    
    func getToolBar() -> UIToolbar {
        let toolbar = UIToolbar()
        
        toolbar.isTranslucent = true
//        toolbar.layer.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - 20.0)
        toolbar.barStyle = .default
        toolbar.tintColor = .black
        
        let defaultButton = UIBarButtonItem(title: "Сегодня", style: .plain, target: self, action: #selector(todayPressed(sender:)))
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(donePressed(sender:)))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([defaultButton, flexSpace, doneButton], animated: true)
        
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        textField.resignFirstResponder()
    }
    
    @objc func datePickerValueChanded(sender: UIDatePicker) {
        let curDate = sender.date
        
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = dateFormatString
        
        textField.text = dateFormatted.string(from: curDate)
    }
    
    @objc func todayPressed(sender: UITabBarItem) {
        let date = Date()
        
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = dateFormatString
        
        textField.text = dateFormatted.string(from: date)
    }
}
