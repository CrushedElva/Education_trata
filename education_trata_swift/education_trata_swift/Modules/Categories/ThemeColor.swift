//
//  ThemeColor.swift
//  education_trata_swift
//
//  Created by 18573930 on 12.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

func themeColor() -> UIColor{
    let dynamicColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case
          .unspecified,
          .light: return .black
        case .dark: return .white
        @unknown default:
            return .red
        }
    }
    return dynamicColor
}
