//
//  NewFoodEventController.swift
//  AppCalDemo
//
//  Created by Nidhal on 19.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

class NewFoodEventController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var sectionsTitles = [[nil, nil], ["All Day", "Start", "End", "Repeat", "Waytime"], ["Reminder"], [nil, nil, "Meal type", "Add a photo"]]
    open var newFoodEvent: MealEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(handleSubmit))
        
        reloadController()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 5
        case 3:
            return 4
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddFoodEventCell()
        cell.backgroundColor = Settings.appTheme == .dark ? .darkGray : .white
        cell.textColorForTextField = Settings.appTheme == .dark ? .white : .black
        setupCellForSection(cell, atIndexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = Settings.appTheme == .dark ? UIColor.white.withAlphaComponent(0.15) : .groupTableViewBackground
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section != 0 ? " " : nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: AddFoodEventCell = tableView.cellForRow(at: indexPath) as! AddFoodEventCell
        if selectedCell.identifier == .disclosureIndicator {
            navigationController?.pushViewController(BaseController(), animated: true)
        }
    }
    
    internal func reloadController() {
        let titleLabel = UILabel()
        titleLabel.text = "AppCalDemo"
        titleLabel.font = FontBook.boldFont(ofSize: 18)
        titleLabel.textColor = Settings.mainColor
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.tintColor = Settings.mainColor
        setupView()
        tableView.reloadData()
    }
    
    internal func handleSubmit() {
        // Construct the object with retrieved data
        
    }
    
    internal func setupCellForSection(_ cell: AddFoodEventCell, atIndexPath indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            cell.identifier = .textField
            cell.placeholderForTextField = indexPath.row == 0 ? "Title" : "Location"
        case 1:
            switch indexPath.row {
            case 0, 4:
                cell.identifier = .switch
            case 1:
                let formatter = DateFormatter()
                formatter.dateFormat = "MM-dd-yyyy HH:mm"
                cell.identifier = .disclosureIndicator
                cell.currentValueString = formatter.string(from: newFoodEvent?.startDate ?? Date()) // Should use the registred date
            case 2:
                let formatter = DateFormatter()
                formatter.dateFormat = "MM-dd-yyyy HH:mm"
                cell.identifier = .disclosureIndicator
                cell.currentValueString = formatter.string(from: newFoodEvent?.endDate ?? Date()) // Should use the registred date
            default:
                cell.identifier = .disclosureIndicator
                cell.currentValueString = "Never"
            }
        case 2:
            cell.identifier = .disclosureIndicator
            cell.currentValueString = "None"
        default:
            switch indexPath.row {
            case 0, 1:
                cell.identifier = .textField
                cell.placeholderForTextField = indexPath.row == 0 ? "URL" : "Notes"
            case 2:
                cell.identifier = .segment
                cell.segmentTintColor = Settings.mainColor
            default:
                cell.identifier = .disclosureIndicator
            }
            
        }
        cell.textLabel?.textColor = Settings.appTheme == .dark ? .white : .black
        cell.textLabel?.text = sectionsTitles[indexPath.section][indexPath.row]
        cell.textLabel?.font = FontBook.regularFont(ofSize: 16)
    }
    
    internal func setupView() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Settings.appTheme == .dark ? .darkGray : .groupTableViewBackground
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
    }
    
}
