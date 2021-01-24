//
//  CategoryNameTableViewCell.swift
//  education_trata_swift
//
//  Created by 18573930 on 24.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

class CategoryNameTableViewCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel! {
        didSet {
            labelName.text = NSLocalizedString("Title", comment: "")
        }
    }
    
    static let reuseID = String(describing: CategoryNameTableViewCell.self)
    static let nib = UINib(nibName: String(describing: CategoryNameTableViewCell.self), bundle: nil)
}
