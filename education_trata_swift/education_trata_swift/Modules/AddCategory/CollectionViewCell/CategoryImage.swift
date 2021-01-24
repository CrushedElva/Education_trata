//
//  CategoryImage.swift
//  education_trata_swift
//
//  Created by 18573930 on 07.09.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

class CategoryImage: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    static let reuseID = String(describing: CategoryImage.self)
    static let nib = UINib(nibName: String(describing: CategoryImage.self), bundle: nil)
    
    func configure(with icon: UIImage?) {
        imageView.image = icon
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
