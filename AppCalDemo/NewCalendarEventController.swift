//
//  NewCalendarEventController.swift
//  AppCalDemo
//
//  Created by Nidhal on 21.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

@objc open class NewCalendarEventController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DatePickerControllerDelegate, AddFoodEventCellDelegate {
    
    private var sectionsTitles = [[nil, nil], ["All Day", "Start", "End", ], [nil, nil, "Add a photo"]]
    
    open var newCalendarEvent: GenericEvent!
    private unowned var appDelegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    private unowned var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(handleSubmit))
        newCalendarEvent = NSEntityDescription.insertNewObject(forEntityName: "GenericEvent", into: context) as! GenericEvent
        newCalendarEvent.startDate = Date()
        newCalendarEvent.endDate = Date()
        newCalendarEvent.allDay = false
        reloadController()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getCurrentData()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveDataIntoEvent()
    }
    
    // MARK: - Table view data source
    
    override open func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsTitles.count
    }
    
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsTitles[section].count
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddFoodEventCell()
        cell.backgroundColor = Settings.appTheme == .dark ? .darkGray : .white
        cell.textColorForTextField = Settings.appTheme == .dark ? .white : .black
        setupCellForSection(cell, atIndexPath: indexPath)
        return cell
    }
    
    override open func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = Settings.appTheme == .dark ? UIColor.white.withAlphaComponent(0.15) : .groupTableViewBackground
    }
    
    override open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section != 0 ? " " : nil
    }
    
    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 1, 2:
                let datePickerController = DatePickerController()
                datePickerController.delegate = self
                datePickerController.senderIdentifier = indexPath.row == 1 ? "start" : "end"
                navigationController?.pushViewController(datePickerController, animated: true)
            default:
                break
            }
        case 2:
            if indexPath.row == 2 {
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                present(imagePickerController, animated: true, completion: nil)
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
        saveDataIntoEvent()
        guard newCalendarEvent.summary != "" && newCalendarEvent.location != "" else {
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
            cell.textForTextField = indexPath.row == 0 ? newCalendarEvent.summary : newCalendarEvent.location
            cell.textColorForTextField = Settings.appTheme == .dark ? .white : .black
        case 1:
            switch indexPath.row {
            case 0, 4:
                cell.identifier = .switch
                cell.valueForSwitch = indexPath.row == 0 ? newCalendarEvent.allDay : nil
            case 1:
                let formatter = DateFormatter()
                formatter.dateFormat = "MM-dd-yyyy HH:mm"
                cell.identifier = .disclosureIndicator
                cell.currentValueString = formatter.string(from: newCalendarEvent.startDate)
            case 2:
                let formatter = DateFormatter()
                formatter.dateFormat = "MM-dd-yyyy HH:mm"
                cell.identifier = .disclosureIndicator
                cell.currentValueString = formatter.string(from: newCalendarEvent.endDate)
            default:
                cell.identifier = .disclosureIndicator
                cell.currentValueString = "Never"
            }
        default:
            switch indexPath.row {
            case 0, 1:
                cell.identifier = .textField
                cell.placeholderForTextField = indexPath.row == 0 ? "URL" : "Notes"
                cell.textForTextField = indexPath.row == 1 ? newCalendarEvent.notes : nil
                cell.textColorForTextField = Settings.appTheme == .dark ? .white : .black
            default:
                cell.identifier = .disclosureIndicator
                let imageData = newCalendarEvent.image
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
    
    // MARK: UIImagePickerController delegate method
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        newCalendarEvent.image = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage)
        picker.dismiss(animated: true, completion: nil)
        tableView.reloadRows(at: [IndexPath(row: 2, section: 2)], with: .none)
    }
    
    // MARK: DatePickerController delegate method
    
    public func datePicker(_ datePickerController: DatePickerController, didChooseDate date: Date, forIdentifier identifier: String?) {
        if identifier == "start" {
            newCalendarEvent.startDate = date
        } else {
            newCalendarEvent.endDate = date
        }
        tableView.reloadData()
    }
    
    // MARK: AddFoodEventCell delegate method
    
    public func addFoodEventCell(_ addFoodEventCell: AddFoodEventCell, shouldSaveData input: Any?) {
        saveDataIntoEvent()
    }
    
    // MARK: Save and retrieve data to and from the new created event
    
    internal func saveDataIntoEvent() {
        if (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddFoodEventCell)?.input != nil {
            newCalendarEvent.summary = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddFoodEventCell)?.input as? String
        }
        if (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AddFoodEventCell)?.input != nil {
            newCalendarEvent.location = (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AddFoodEventCell)?.input as? String
        }
        newCalendarEvent.allDay = (tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? AddFoodEventCell)?.input as! Bool
        if (tableView.cellForRow(at: IndexPath(row: 1, section: 2)) as? AddFoodEventCell)?.input != nil {
            newCalendarEvent.notes = (tableView.cellForRow(at: IndexPath(row: 1, section: 2)) as? AddFoodEventCell)?.input as? String
        }
    }
    
    internal func getCurrentData() {
        (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddFoodEventCell)?.input = newCalendarEvent.summary
        (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AddFoodEventCell)?.input = newCalendarEvent.location
        (tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? AddFoodEventCell)?.input = newCalendarEvent.allDay
        (tableView.cellForRow(at: IndexPath(row: 1, section: 2)) as? AddFoodEventCell)?.input = newCalendarEvent.notes
        
    }
    
}
