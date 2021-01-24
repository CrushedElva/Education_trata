//
//  MainScreenTableViewCell.swift
//  education_trata_swift
//
//  Created by 18574429 on 13.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var categoryIconView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var expenseLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var categoryIcon: UIImageView!
    
    static let identifier = "MainScreenTableViewCell"

    override func awakeFromNib() {
        categoryIconView.layer.cornerRadius = categoryIconView.layer.frame.size.width / 2
        categoryIconView.backgroundColor = .tableViewColor
        categoryIcon.tintColor = .textColor
        backgroundColor = .cellColor
    }
    
}
