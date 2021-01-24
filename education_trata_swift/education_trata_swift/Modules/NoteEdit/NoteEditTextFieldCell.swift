//
//  NoteEditTextFieldCell.swift
//  education_trata_swift
//
//  Created by 18577745 on 17.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import Foundation
import UIKit

private enum NoteEditConstants: Int {
    case labelTopOffset
    case labelBottomOffset
    case labelLeadingOffset
    case textFieldLeftOffset
    
    static var rowNameLabelFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .bold)
    
    var constantValue: CGFloat {
        switch self {
        case .labelTopOffset:
            return 13
        case .labelBottomOffset:
            return -13
        case .labelLeadingOffset:
            return 16
        case .textFieldLeftOffset:
            return 130
        }
    }
}

class NoteEditTextFieldCell: UITableViewCell {
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
        initLabel()
        initTextField()
    }
    
    private let rowNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = NoteEditConstants.rowNameLabelFont
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()
    
    private let dataEnterTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.textColor = .textColor
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        datePicker.datePickerMode = .dateAndTime
        datePicker.backgroundColor = .cellColor
        return datePicker
    }()
    
    var dateContent: Date = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM yyyy HH:mm"
        let date = formatter.date(from: "03 10 2020 16:59") //ADD FROM DATA MODEL
        return date!
    }()
    
    var textFieldContent: String = {
       var str = "Helloooo"     //ADD FROM DATA MODEL
        return str
    }()
}

extension NoteEditTextFieldCell {
    public func configureNoteEditRow(_ rowModel: NoteEditModel) {
        rowNameLabel.text = rowModel.caseTitle
        dataEnterTextField.text = textFieldContent
        initDatePicker(rowModel)
        textFieldAction()
    }
}

private extension NoteEditTextFieldCell {
    private func initTextField() -> () {
        contentView.addSubview(dataEnterTextField)
        dataEnterTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: NoteEditConstants.textFieldLeftOffset.constantValue).isActive = true
        dataEnterTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dataEnterTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dataEnterTextField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func initLabel() -> () {
        contentView.addSubview(rowNameLabel)
        rowNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: NoteEditConstants.labelTopOffset.constantValue).isActive = true
        rowNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: NoteEditConstants.labelBottomOffset.constantValue).isActive = true
        rowNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: NoteEditConstants.labelLeadingOffset.constantValue).isActive = true
    }
}

private extension NoteEditTextFieldCell {
    @objc func dateChanged() -> () {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy hh:mm"
        dateContent = datePicker.date
        dataEnterTextField.text = formatter.string(from: dateContent)
    }

    @objc func doneAction() -> () {
        self.endEditing(true)
    }
    
    private func initDatePicker(_ rowModel: NoteEditModel) {
        if rowModel.cellType == .datePicker {
            dataEnterTextField.inputView = datePicker
            datePicker.setDate(dateContent, animated: true)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM yyyy hh:mm"
            dataEnterTextField.text = formatter.string(from: dateContent)
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            toolbar.setItems([flexSpace, doneButton], animated: true)
            dataEnterTextField.inputAccessoryView = toolbar
            datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        } else {
            textFieldAction()
        }
    }
    
    @objc func didChangeText() -> () {
        textFieldContent = dataEnterTextField.text!
    }
    
    private func textFieldAction() -> () {
        dataEnterTextField.addTarget(self, action: #selector(didChangeText), for: .editingDidEnd)
    }
}
