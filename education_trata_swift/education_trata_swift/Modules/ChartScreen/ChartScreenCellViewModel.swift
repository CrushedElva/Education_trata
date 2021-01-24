//
//  CellViewModel.swift
//  education_trata_swift
//
//  Created by 18573930 on 28.09.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit
import Charts

protocol ChartScreenCellViewModelProtocol {
    var expense: Spending { get }
    var entry: BarChartDataEntry { get }
}

class ChartScreenCellViewModel: ChartScreenCellViewModelProtocol{
    var expense: Spending
    var entry: BarChartDataEntry
    
    init(rate: Spending, note: BarChartDataEntry) {
        expense = rate
        entry = note
    }
}
