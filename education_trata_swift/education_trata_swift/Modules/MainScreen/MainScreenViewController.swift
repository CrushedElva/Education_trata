//
//  MainScreenViewController.swift
//  education_trata_swift
//
//  Created by 18574429 on 11.08.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    @IBOutlet weak var expensePeriodButton: UIButton!
    @IBOutlet weak var chartButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var addExpenseButton: UIButton!
    @IBOutlet weak var switchCategoryButton: UIButton!
    @IBOutlet weak var addExpenseView: UIView!
    
    @IBOutlet weak var mainScreenTableView: UITableView!
    @IBOutlet weak var expenseSummaryLabel: UILabel!
    @IBOutlet weak var expenseNameTextField: UITextField!
    @IBOutlet weak var expenseAmountTextField: UITextField!
    
    @IBAction func expensePeriodButtonTapped(_ sender: Any) {
        
    }
    @IBAction func chartButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "QuestionsScreen", bundle: nil)
        let questionsVC = storyBoard.instantiateViewController(withIdentifier: "QuestionsScreen")
        self.show(questionsVC, sender: sender)
    }
    @IBAction func settingsButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Settings", bundle: nil)
        let questionsVC = storyBoard.instantiateViewController(withIdentifier: "Settings")
        self.show(questionsVC, sender: sender)
    }
    @IBAction func switchCategoryButtonTapped(_ sender: Any) {
        
    }
    @IBAction func addExpenseButtonTapped(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScreenTableView.dataSource = self
        mainScreenTableView.delegate = self
        addExpenseView.backgroundColor = .cellColor
        
        hideKeyboardOnTap()
        //add an Observer to check when move a view with keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
}


extension MainScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // TODO: set up logic to delete expenses from model
        }
    }
    
    // TODO: get numbers of sections from model
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // TODO: get date and sum from model
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let headerView = MainScreenTableHeaderView()

        headerView.dateLabel.text = "Date here"
        headerView.dateLabel.textAlignment = .left
        headerView.dateLabel.textColor = .headerTextColor
     
        headerView.sumLabel.text = "Sum here"
        headerView.sumLabel.textAlignment = .right
        headerView.sumLabel.textColor = .headerTextColor
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    // TODO: get numbers of rows from model
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainScreenTableView.dequeueReusableCell(withIdentifier: MainScreenTableViewCell.identifier, for: indexPath) as! MainScreenTableViewCell

        // TODO: get labels and image from appropriate models
        cell.categoryIcon.image = UIImage(systemName: "house")
        cell.categoryLabel.text = "House"
        cell.expenseLabel.text = "Молоко"
        cell.sumLabel.text = "455$"
        
        return cell
    }
}

extension MainScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // TODO: add segue to detail screen
    }
}

extension MainScreenViewController {
    
    // MARK: buttons and labels settings
    func setupUI() {
        //set up appropriate colors to elements for adaptive color scheme
        view.backgroundColor = .tableViewColor
        self.navigationController?.navigationBar.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        mainScreenTableView.separatorColor = .separatorColor
        mainScreenTableView.backgroundColor = .tableViewColor
        chartButton.tintColor = .textColor
        addExpenseButton.tintColor = .textColor
        switchCategoryButton.backgroundColor = .tableViewColor
        switchCategoryButton.tintColor = .textColor
        addExpenseButton.backgroundColor = .red
        settingsButton.tintColor = .textColor
        expensePeriodButton.tintColor = .textColor
        expenseNameTextField.backgroundColor = .cellColor
        
        chartButton.setImage(UIImage(systemName: "chart.pie.fill"), for: .normal)
        switchCategoryButton.setImage(UIImage(systemName: "house"), for: .normal)
        addExpenseButton.setImage(UIImage(systemName: "plus"), for: .normal)
        settingsButton.setImage(UIImage(systemName: "gear"), for: .normal)
        
        // TODO: add placeholder to localize file
        expenseNameTextField.placeholder = "Заметка"
        // TODO: add Currency Model from core data
//        expenseAmountTextField.placeholder = "0 \(CurrencyModel.currentCurrency.getCurrencyLabel(currency: CurrencyModel.currentCurrency))"
        
        // TODO: connect buttons and labels to  models
        expenseSummaryLabel.text = "$2130120301303120"
        expensePeriodButton.setTitle("August 2020", for: .normal)
    }
    
    // MARK: keyboard and addExpenseSettings
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey]
        let keyboardFrame = view.convert((keyboardSize as AnyObject).cgRectValue, from: view.window)
        
        addExpenseView.frame.origin.y = view.frame.maxY - keyboardFrame.height - addExpenseView.frame.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey]
        let keyboardFrame = view.convert((keyboardSize as AnyObject).cgRectValue, from: view.window)
        
        addExpenseView.frame.origin.y +=  keyboardFrame.height - 40
    }
    
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
}

