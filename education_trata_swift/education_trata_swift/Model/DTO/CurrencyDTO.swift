//
//  CurrencyDTO.swift
//  education_trata_swift
//
//  Created by 18577745 on 19.09.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import Foundation

class CurrencyDTO {
    var name: String
    var symbol: String
    
    init(entity: Currency) {
        self.name = entity.name ?? ""
        self.symbol = entity.symbol ?? ""
    }
}
