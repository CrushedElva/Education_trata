//
//  SettingsViewController.swift
//  education_trata_swift
//
//  Created by 18577745 on 05.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit
import SwiftUI
import Foundation

enum SettingsRow: Int, CaseIterable {
    
    case importData
    case exportData
    case category
    case currency
    case decor
    case siriSettings
    case enableHints
    case monthlyLimit
    
    static var separationOnSection : [AllCases] = [
        [ .importData, .exportData ],
        [ .category, .currency ],
        [ .decor ],
        [ .siriSettings ],
        [ .enableHints, .monthlyLimit ]
    ]
    
    static var title: String = "Настройки"
    static var tagForSwitch: Int = 0
    static var headerHeight: CGFloat = 30.0
    
    var image: UIImage {
        switch self {
        case .importData:
            return UIImage(named: "square.and.arrow.down")!
        case .exportData:
            return UIImage(named: "square.and.arrow.up")!
        case .category:
            return UIImage(named: "square.stack")!
        case .currency:
            return UIImage(named: "creditcard")!
        case .decor:
            return UIImage(named: "paintbrush")!
        case .siriSettings:
            return UIImage(named: "mic")!
        case .enableHints:
            return UIImage(named: "text.bubble")!
        case .monthlyLimit:
            return UIImage(named: "equal.square")!
        }
    }
    
    var title: String {
        switch self {
        case .importData:
            return "Импорт"
        case .exportData:
            return "Экспорт"
        case .category:
            return "Категории"
        case .currency:
            return "Валюта"
        case .decor:
            return "Оформление"
        case .siriSettings:
            return "Настроить Siri Shortcuts"
        case .enableHints:
            return "Включить подсказки"
        case .monthlyLimit:
            return "Установить месячный лимит"
        }
    }
    
    var needSwitch: Bool {
        switch self {
        case .enableHints:
            return true
        default:
            return false
        }
    }
    
    var needNavigationItem: Bool {
        switch self {
        case .category, .currency, .decor, .monthlyLimit:
            return true
        default:
            return false
        }
    }
    
    static func numberOfSection() -> Int {
        return SettingsRow.separationOnSection.count
    }
    
    static func numberOfRowsInSection(subArray section: Int) -> Int {
        return separationOnSection[section].count
    }
    
    static func dataForCell(rowInSection number: IndexPath) -> SettingsRow {
        tagForSwitch = number.row
        return separationOnSection[number.section][number.row]
    }
    
}


class  SettingsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        headerCreate()
        tableView.backgroundColor = .tableViewColor
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        tableView.separatorStyle = .singleLine
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        
        setupNavigation()
    }

}

private extension SettingsViewController {
    func headerCreate() -> () {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = SettingsRow.title
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60)
        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
        label.backgroundColor = .clear
        label.textColor = UIColor.headerTextColor
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .left
        tableView.tableHeaderView = view
    }
    
    // set up navigation elements of UI and set it to adaptive colors
    func setupNavigation() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .textColor
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped") //перебирать через switch было ли нажатие
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0.0 }
        else { return SettingsRow.headerHeight }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
        }
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsRow.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsRow.numberOfRowsInSection(subArray: section)
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        cell.configure(SettingsRow.dataForCell(rowInSection: indexPath))
        return cell
    }

}


struct SettingsViewController_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
