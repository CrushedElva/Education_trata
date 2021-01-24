//
//  SpendingsDTO.swift
//  education_trata_swift
//
//  Created by 18573930 on 02.10.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit
import Foundation

class SpendingsDTO {
    var cash: Double
    var icon: String
    var name: String
    
    init(entity: Spendings) {
        self.cash = entity.cash
        self.icon = entity.icon ?? ""
        self.name = entity.name ?? ""
    }
}
