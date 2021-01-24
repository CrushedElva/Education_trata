//
//  Color.swift
//  education_trata_swift
//
//  Created by 18577745 on 13.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}

extension UIColor {
    static var headerTextColor: UIColor {
        return UIColor { (trait) -> UIColor in
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 253, green: 252, blue: 250)
            } else {
                return UIColor(red: 0, green: 0, blue: 0)
            }
        }
    }
    static var tableViewColor: UIColor {
        return UIColor { (trait) -> UIColor in
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 22, green: 22, blue: 22)
            } else {
                return UIColor(red: 251, green: 251, blue: 251)
            }
        }
    }
    static var separatorColor: UIColor {
        return UIColor { (trait) -> UIColor in
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 155, green: 155, blue: 155)
            } else {
                return UIColor(red: 181, green: 181, blue: 186)
            }
        }
    }
    static var cellColor: UIColor {
        return UIColor { (trait) -> UIColor in
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 44, green: 44, blue: 44)
            } else {
                return UIColor(red: 242, green: 242, blue: 247)
            }
        }
    }
    static var textColor: UIColor {
        return UIColor { (trait) -> UIColor in
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 234, green: 234, blue: 234)
            } else {
                return UIColor(red: 36, green: 42, blue: 47)
            }
        }
    }
}
