//
//  MainScreenTableViewHeader.swift
//  education_trata_swift
//
//  Created by 18574429 on 26.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

class MainScreenTableHeaderView: UIView{
    
    var dateLabel: UILabel
    var sumLabel: UILabel
    
    override init(frame: CGRect) {
        self.dateLabel = UILabel()
        self.sumLabel = UILabel()
        
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(sumLabel)
        self.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        sumLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sumLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        sumLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
