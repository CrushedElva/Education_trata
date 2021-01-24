//
//  QuestionsScreenViewController.swift
//  education_trata_swift
//
//  Created by 18574429 on 18.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

class QuestionsScreenViewController: UIViewController {
    
 
    @IBOutlet var questionsTableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionsTableView.delegate = self
        questionsTableView.dataSource = self
        setupUI()
    }
}

extension QuestionsScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChartScreenAssembly.chartScreenViewController()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension QuestionsScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionsModel.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = questionsTableView.dequeueReusableCell(withIdentifier: QuestionsTableViewCell.identifier, for: indexPath) as! QuestionsTableViewCell
        
        cell.textLabel?.text = QuestionsModel.questions[indexPath.row] + "?"
        return cell
    }
}

extension QuestionsScreenViewController {
    
    func setupUI() {
        questionsTableView.tableFooterView = UIView()
        questionsTableView.separatorStyle = .singleLine
        questionsTableView.separatorColor = .separatorColor
        questionsTableView.backgroundColor = .tableViewColor
        questionsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: questionsTableView.frame.size.width / 10)
        titleLabel.text = "Отчеты"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .textColor
        
    }

}
