//
//  ChartScreenAssembly.swift
//  education_trata_swift
//
//  Created by 18573930 on 21.09.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

class ChartScreenAssembly: UITableViewCell {
    static func chartScreenViewController() -> UIViewController{
        let viewModel = ChartScreenViewModel()
        let viewController = ChartScreenViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
