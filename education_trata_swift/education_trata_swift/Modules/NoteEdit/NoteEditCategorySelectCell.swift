//
//  NoteEditCategorySelectCell.swift
//  education_trata_swift
//
//  Created by 18577745 on 24.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import Foundation
import UIKit

private enum NoteEditCategorySelectConstants {
    case imageTopOffset
    case imageLeftOffset
    case imageBottomOffset
    case categoryNameLeftOffset
    case categoryRowTextSize
    case rowTopOffset
    case rowBottomOffset
    case rowNameLeadingOffset
    
    var value: CGFloat {
        switch self {
        case .categoryRowTextSize:
            return 16
        case .imageLeftOffset:
            return 130
        case .imageTopOffset:
            return 15
        case .imageBottomOffset:
            return -15
        case .categoryNameLeftOffset:
            return 15
        case .rowTopOffset:
            return 13
        case .rowBottomOffset:
            return -13
        case .rowNameLeadingOffset:
            return 16
        }
    }
    static var categoryNameFont: UIFont = UIFont.systemFont(ofSize: NoteEditCategorySelectConstants.categoryRowTextSize.value, weight: .bold)
}

class NoteEditCategorySelectCell: UITableViewCell {
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
        initSubviews()
        navigationItemInRow()
    }
   
    private let rowNameLabel: UILabel = {
         let label = UILabel()
         label.textColor = UIColor.textColor
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = NoteEditCategorySelectConstants.categoryNameFont
         label.textAlignment = .left
         label.backgroundColor = .clear
         return label
     }()
    
    private let categoryImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.contentMode = .scaleAspectFill
        image.tintColor = UIColor.headerTextColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let categoryNameLabel: UILabel = {
         let label = UILabel()
         label.textColor = UIColor.textColor
         label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: NoteEditCategorySelectConstants.categoryRowTextSize.value)
         label.sizeToFit()
         label.textAlignment = .left
         label.backgroundColor = .clear
         return label
     }()
}

extension NoteEditCategorySelectCell {
    public func configureCategorySelectRow(_ rowModel: NoteEditModel) {
        rowNameLabel.text = rowModel.caseTitle
        
        //TODO: ADD DATA FROM CATEGORY DATA MODEL
        categoryImage.image = SettingsRow.currency.image
        categoryNameLabel.text = "Hotels"
    }
}

private extension NoteEditCategorySelectCell {
    private func initSubviews() {
        contentView.addSubview(rowNameLabel)
        rowNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: NoteEditCategorySelectConstants.rowTopOffset.value).isActive = true
        rowNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: NoteEditCategorySelectConstants.rowBottomOffset.value).isActive = true
        rowNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: NoteEditCategorySelectConstants.rowNameLeadingOffset.value).isActive = true
        
        contentView.addSubview(categoryImage)
        categoryImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: NoteEditCategorySelectConstants.imageLeftOffset.value).isActive = true
        categoryImage.topAnchor.constraint(equalTo: self.topAnchor, constant: NoteEditCategorySelectConstants.imageTopOffset.value).isActive = true
        categoryImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: NoteEditCategorySelectConstants.imageBottomOffset.value).isActive = true
        
        contentView.addSubview(categoryNameLabel)
        categoryNameLabel.leftAnchor.constraint(equalTo: categoryImage.rightAnchor, constant: NoteEditCategorySelectConstants.categoryNameLeftOffset.value).isActive = true
        categoryNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: NoteEditCategorySelectConstants.rowTopOffset.value).isActive = true
        categoryNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: NoteEditCategorySelectConstants.rowBottomOffset.value).isActive = true
    }
    
    private func navigationItemInRow() {
        self.accessoryType = .disclosureIndicator
     }
}
