//
//  CategoryType.swift
//  education_trata_swift
//
//  Created by 18573930 on 19.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

enum CategoryType: CaseIterable {
    case bank
    case bus
    case cart
    case child
    case book
    case cinema
    case computer
    case cup
    case donuts
    case drink
    case drug
    case fastFood
    case food
    case girl
    case money
    case mortarboard
    case mp3
    case multimedia
    case pharmacist
    case photographicFilm
    case photoshop
    case plane
    case price
    case shop
    case storm
    case toy
    
    var image: UIImage {
        switch self {
        case .bank: return UIImage(named: "bank")!
        case .bus: return UIImage(named: "bus")!
        case .cart: return UIImage(named: "cart")!
        case .child: return UIImage(named: "child")!
        case .book: return UIImage(named: "book")!
        case .cinema: return UIImage(named: "cinema")!
        case .computer: return UIImage(named: "computer")!
        case .cup: return UIImage(named: "cup")!
        case .donuts: return UIImage(named: "donuts")!
        case .drink: return UIImage(named: "drink")!
        case .drug: return UIImage(named: "drug")!
        case .fastFood: return UIImage(named: "fast-food")!
        case .food: return UIImage(named: "food")!
        case .girl: return UIImage(named: "girl")!
        case .money: return UIImage(named: "money")!
        case .mortarboard: return UIImage(named: "mortarboard")!
        case .mp3: return UIImage(named: "mp3")!
        case .multimedia: return UIImage(named: "multimedia")!
        case .pharmacist: return UIImage(named: "pharmacist")!
        case .photographicFilm: return UIImage(named: "photographic-film")!
        case .photoshop: return UIImage(named: "photoshop")!
        case .plane: return UIImage(named: "plane")!
        case .price: return UIImage(named: "price")!
        case .shop: return UIImage(named: "shop")!
        case .storm: return UIImage(named: "storm")!
        case .toy: return UIImage(named: "toy")!
        }
    }
}
