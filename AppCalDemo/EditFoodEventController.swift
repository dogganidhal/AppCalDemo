//
//  EditFoodEventController.swift
//  AppCalDemo
//
//  Created by Nidhal on 20.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

class EditFoodEventController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DatePickerControllerDelegate, AddFoodEventCellDelegate {
    
    private var sectionsTitles = [[nil, nil], ["All Day", "Start", "End", ], [nil, nil, "Meal type", "Add a photo"],["Delete"]]
    
    open var editedFoodEvent: MealEvent!
    private unowned var appDelegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    private unowned var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(handleSubmit))
        reloadController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getCurrentData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsTitles[section].count
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
                saveDataIntoEvent()
                let datePickerController = DatePickerController()
                datePickerController.delegate = self
                datePickerController.senderIdentifier = indexPath.row == 1 ? "start" : "end"
                navigationController?.pushViewController(datePickerController, animated: true)
            default:
                break
            }
        case 2:
            if indexPath.row == 3 {
                saveDataIntoEvent()
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                present(imagePickerController, animated: true, completion: nil)
            }
            break
        default:
            // Delete
            let alertController = UIAlertController(title: "Delete Event", message: "Are you sure want to delete this event?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
            })
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] (action) in
                // Delete Code
                self?.context.delete(self!.editedFoodEvent)
                self?.appDelegate.saveContext()
                alertController.dismiss(animated: true, completion: nil)
                for controller in self!.navigationController!.viewControllers {
                    if controller is DayController {
                        self?.navigationController?.popToViewController(controller, animated: true)
                    }
                }
            })
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            present(alertController, animated: true, completion: nil)
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
        saveDataIntoEvent()
        guard editedFoodEvent.summary != "" && editedFoodEvent.location != "" else {
            let alertController = UIAlertController(title: "Missing information",
                                                    message: "One or more fields empty",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
            }))
            present(alertController, animated: true, completion: nil)
            return
        }
        // Save to the core data
        appDelegate.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    internal func setupCellForSection(_ cell: AddFoodEventCell, atIndexPath indexPath: IndexPath) {
        cell.delegate = self
        switch indexPath.section {
        case 0:
            cell.identifier = .textField
            cell.placeholderForTextField = indexPath.row == 0 ? "Title" : "Location"
            cell.textForTextField = indexPath.row == 0 ? editedFoodEvent.summary : editedFoodEvent.location
            cell.textColorForTextField = Settings.appTheme == .dark ? .white : .black
        case 1:
            switch indexPath.row {
            case 0, 4:
                cell.identifier = .switch
                cell.valueForSwitch = indexPath.row == 0 ? editedFoodEvent.allDay : nil
            case 1:
                let formatter = DateFormatter()
                formatter.dateFormat = "MM-dd-yyyy HH:mm"
                cell.identifier = .disclosureIndicator
                cell.currentValueString = formatter.string(from: editedFoodEvent.startDate)
            case 2:
                let formatter = DateFormatter()
                formatter.dateFormat = "MM-dd-yyyy HH:mm"
                cell.identifier = .disclosureIndicator
                cell.currentValueString = formatter.string(from: editedFoodEvent.endDate)
            default:
                cell.identifier = .disclosureIndicator
                cell.currentValueString = "Never"
            }
        case 2:
            switch indexPath.row {
            case 0, 1:
                cell.identifier = .textField
                cell.placeholderForTextField = indexPath.row == 0 ? "URL" : "Notes"
                cell.textForTextField = indexPath.row == 1 ? editedFoodEvent.notes : nil
                cell.textColorForTextField = Settings.appTheme == .dark ? .white : .black
            case 2:
                cell.identifier = .segment
                cell.segmentTintColor = Settings.mainColor
                cell.valueForSegment = editedFoodEvent.mealType
            default:
                cell.identifier = .disclosureIndicator
                let imageData = editedFoodEvent.image
                cell.currentImage = imageData != nil ? UIImage(data: imageData! as Data) : nil
            }
        default:
            cell.textLabel?.text = sectionsTitles[indexPath.section][indexPath.row]
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .red
            cell.textLabel?.highlightedTextColor = .red
            cell.textLabel?.font = FontBook.regularFont(ofSize: 16)
            break
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
    
    // MARK: UIImagePickerController delegate method
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        editedFoodEvent.image = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage)
        picker.dismiss(animated: true, completion: nil)
        tableView.reloadRows(at: [IndexPath(row: 3, section: 2)], with: .none)
    }
    
    // MARK: DatePickerController delegate method
    
    func datePicker(_ datePickerController: DatePickerController, didChooseDate date: Date, forIdentifier identifier: String?) {
        if identifier == "start" {
            editedFoodEvent.startDate = date
        } else {
            editedFoodEvent.endDate = date
        }
        tableView.reloadData()
    }
    
    // MARK: AddFoodEventCell delegate method
    
    func addFoodEventCell(_ addFoodEventCell: AddFoodEventCell, shouldSaveData input: Any?) {
        saveDataIntoEvent()
    }
    
    // MARK: Save and retrieve data to and from the edited event
    
    internal func saveDataIntoEvent() {
        if (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddFoodEventCell)?.input != nil {
            editedFoodEvent.summary = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddFoodEventCell)?.input as? String
        }
        if (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AddFoodEventCell)?.input != nil {
            editedFoodEvent.location = (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AddFoodEventCell)?.input as? String
        }
        editedFoodEvent.allDay = (tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? AddFoodEventCell)?.input as! Bool
        if (tableView.cellForRow(at: IndexPath(row: 1, section: 2)) as? AddFoodEventCell)?.input != nil {
            editedFoodEvent.notes = (tableView.cellForRow(at: IndexPath(row: 1, section: 2)) as? AddFoodEventCell)?.input as? String
        }
        editedFoodEvent.mealType = Int16((tableView.cellForRow(at: IndexPath(row: 2, section: 2)) as? AddFoodEventCell)?.input as! Int)
    }
    
    internal func getCurrentData() {
        (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddFoodEventCell)?.input = editedFoodEvent.summary
        (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AddFoodEventCell)?.input = editedFoodEvent.location
        (tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? AddFoodEventCell)?.input = editedFoodEvent.allDay
        (tableView.cellForRow(at: IndexPath(row: 1, section: 2)) as? AddFoodEventCell)?.input = editedFoodEvent.notes
        (tableView.cellForRow(at: IndexPath(row: 2, section: 2)) as? AddFoodEventCell)?.valueForSegment = editedFoodEvent.mealType
    }
    
}
