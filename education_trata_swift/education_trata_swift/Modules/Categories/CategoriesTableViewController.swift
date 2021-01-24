//
//  TableViewController.swift
//  education_trata_swift
//
//  Created by 18573930 on 05.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var addCategoryButton: UIButton!
    @IBOutlet var listTableView: UITableView!
    
    var isEditingEnabled: Bool = true
    
    enum Constants {
        static let catergoryCellIdentifier: String = "cell"
    }
    
    @IBAction func editTapped(_ sender: UIBarButtonItem) {
        let doneButton:UIBarButtonItem = UIBarButtonItem(title:NSLocalizedString("Ready", comment: ""),
                                                         style:UIBarButtonItem.Style.plain,
                                                         target:self,
                                                         action:#selector(self.editTapped(_:)))
        self.navigationItem.setRightBarButton(doneButton, animated:false)
        let editButton:UIBarButtonItem = UIBarButtonItem(title:NSLocalizedString("Edit", comment: ""),
                                                         style:UIBarButtonItem.Style.plain,
                                                         target:self,
                                                         action:#selector(self.editTapped(_:)))
        self.navigationItem.setRightBarButton(editButton, animated:false)

        if self.isEditing {
            self.isEditing = false
            self.navigationItem.rightBarButtonItem = editButton
            self.navigationItem.rightBarButtonItem?.tintColor = themeColor()
            addCategoryButton.isHidden = true
        }
        else {
            self.isEditing = true
            self.navigationItem.rightBarButtonItem = doneButton
            self.navigationItem.rightBarButtonItem?.tintColor = themeColor()
            addCategoryButton.isHidden = false
        }
    }
    
    @IBAction func addCategoryTapped(_ sender: UIButton) {
        let vc = AddCategoryAssembly.addCategoryViewController()
        vc.view.backgroundColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            switch traitCollection.userInterfaceStyle {
            case .unspecified, .light:
                return .white
            case .dark:
                return .black
            @unknown default:
                return .red
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupViewController(){
        addCategoryButton.isHidden = true
        self.navigationItem.rightBarButtonItem?.tintColor = themeColor()
        if isEditingEnabled == false{
            self.navigationItem.rightBarButtonItem = nil
            mainLabel.text = NSLocalizedString("Select a category", comment: "")
            mainLabel.textAlignment = NSTextAlignment.center
            mainLabel.font = mainLabel.font.withSize(23)
        }
    }
    
    var entities: [CategoryDTO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        do {
            let sortDescriptor =  NSSortDescriptor(key: "order", ascending: true)
            let predicate = NSPredicate(format: "parent == nil")
            try CoreDataService.instance.fetch(entity: Category.self, predicate: predicate, sortDescriptor: sortDescriptor, completion: { (entityArray) in
                self.entities = entityArray.map({ (element) -> CategoryDTO in
                    return CategoryDTO(entity: element)
                })
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch let error {
            print("Error fetch entities and rewrite them to DTO \(error.localizedDescription)")
        }
        
        setupViewController()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:СellTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: Constants.catergoryCellIdentifier) as! СellTableViewCell
        
        cell.cellSetting(entityDTO: entities[indexPath.row])
        if (entities[indexPath.row].childes != nil) {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if (entities[indexPath.row].childes != nil) {
                let alert = UIAlertController(title: nil, message: "Эта категория содержит подкатегории, которые необходимо предварительно удалить.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ок", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
            }
            CoreDataService.instance.deleteEntity(entityID: entities[indexPath.row].objectID)
            entities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let elementToMove = entities[fromIndexPath.row]
        entities.remove(at: fromIndexPath.row)
        entities.insert(elementToMove, at: to.row)

        CoreDataService.instance.operationWithContext { (localContext) in
            for element in self.entities {
                do {
                    let entity = try localContext.existingObject(with: element.objectID) as! Category
                    entity.order = Int16(self.entities.firstIndex(where: { (curr) -> Bool in
                        if curr.objectID == element.objectID {
                            return true
                        } else {
                            return false
                        }
                    }) ?? 0)
                } catch let error {
                    print("Error \(error.localizedDescription)")
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
