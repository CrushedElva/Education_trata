//
//  AddingCategoryViewController.swift
//  education_trata_swift
//
//  Created by 18573930 on 13.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

class AddingCategoryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    var icons: [CategoryType] = [.bank, .book, .bus, .cart, .child, .cinema, .computer, .cup,
                                 .donuts, .drink, .drug, .fastFood, .food, .girl, .money, .mortarboard,
                                 .mp3, .multimedia, .pharmacist, .photographicFilm, .photoshop, .plane,
                                 .price, .shop, .storm, .toy]
    
    enum AddingCategoryRowType: Int, CaseIterable {
        case title
        case selectCategory
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBarButton.tintColor = themeColor()
        setupSubviews()
        hideKeyboardWhenTappedAround()
    }
    
    private func setupSubviews(){
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryImageCollectionViewCell.nib, forCellWithReuseIdentifier:
            CategoryImageCollectionViewCell.reuseID)
        tableView.register(CategoryNameTableViewCell.nib, forCellReuseIdentifier:
            CategoryNameTableViewCell.reuseID)
        tableView.register(CategoryIconTableViewCell.nib, forCellReuseIdentifier:
            CategoryIconTableViewCell.reuseID)
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Core Data
// Добавить категорию и иконку в массив структур

extension AddingCategoryViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cellName = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.categoryTableViewCell, for: indexPath) as! CategoryTableViewCell
    }
}

extension AddingCategoryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AddingCategoryRowType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ordinalCell: AddingCategoryRowType = AddingCategoryViewController.AddingCategoryRowType(rawValue: indexPath.row)!
        switch ordinalCell {
        case .title:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryNameTableViewCell.reuseID,
                                                     for: indexPath) as? CategoryNameTableViewCell
            return cell!
        case .selectCategory:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryIconTableViewCell.reuseID,
                                                     for: indexPath) as? CategoryIconTableViewCell
            cell?.configure(with: CategorySelectInfoModel(state: .notSelected))
            return cell!
        }
    }
}

extension AddingCategoryViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! CategoryIconTableViewCell
        cell.configure(with: CategorySelectInfoModel(state: .selected(categoryImage: icons[indexPath.row].image)))
    }
}

extension AddingCategoryViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryImageCollectionViewCell.reuseID,
                    for: indexPath) as? CategoryImageCollectionViewCell else {
            fatalError("Wrong cell")
        }
        cell.configure(with: icons[indexPath.row].image)
        
        return cell
    }
}
