//
//  CategoryIconTableViewCell.swift
//  education_trata_swift
//
//  Created by 18573930 on 25.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

struct CategorySelectInfoModel {
    enum State {
        case notSelected
        case selected(categoryImage: UIImage)
    }
    var state: State
}

class CategoryIconTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = NSLocalizedString("Category", comment: "")
        }
    }
    @IBOutlet weak var explanationLabel: UILabel! {
        didSet {
            explanationLabel.text = NSLocalizedString("Select a category", comment: "")
        }
    }
    @IBOutlet weak var iconCategoryImageView: UIImageView!
    
    static let reuseID = String(describing: CategoryIconTableViewCell.self)
    static let nib = UINib(nibName: String(describing: CategoryIconTableViewCell.self), bundle: nil)
    
    func configure(with model: CategorySelectInfoModel) {
        switch model.state {
        case .notSelected:
            titleLabel.isHidden = false
            explanationLabel.isHidden = false
            iconCategoryImageView.isHidden = true
        case .selected(let image):
            titleLabel.isHidden = false
            explanationLabel.isHidden = true
            iconCategoryImageView.isHidden = false
            iconCategoryImageView.image = image
        }
    }
}
