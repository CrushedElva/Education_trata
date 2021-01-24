//
//  AddCategoryViewModel.swift
//  education_trata_swift
//
//  Created by 18573930 on 02.09.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

protocol AddCategoryViewModelProtocol {
    var categoryCount: Int { get }
    func getCategory(for indexPath: IndexPath) -> CategoryIconViewModel
    func didSelectCategory(at indexPath: IndexPath)
    var updateSelectedImage: ((UIImage) -> Void)? { get set }
}

class AddCategoryViewModel: AddCategoryViewModelProtocol {
    var updateSelectedImage: ((UIImage) -> Void)? = {
        (iconImage: UIImage) -> () in
        return iconImage
    }
    
    private var viewModels: [CategoryIconViewModel]
    
    var categoryCount: Int {
        return viewModels.count
    }
    
    init() {
        viewModels = CategoryType.allCases.map({ categoryType -> CategoryIconViewModel in
            return CategoryIconViewModel(category: categoryType)
        })
    }
    
    func didSelectCategory(at indexPath: IndexPath) {
        let imageIcon = viewModels[indexPath.row].category.image
        updateSelectedImage!(imageIcon)
    }
    
    func getCategory(for indexPath: IndexPath) -> CategoryIconViewModel {
        return viewModels[indexPath.row]
    }
}
