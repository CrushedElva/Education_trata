//
//  CategoryImageCollectionViewCell.swift
//  education_trata_swift
//
//  Created by 18573930 on 19.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

class CategoryImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    
    static let reuseID = String(describing: CategoryImageCollectionViewCell.self)
    static let nib = UINib(nibName: String(describing: CategoryImageCollectionViewCell.self), bundle: nil)
    
    func configure(with icon: UIImage?) {
        categoryImageView.image = icon
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
