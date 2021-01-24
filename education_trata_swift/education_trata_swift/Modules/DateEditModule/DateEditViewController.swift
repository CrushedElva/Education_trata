//
//  DateEditViewController.swift
//  education_trata_swift
//
//  Created by 18577745 on 21.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

enum DateEditModel: Int, CaseIterable {
    case start
    case end
    
    static var heightForRow: CGFloat = 40.0
    static var mainTitle: String = "Выбрать период"
    static var headerHeight: CGFloat = 40.0
    static var buttonTitle: String = "Готово"
    
    var title: String {
        switch self {
        case .start:
            return "Начало"
        case .end:
            return "Конец"
        }
    }
}

class DateEditViewController: UIViewController {

    let dateEditTableView = UITableView()
    let newView = UIView()
    let datePicker = UIDatePicker()
    var indexPath: IndexPath?
    var startCellContent: Date? //ADD FROM DATA MODEL
    var endCellContent: Date?  //ADD FROM DATA MODEL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        newView.frame = CGRect(x: 0, y: self.view.frame.height / 2, width: self.view.frame.width, height: self.view.frame.height / 2)
        newView.layer.cornerRadius = 10
        
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(newView)
       
        //ADD FROM DATA MODEL
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM yyyy"
        startCellContent = formatter.date(from: "03 10 2000")
        endCellContent = formatter.date(from: "01 10 2010")
        
        touchEvents()
        setupTableView()
        headerCreate()
        barButtonItemCreate()
        dateEditTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: dateEditTableView.frame.size.width, height: 1))
        dateEditTableView.register(DateEditCell.self, forCellReuseIdentifier: "dateEditCell")
    }
}

extension DateEditViewController: UIGestureRecognizerDelegate {
    
    @objc func viewTap(_ sender: UITapGestureRecognizer? = nil) {
        dismiss(animated: true, completion: nil)
    }
    func touchEvents() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewTap(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: newView) == true {
            return false
        }
        return true
    }
}

private extension DateEditViewController {
    func setupTableView() {
        newView.addSubview(dateEditTableView)
        dateEditTableView.translatesAutoresizingMaskIntoConstraints = false
        dateEditTableView.topAnchor.constraint(equalTo: newView.topAnchor, constant: DateEditModel.headerHeight).isActive = true
        dateEditTableView.leftAnchor.constraint(equalTo: newView.leftAnchor).isActive = true
        dateEditTableView.bottomAnchor.constraint(equalTo:
            newView.bottomAnchor).isActive = true
        dateEditTableView.rightAnchor.constraint(equalTo: newView.rightAnchor).isActive = true
        dateEditTableView.backgroundColor = .tableViewColor
        dateEditTableView.delegate = self
        dateEditTableView.dataSource = self
    }
}

private extension DateEditViewController {
    func headerCreate() {
        let subview = UIView()
        subview.backgroundColor = .tableViewColor
        subview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: DateEditModel.headerHeight)
        newView.addSubview(subview)
        subview.topAnchor.constraint(equalTo: newView.topAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: newView.leadingAnchor).isActive = true
        subview.rightAnchor.constraint(equalTo: newView.rightAnchor).isActive = true
        
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = DateEditModel.mainTitle
        subview.addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: subview.leadingAnchor, constant: 110).isActive = true
        label.topAnchor.constraint(equalTo: subview.topAnchor, constant: 12).isActive = true
        label.backgroundColor = .clear
        label.textColor = UIColor.headerTextColor
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 1
        label.textAlignment = .center
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func barButtonItemCreate() {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: self.view.frame.width / 5 * 4, y: 0, width: newView.frame.width / 5, height: DateEditModel.headerHeight)
        button.backgroundColor = .clear
        button.setTitle(DateEditModel.buttonTitle, for: .normal)
        button.tintColor = .blue
        button.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
        newView.addSubview(button)
    }
}

extension DateEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DateEditModel.heightForRow
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dateEditTableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        setupDatePicker()
    }
}
    

extension DateEditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DateEditModel.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateEditCell", for: indexPath) as! DateEditCell
        if let currentRow = DateEditModel.init(rawValue: indexPath.row) {
            cell.configureDateEditCell(currentRow)
        }
        let date = indexPath.row == DateEditModel.start.rawValue ? startCellContent : endCellContent
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        cell.dateLabel.text = formatter.string(from: date!)
        return cell
    }
}

private extension DateEditViewController {
    @objc func dateChanged() {
        if (indexPath?.row == DateEditModel.end.rawValue) {
            if (datePicker.date < startCellContent!) {
                datePicker.setDate(endCellContent!, animated: true)
                return
            }
        }
        if (indexPath?.row == DateEditModel.end.rawValue) {
            endCellContent = datePicker.date
        } else {
            startCellContent = datePicker.date
        }
        dateEditTableView.reloadData()
    }
    func setupDatePicker() {
        let date = indexPath?.row == DateEditModel.end.rawValue ? endCellContent : startCellContent
        datePicker.setDate(date!, animated: false)
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .tableViewColor
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        dateEditTableView.addSubview(datePicker)
        datePicker.frame = CGRect(x: 0, y: CGFloat(DateEditModel.allCases.count) * DateEditModel.heightForRow, width: self.view.frame.width, height: dateEditTableView.frame.height - CGFloat(DateEditModel.allCases.count) * DateEditModel.heightForRow)
    }
}
