//
//  AddCategoryViewController.swift
//  education_trata_swift
//
//  Created by 18573930 on 02.09.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {
    var viewModel: AddCategoryViewModelProtocol!
    var entryField: UITextField!
    var addCategoryStackView: UIStackView!
    var inputStackView: UIStackView!
    var selectionStackView: UIStackView!
    var imageViewCategory: UIImageView!
    var collectionView: UICollectionView!
    var saveBarButton: UIBarButtonItem! {
        didSet {
            saveBarButton.title = NSLocalizedString("Save", comment: "")
        }
    }
    var mainLabel: UILabel! {
        didSet {
            mainLabel.text = NSLocalizedString("Add category", comment: "")
        }
    }
    var nameLabel: UILabel! {
        didSet {
            nameLabel.text = NSLocalizedString("Title", comment: "")
        }
    }
    var titleLabel: UILabel! {
        didSet {
            titleLabel.text = NSLocalizedString("Category", comment: "")
        }
    }
    var explanationLabel: UILabel! {
        didSet {
            explanationLabel.text = NSLocalizedString("Select a category", comment: "")
        }
    }
    
    func configureViewModel() {
        viewModel.updateSelectedImage = {
            (iconImage: UIImage) -> () in
            self.imageViewCategory.image = iconImage
            self.explanationLabel.isHidden = true
            self.imageViewCategory.isHidden = false
        }
        viewModel.updateSelectedImage = {
            (iconImage: UIImage) -> () in
            self.imageViewCategory.image = iconImage
            self.explanationLabel.isHidden = true
            self.imageViewCategory.isHidden = false
        }
    }
    
    func settingAddCategoryStackView() {
        addCategoryStackView.spacing = 10
        addCategoryStackView.axis = .vertical
        addCategoryStackView.addArrangedSubview(mainLabel)
        addCategoryStackView.addArrangedSubview(inputStackView)
        addCategoryStackView.addArrangedSubview(selectionStackView)
        addCategoryStackView.addArrangedSubview(collectionView)
        addCategoryStackView.translatesAutoresizingMaskIntoConstraints = false;
        view.addSubview(addCategoryStackView)
        setupAddCategoryStackView()
        settingInputStackView()
        settingSelectionStackView()
        elementsDeclaration()
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    func settingInputStackView() {
        inputStackView.axis = .horizontal
        inputStackView.spacing = 10
        inputStackView.addArrangedSubview(nameLabel)
        inputStackView.addArrangedSubview(entryField)
        inputStackView.translatesAutoresizingMaskIntoConstraints = false
        addCategoryStackView.addSubview(inputStackView)
        inputStackView.addSubview(nameLabel)
        inputStackView.addSubview(entryField)
    }
    
    func settingSelectionStackView() {
        selectionStackView.spacing = 10
        selectionStackView.backgroundColor = .cyan
        selectionStackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        selectionStackView.axis = .horizontal
        selectionStackView.addArrangedSubview(titleLabel)
        selectionStackView.addArrangedSubview(explanationLabel)
        selectionStackView.addArrangedSubview(imageViewCategory)
        selectionStackView.translatesAutoresizingMaskIntoConstraints = false
        addCategoryStackView.addSubview(selectionStackView)
        selectionStackView.addSubview(titleLabel)
        selectionStackView.addSubview(explanationLabel)
        selectionStackView.addSubview(imageViewCategory)
    }
    
    func elementsDeclaration() {
        settingNameLabel()
        settingExplanationLabel()
        settingEntryField()
        settingTitleLabel()
        settingMainLabel()
        settingImageViewCategory()
        settingSaveBarButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        
        self.hideKeyboardWhenTappedAround()
        
        entryField = UITextField()
        addCategoryStackView = UIStackView()
        inputStackView = UIStackView()
        selectionStackView = UIStackView()
        saveBarButton = UIBarButtonItem()
        mainLabel = UILabel()
        nameLabel = UILabel()
        titleLabel = UILabel()
        explanationLabel = UILabel()
        imageViewCategory = UIImageView()
        settingCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        settingAddCategoryStackView()
    }
}

// MARK: Private
extension AddCategoryViewController {
    private func setupAddCategoryStackView() {
        addCategoryStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        addCategoryStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        addCategoryStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        addCategoryStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    private func settingNameLabel() {
        nameLabel.widthAnchor.constraint(equalToConstant: nameLabel.intrinsicContentSize.width).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: inputStackView.leftAnchor, constant: 20).isActive = true
        nameLabel.font = nameLabel.font.withSize(15)
    }
    
    private func settingExplanationLabel () {
        explanationLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        explanationLabel.font = explanationLabel.font.withSize(15)
        explanationLabel.textColor = .gray
    }
    
    private func settingEntryField () {
        entryField.borderStyle = .roundedRect
        entryField.font = entryField.font?.withSize(15)
    }
    
    private func settingTitleLabel () {
        titleLabel.widthAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.width).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: inputStackView.leftAnchor, constant: 20).isActive = true
        titleLabel.font = titleLabel.font.withSize(15)
    }
    
    private func settingMainLabel () {
        mainLabel.font = .boldSystemFont(ofSize: 30)
        mainLabel.textAlignment = .center
    }
    
    private func settingImageViewCategory () {
        imageViewCategory.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -(view.frame.size.width - titleLabel.intrinsicContentSize.width - 75)).isActive = true
        imageViewCategory.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        imageViewCategory.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageViewCategory.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageViewCategory.isHidden = true
    }
    
    private func settingSaveBarButton () {
        saveBarButton.tintColor = themeColor()
    }
    
    private func settingCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        collectionView = UICollectionView(frame: addCategoryStackView.frame, collectionViewLayout: layout)
        collectionView?.register(CategoryImage.nib, forCellWithReuseIdentifier: CategoryImage.reuseID)
        collectionView?.backgroundColor = .none
    }
}

extension AddCategoryViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectCategory(at: indexPath)
    }
}

extension AddCategoryViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categoryCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryImage.reuseID,
                    for: indexPath) as? CategoryImage else {
            fatalError("Wrong cell")
        }
        cell.configure(with: viewModel.getCategory(for: indexPath).category.image)
        
        return cell
    }
}
