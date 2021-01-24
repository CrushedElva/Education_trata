//
//  CurrencyViewController.swift
//  education_trata_swift
//
//  Created by 18574429 on 05.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelView: UILabel!
    var entities: [CurrencyDTO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let sortDescriptor =  NSSortDescriptor(key: "order", ascending: true)
            try CoreDataService.instance.fetch(entity: Currency.self, predicate: nil, sortDescriptor: sortDescriptor, completion: { (entityArray) in
                self.entities = entityArray.map({ (element) -> CurrencyDTO in
                    return CurrencyDTO(entity: element)
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        } catch let error{
                print("\(error.localizedDescription)")
        }
        
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        labelView.text = NSLocalizedString("Валюта", comment: "")
    }
}

extension CurrencyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //TODO: add selected currency in global currency value and leave screen
    }
}

extension CurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as! CurrencyTableViewCell
        cell.configCell(entityDTO: entities[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count
    }
}
