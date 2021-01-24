//
//  ChartScreenViewModel.swift
//  education_trata_swift
//
//  Created by 18573930 on 21.09.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit
import Charts
import CoreData

protocol ChartScreenViewModelProtocol{
    func viewDidLoad()
    var showError: ((String) -> Void)? { get set }
    var updateData: (() -> Void)? { get set }
    var spendingModels: [Spending] { get }
    func getExpence(for indexPath: Int) -> Spending
    var entries: [BarChartDataEntry] { get }
    var expenceCount: Int { get }
    var sumEntries: Double { get }
    func getCellViewModel(for indexPath: IndexPath) -> ChartScreenCellViewModelProtocol
}

class ChartScreenViewModel: ChartScreenViewModelProtocol {
    var showError: ((String) -> Void)?
    var cellViewModels: [ChartScreenCellViewModelProtocol]!
    var notes: [BarChartDataEntry]!
    var updateData: (() -> Void)?
    private var coreDataService: CoreDataServiceProtocol
    internal var spendingModels = [Spending]()
    
    init() {
        coreDataService = CoreDataService.instance
    }
    
    func viewDidLoad() {
        do {
            try coreDataService.fetch(entity: Spendings.self, predicate: nil, sortDescriptor: nil, completion: { (Spendings) in
                self.spendingModels = Spendings.map {s in Spending(cash: s.cash, name: s.name!, icon: UIImage(systemName: s.icon!))}
                self.updateData?()
            })
        } catch {
            showError!("Не удалось получить информацию о расходах!")
        }
        notes = (0...(spendingModels.count - 1)).map {(i) -> BarChartDataEntry in
            let val = self.spendingModels[i].cash
            return BarChartDataEntry(x: Double(i), y: val)
        }
        cellViewModels = (0...(spendingModels.count - 1)).map {(i) -> ChartScreenCellViewModelProtocol in
            return ChartScreenCellViewModel(rate: getExpence(for: i), note: entries[i])
        }
    }
    
    func getCellViewModel(for indexPath: IndexPath) -> ChartScreenCellViewModelProtocol {
        return cellViewModels[indexPath.row]
    }
    
    var sumEntries: Double {
        var entriesSum: Double = 0.0
        for y in notes {
            entriesSum += y.y
        }
        return entriesSum
    }
    
    var entries: [BarChartDataEntry] {
        return notes
    }
    
    var expenceCount: Int {
        return spendingModels.count
    }
    
    func getExpence(for indexPath: Int) -> Spending {
        return spendingModels[indexPath]
    }
}
