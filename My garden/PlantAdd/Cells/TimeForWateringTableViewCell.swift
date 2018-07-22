//
//  TimeForWateringTableViewCell.swift
//  My garden
//
//  Created by Александр Филимонов on 21/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit

protocol TimeForWateringTableViewCellDelegate {
    func timeChanged(to value: String)
}

class TimeForWateringTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let variants = ["Утро", "Вечер"]
    var delegate: TimeForWateringTableViewCellDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Base class
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        timeLabel.text = variants[0]
    }
    
    public func setSelect() {
        showAlert()
    }
    
}

// MARK: - Private methods

private extension TimeForWateringTableViewCell {
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: variants[0], style: .default, handler: { (action) in
            self.timeLabel.text = self.variants[0]
            self.delegate?.timeChanged(to: self.variants[0])
        }))
        alert.addAction(UIAlertAction(title: variants[1], style: .default, handler: { (action) in
            self.timeLabel.text = self.variants[1]
            self.delegate?.timeChanged(to: self.variants[1])
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
