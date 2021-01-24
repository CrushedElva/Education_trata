//
//  ChartScreenViewController.swift
//  education_trata_swift
//
//  Created by 18573930 on 25.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit
import Charts

class ChartScreenViewController: UIViewController, ChartViewDelegate {
    var viewModel: ChartScreenViewModelProtocol!
    var dateLabel: UILabel!
    var switchChartOutlet: UIButton!
    var dateEditOutlet: UIButton!
    var barChart: BarChartView!
    var pieChart: PieChartView!
    var tableView: UITableView!
    var cost: UILabel! {
        didSet {
            cost.textColor = UIColor.textColor
        }
    }
    
    @objc func switchChart(sender: UIButton!) {
      if sender.imageView?.image == UIImage(named: "barChartLight") {
          barChartSetInstallation()
      } else {
          pieChartSetInstallation()
      }
    }
    
    @objc func dateEdit(sender: UIButton!) {
      let pvc = DateEditViewController()
      pvc.modalPresentationStyle = .overCurrentContext
      present(pvc, animated: true, completion: nil)
    }
    
    let pastelColors: [UIColor] = [UIColor(red: 60, green: 160, blue: 222),
                                   UIColor(red: 154, green: 222, blue: 60),
                                   UIColor(red: 227, green: 206, blue: 43),
                                   UIColor(red: 245, green: 169, blue: 228),
                                   UIColor(red: 210, green: 185, blue: 230),
                                   UIColor(red: 169, green: 178, blue: 245),
                                   UIColor(red: 169, green: 237, blue: 245),
                                   UIColor(red: 169, green: 245, blue: 214),
                                   UIColor(red: 169, green: 245, blue: 171),
                                   UIColor(red: 237, green: 245, blue: 169),
                                   UIColor(red: 245, green: 203, blue: 169),
                                   UIColor(red: 245, green: 169, blue: 169)]
    
    
    
    func cofigureViewModel() {
        viewModel.updateData = {
            self.tableView.reloadData()
            self.cost.text = String(self.viewModel.sumEntries)
        }
        viewModel.showError = {
            (error: String) -> () in
            let alertController = UIAlertController(title: "Ошибка!", message: error, preferredStyle: .alert)
            let alertOKAktion = UIAlertAction(title: "Назад", style: .default, handler: { (UIAlertAction) in
                let vc = ChartScreenAssembly.chartScreenViewController()
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            })
            alertController.addAction(alertOKAktion)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tableViewColor
        cost = UILabel()
        dateLabel = UILabel()
        switchChartOutlet = UIButton()
        dateEditOutlet = UIButton()
        barChart = BarChartView()
        pieChart = PieChartView()
        tableView = UITableView()
        viewModel.viewDidLoad()
        cofigureViewModel()
        view.addSubview(cost)
        view.addSubview(dateLabel)
        view.addSubview(switchChartOutlet)
        view.addSubview(dateEditOutlet)
        view.addSubview(barChart)
        view.addSubview(pieChart)
        view.addSubview(tableView)
        installationConstraints()
        settingValues()
        tableView.dataSource = self
        pieChart.delegate = self
        barChart.delegate = self
    }
}

extension ChartScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ChartScreenTableViewCell.self), for: indexPath) as! ChartScreenTableViewCell
        cell.configure(color: pastelColors[indexPath.row], viewModel: viewModel.getCellViewModel(for: indexPath) as ChartScreenCellViewModelProtocol)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.expenceCount
    }
}

// MARK: Private
extension ChartScreenViewController {
    private func settingBarChart() {
        //удаление палитры внизу диаграммы
        barChart.legend.enabled = false
        barChart.backgroundColor = .tableViewColor
        barChart.leftAxis.axisMinimum = 0
        //удаление значений на графике справа и сверху
        barChart.rightAxis.enabled = false
        barChart.xAxis.drawLabelsEnabled = false
        //удаление сетки по оси x
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.xAxis.drawAxisLineEnabled = false
        //установка положения и размеров view для графика
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.topAnchor.constraint(equalTo: cost.bottomAnchor, constant: 5).isActive = true
        barChart.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        barChart.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        barChart.heightAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
    }
    
    private func settingPieChart() {
        //удаление палитры внизу диаграммы
        pieChart.legend.enabled = false
        pieChart.backgroundColor = .tableViewColor
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        pieChart.topAnchor.constraint(equalTo: cost.bottomAnchor, constant: 5).isActive = true
        pieChart.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        pieChart.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        pieChart.heightAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        pieChart.drawHoleEnabled = false
    }
    
    private func barChartSetInstallation() {
        //смена иконки при нажатии на кнопку
        switchChartOutlet.setImage(UIImage(named: "pieChartLight"), for: .normal)
        //анимировать график при начальной загрузке
        barChart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInCubic)
        let set = BarChartDataSet(entries: viewModel.entries)
        set.colors = pastelColors
        set.drawValuesEnabled = false
        let data = BarChartData(dataSet: set)
        barChart.data = data
        view.addSubview(barChart)
    }
    
    private func pieChartSetInstallation() {
        //смена иконки при нажатии на кнопку
        switchChartOutlet.setImage(UIImage(named: "barChartLight"), for: .normal)
        pieChart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInCubic)
        let set = PieChartDataSet(entries: viewModel.entries)
        //удаляет значения в кусочках
        set.drawValuesEnabled = false
        //установка цвета палитры
        set.colors = pastelColors
        let data = PieChartData(dataSet: set)
        pieChart.data = data
        view.addSubview(pieChart)
    }
    
    private func installationConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateLabel.textColor = UIColor.textColor
        dateEditOutlet.translatesAutoresizingMaskIntoConstraints = false
        dateEditOutlet.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        dateEditOutlet.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        dateEditOutlet.widthAnchor.constraint(equalToConstant: 30).isActive = true
        dateEditOutlet.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dateEditOutlet.addTarget(self, action: #selector(dateEdit), for: .touchUpInside)
        cost.translatesAutoresizingMaskIntoConstraints = false
        cost.topAnchor.constraint(equalTo: view.topAnchor, constant: 105).isActive = true
        cost.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        cost.font = .boldSystemFont(ofSize: 35)
        switchChartOutlet.translatesAutoresizingMaskIntoConstraints = false
        switchChartOutlet.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        switchChartOutlet.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        switchChartOutlet.widthAnchor.constraint(equalToConstant: 30).isActive = true
        switchChartOutlet.heightAnchor.constraint(equalToConstant: 30).isActive = true
        switchChartOutlet.addTarget(self, action: #selector(switchChart), for: .touchUpInside)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .separatorColor
        tableView.register(ChartScreenTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(ChartScreenTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: pieChart.bottomAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        settingPieChart()
        settingBarChart()
    }
    
    private func settingValues() {
        dateLabel.text = "dfghjkl"
        dateEditOutlet.setImage(UIImage(named: "calendar"), for: .normal)
        cost.text = NSString(format: "%.0f \u{20BD}", viewModel.sumEntries) as String
        barChartSetInstallation()
    }
}
