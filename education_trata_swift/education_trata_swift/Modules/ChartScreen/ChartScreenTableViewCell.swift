//
//  ChartScreenTableViewCell.swift
//  education_trata_swift
//
//  Created by 18573930 on 18.09.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit
import Charts

class ChartScreenTableViewCell: UITableViewCell {
    var iconView: UIView! {
        didSet{
            iconView.layer.cornerRadius = 17
            iconView.clipsToBounds = true
        }
    }
    var iconImageView: UIImageView!
    var nameLabel: UILabel!
    var cash: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .cellColor
        
        nameLabel = UILabel()
        contentView.addSubview(nameLabel)
        cash = UILabel()
        contentView.addSubview(cash)
        iconView = UIView()
        contentView.addSubview(iconView)
        iconImageView = UIImageView()
        iconView.addSubview(iconImageView)
        setupConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupConstraints() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 60).isActive = true
        
        cash.translatesAutoresizingMaskIntoConstraints = false
        cash.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cash.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
    }
    
    func configure(color: UIColor, viewModel: ChartScreenCellViewModelProtocol) {
        iconImageView.image = viewModel.expense.icon
        iconImageView.tintColor = themeColor()
        nameLabel.text = viewModel.expense.name
        nameLabel.textColor = UIColor.textColor
        iconView.backgroundColor = color
        cash.text = NSString(format: "%.0f \u{20BD}", viewModel.entry.y) as String
        cash.textColor = UIColor.textColor
    }
}
