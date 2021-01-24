//
//  CurrencyTableViewCell.swift
//  education_trata_swift
//
//  Created by 18574429 on 06.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    static let identifier = "CurrencyCell"
    
    func configCell(entityDTO: CurrencyDTO) {
        self.textLabel?.text = entityDTO.symbol + " - " + entityDTO.name
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
