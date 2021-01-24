//
//  NoteEditViewController.swift
//  education_trata_swift
//
//  Created by 18577745 on 14.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MapKit

enum NoteEditModel: Int, CaseIterable {
    case sum
    case date
    case category
    case notes
    
    static var title: String = "Редактировать"
    static var numberOfSections: Int = 1
    static var rowHeight: CGFloat = 60.0
    
    var caseTitle: String {
        switch self {
        case .sum:
            return "Сумма"
        case .date:
            return "Дата"
        case .category:
            return "Категория"
        case .notes:
            return "Заметка"
        }
    }
    var datePicker: Bool {
        switch self {
        case .date:
            return true
        default:
            return false
        }
    }
    
    enum CellType {
        case textField
        case datePicker
    }
    
    var cellType: CellType {
        switch self {
        case .date:
            return .datePicker
        case .sum, .category, .notes:
            return .textField
        }
    }
}

class NoteEditViewController: UIViewController {
    
    @IBOutlet weak var noteEditTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerCreate()
        noteEditTableView.backgroundColor = .tableViewColor
        noteEditTableView.register(NoteEditTextFieldCell.self, forCellReuseIdentifier: "NoteEditTextFieldCell")
        noteEditTableView.register(NoteEditCategorySelectCell.self, forCellReuseIdentifier: "NoteEditCategorySelectCell")
        configureMapView()
    }
}

extension NoteEditViewController {
    func configureMapView() -> () {
        var mapView: MKMapView!
        mapView = MKMapView()
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.mapType = .standard
        mapView.userTrackingMode = .follow
        mapView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400)
        noteEditTableView.tableFooterView = mapView
        
        let coordinates = CLLocationCoordinate2D(latitude: 70.292, longitude: 38.9832) //TODO: coordinate from data model
        let place = MKPointAnnotation()
        place.title = "Hello" //TODO: note title here (from data model)
        place.coordinate = coordinates
        mapView.addAnnotation(place)
        let region = MKCoordinateRegion(center: place.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
        mapView.setRegion(region, animated: true)
    }
}

private extension NoteEditViewController {
    func headerCreate() -> () {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NoteEditModel.title

        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60)
        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
        label.backgroundColor = .clear
        label.textColor = UIColor.headerTextColor
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .left
        noteEditTableView.tableHeaderView = view
    }
}

extension NoteEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        noteEditTableView.deselectRow(at: indexPath, animated: true)
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NoteEditModel.rowHeight
    }
}

extension NoteEditViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return NoteEditModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NoteEditModel.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowCase = NoteEditModel.init(rawValue: indexPath.row)!
        switch rowCase {
        case .date, .notes, .sum:
            let cell = noteEditTableView.dequeueReusableCell(withIdentifier: "NoteEditTextFieldCell", for: indexPath) as! NoteEditTextFieldCell
            cell.configureNoteEditRow(NoteEditModel(rawValue: indexPath.row)!)
            return cell
        case .category:
            let cell = noteEditTableView.dequeueReusableCell(withIdentifier: "NoteEditCategorySelectCell") as! NoteEditCategorySelectCell
            cell.configureCategorySelectRow(NoteEditModel(rawValue: indexPath.row)!)
            return cell
        }
    }
}
