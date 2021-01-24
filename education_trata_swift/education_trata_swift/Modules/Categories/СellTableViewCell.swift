//
//  cellTableViewCell.swift
//  education_trata_swift
//
//  Created by 18573930 on 06.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

class СellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    func cellSetting(entityDTO: CategoryDTO){
        categoryLabel.text = entityDTO.name
        iconImageView.image = UIImage(systemName: entityDTO.iconName)
        iconImageView.tintColor = themeColor()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
