//
//  AddCategoryAssembly.swift
//  education_trata_swift
//
//  Created by 18573930 on 02.09.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

class AddCategoryAssembly {
    static func addCategoryViewController() -> UIViewController{
        let viewModel = AddCategoryViewModel()
        let viewController = AddCategoryViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
