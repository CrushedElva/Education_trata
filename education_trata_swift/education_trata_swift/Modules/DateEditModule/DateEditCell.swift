//
//  DateEditCell.swift
//  education_trata_swift
//
//  Created by 18577745 on 24.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import Foundation
import UIKit

private enum Constants {
    
    enum nameLabel {
        static let topOffset: CGFloat = 10
        static let bottomOffset: CGFloat = -10
        static let rightOffset: CGFloat = 10
        static let leadingOffset: CGFloat = 16
    }
    enum dateLabel {
        static let topOffset: CGFloat = 10
        static let bottomOffset: CGFloat = -10
        static let rightOffset: CGFloat = -10
        static let leftOffset: CGFloat = 200
    }
   
    static let textSize: CGFloat = 17
}

class DateEditCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        self.backgroundColor = .cellColor
        initDateLabel()
        initLabel()
    }
    
    private let rowNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.textSize)
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.textSize)
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
}

extension DateEditCell {
    func configureDateEditCell(_ rowCase: DateEditModel) {
        rowNameLabel.text = rowCase.title

        //TODO: add date in dateLabel from Data Model
        //dateLabel.text =
    }
}

private extension DateEditCell {
    private func initLabel() {
        contentView.addSubview(rowNameLabel)
        rowNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.nameLabel.topOffset).isActive = true
        rowNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.nameLabel.bottomOffset).isActive = true
        rowNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.nameLabel.leadingOffset).isActive = true
        rowNameLabel.rightAnchor.constraint(equalTo: dateLabel.leftAnchor, constant: Constants.nameLabel.rightOffset).isActive = true
    }
    
    private func initDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.dateLabel.leftOffset).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.dateLabel.topOffset).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.dateLabel.bottomOffset).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: Constants.dateLabel.rightOffset).isActive = true
    }
}
