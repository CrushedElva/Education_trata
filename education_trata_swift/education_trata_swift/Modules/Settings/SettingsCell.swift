//
//  SetttingsCell.swift
//  education_trata_swift
//
//  Created by 18577745 on 12.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

private enum Constants: Int {
    case imageTopOffset
    case imageBottomOffset
    case imageLeftOffset
    case labelTopOffset
    case labelBottomOffset
    case labelLeftOffset
    case labelTextSize
    
    var constantValue: CGFloat {
        switch self {
        case .imageTopOffset:
            return 10
        case .imageBottomOffset:
            return -12
        case .imageLeftOffset:
            return 10
        case .labelTopOffset:
            return 9
        case .labelBottomOffset:
            return -10
        case .labelLeftOffset:
            return 5
		case .labelTextSize:
            return 20
        }
    }
}

class SettingsCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        self.backgroundColor = UIColor.cellColor
        initSubviews()
    }
    
    private let labelPattern: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.labelTextSize.constantValue)
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()

    private let imagePattern: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.tintColor = UIColor.headerTextColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    @objc func switchChanged(sender: UISwitch) {
        print("Table row switch changed \(sender.tag)")
        let value = switchPattern.isOn
        print("Switch value changed \(value)")
      }
    
    private let switchPattern: UISwitch = {
        let switchRow = UISwitch(frame: .zero)
        switchRow.setOn(false, animated: true)
        return switchRow
    }()
    
    private func initSubviews() -> (){
        contentView.addSubview(imagePattern)
        imagePattern.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.imageLeftOffset.constantValue).isActive = true
        imagePattern.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.imageTopOffset.constantValue).isActive = true
        imagePattern.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.imageBottomOffset.constantValue).isActive = true
        
        contentView.addSubview(labelPattern)
        labelPattern.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.labelTopOffset.constantValue).isActive = true
        labelPattern.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.labelBottomOffset.constantValue).isActive = true
        labelPattern.leftAnchor.constraint(equalTo: imagePattern.rightAnchor, constant: Constants.labelLeftOffset.constantValue).isActive = true
    }

    private func configureSwitch(_ rowModel: SettingsRow) -> () {
        if rowModel.needSwitch {
            switchPattern.tag = SettingsRow.tagForSwitch
            switchPattern.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
            self.accessoryView = switchPattern
        } else {
            self.accessoryView = .none
        }
    }
    
    private func navigationItemInRow(_ rowModel: SettingsRow) -> () {
        if rowModel.needNavigationItem {
            self.accessoryType = .disclosureIndicator
        } else {
            self.accessoryType = .none
        }
    }
    
    public func configure(_ rowModel: SettingsRow) {
        labelPattern.text = rowModel.title
        imagePattern.image = rowModel.image
    
        configureSwitch(rowModel)
        navigationItemInRow(rowModel)
    }
    
}

