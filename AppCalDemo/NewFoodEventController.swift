//
//  NewFoodEventController.swift
//  AppCalDemo
//
//  Created by Nidhal on 19.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

class NewFoodEventController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DatePickerControllerDelegate {
    
    private var sectionsTitles = [[nil, nil], ["All Day", "Start", "End", "Repeat", "Waytime"], ["Reminder"], [nil, nil, "Meal type", "Add a photo"]]
    open var newFoodEvent: MealEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(handleSubmit))
        let entity = NSEntityDescription.entity(forEntityName: "MealEvent", in: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        newFoodEvent = MealEvent(entity: entity!, insertInto: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
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
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 1, 2:
                let datePickerController = DatePickerController()
                datePickerController.delegate = self
                datePickerController.senderIdentifier = indexPath.row == 1 ? "start" : "end"
                navigationController?.pushViewController(datePickerController, animated: true)
            case 3:
                // Repeat
                break
            default:
                // AllDay & WayTime
                break
            }
        case 2:
            // Reminder
            break
        case 3:
            if indexPath.row == 3 {
                let imagePickercontroller = UIImagePickerController()
                imagePickercontroller.delegate = self
                present(imagePickercontroller, animated: true, completion: nil)
            }
            break
        default:
            break
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
        // FIXME:- Unresolved Crash
        newFoodEvent?.summary = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddFoodEventCell).input as? String ?? ""
        newFoodEvent?.location = (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! AddFoodEventCell).input as? String ?? ""
        newFoodEvent?.allDay = (tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! AddFoodEventCell).input as? Bool ?? false
        newFoodEvent?.notes = (tableView.cellForRow(at: IndexPath(row: 1, section: 3)) as! AddFoodEventCell).input as? String ?? ""
        newFoodEvent?.mealType = Int16((tableView.cellForRow(at: IndexPath(row: 2, section: 3)) as! AddFoodEventCell).input as! Int)
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
                cell.currentValueString = formatter.string(from: newFoodEvent?.startDate ?? Date())
            case 2:
                let formatter = DateFormatter()
                formatter.dateFormat = "MM-dd-yyyy HH:mm"
                cell.identifier = .disclosureIndicator
                cell.currentValueString = formatter.string(from: newFoodEvent?.endDate ?? Date())
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
                let imageData = newFoodEvent?.image
                cell.currentImage = imageData != nil ? UIImage(data: imageData! as Data) : nil
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
        newFoodEvent?.image = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage)!
        picker.dismiss(animated: true, completion: nil)
        tableView.reloadRows(at: [IndexPath(row: 3, section: 3)], with: .none)
    }
    
    func datePicker(_ datePickerController: DatePickerController, didChooseDate date: Date, forIdentifier identifier: String?) {
        if identifier == "start" {
            newFoodEvent?.startDate = date
        } else {
            newFoodEvent?.endDate = date
        }
        tableView.reloadData()
    }
    
}
