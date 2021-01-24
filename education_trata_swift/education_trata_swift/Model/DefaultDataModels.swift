//
//  DefaultDataModels.swift
//  education_trata_swift
//
//  Created by 18577745 on 03.09.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import Foundation
import UIKit

enum DefaultDataModels: CaseIterable {
    
    enum Category: Int, CaseIterable {
        case home
        case transport
        case sport
        case restaurants
        case groceries
        case entertainment
        
        var contentOfEntity: (String, String) {
            switch self {
            case .home:
                return ("Home", "house")
            case .transport:
                return ("Transport", "car")
            case .sport:
                return ("Sport", "sportscourt")
            case .restaurants:
                return ("Restaurants & Cafes", "alarm")
            case .groceries:
                return ("Groceries", "cart")
            case .entertainment:
                return ("Entertainment", "gamecontroller")
            }
        }
    }
    
    enum Currency: Int, CaseIterable {
        case euro
        case usd
        case gbp
        case rub
        case yuan
        case yen
        case irp
        
        var contentOfEntity: (String, String) {
             switch self {
             case .euro:
                 return ("Euro", "€")
             case .usd:
                 return ("United States Dollar", "$")
             case .gbp:
                 return ("British Pound", "£")
             case .rub:
                 return ("Russian Ruble", "₽")
             case .yuan:
                 return ("Chinese Yuan", "¥")
             case .yen:
                 return ("Japanese Yen", "￥")
             case .irp:
                 return ("Indian Rupee", "₹")
             }
         }
    }
    
    enum Spendings: Int, CaseIterable {
        case home
        case transport
        case sport
        case restaurants
        case groceries
        case entertainment
        
        var contentOfEntity: (String, String, Double) {
            switch self {
            case .home:
                return ("Home", "house", 778.0)
            case .transport:
                return ("Transport", "car", 250.8)
            case .sport:
                return ("Sport", "sportscourt", 8648.0)
            case .restaurants:
                return ("Restaurants & Cafes", "alarm", 2987.7)
            case .groceries:
                return ("Groceries", "cart", 819.5)
            case .entertainment:
                return ("Entertainment", "gamecontroller", 1000.0)
            }
        }
    }
}
