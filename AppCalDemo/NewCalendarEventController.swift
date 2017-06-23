//
//  NewCalendarEventController.swift
//  AppCalDemo
//
//  Created by Nidhal on 21.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

// This class is a subclass of UITableViewController, which handles the creation of a new GenericEvent and saves it to the core data.

@objc open class NewCalendarEventController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DatePickerControllerDelegate, AddFoodEventCellDelegate {
    
    // A private property holding the titles of cells which have to indicate it's content.
    private var sectionsTitles = [[nil, nil], ["All Day", "Start", "End", ], [nil, nil, "Add a photo"]]
    
    // This is the new event created and to be pushed if submitted.
    open var newCalendarEvent: GenericEvent!
    // Shortcuts to the appDelegate and the viewContext
    private unowned var appDelegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    private unowned var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Setting the submit button.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(handleSubmit))
        // Initiaizing the new GenericEvent.
        newCalendarEvent = GenericEvent(entity: GenericEvent.entity(), insertInto: nil)
        newCalendarEvent.startDate = Date()
        newCalendarEvent.endDate = Date()
        newCalendarEvent.allDay = false
        reloadController()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Gets the current saved data into the newFoodEvent property when the view appears, typically from the date picker or the image picker controllers.
        getCurrentData()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Saves the current data into the newFoodEvent property when the view has to disappear, typically to show the date picker or the image picker controllers.
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
                // In case the cells responsible of dates is selected.
                let datePickerController = DatePickerController()
                datePickerController.delegate = self
                datePickerController.senderIdentifier = indexPath.row == 1 ? "start" : "end"
                navigationController?.pushViewController(datePickerController, animated: true)
            default:
                break
            }
        case 2:
            if indexPath.row == 2 {
                // In case the cell responsible of the image is selected.
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                present(imagePickerController, animated: true, completion: nil)
            }
            break
        default:
            break
        }
    }
    
    // MARK: Reload the controller when asked.
    
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
    
    // Handles the validation and saves into the core data context.
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
        context.insert(newCalendarEvent)
        appDelegate.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    // Sets up the cell passed in parameter to display the proper accessory view and content for each indexPath.
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
    
    // In this method we save the data of the selecetd image and display a little preview in the left side of the cell.
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        newCalendarEvent.image = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage)
        picker.dismiss(animated: true, completion: nil)
        tableView.reloadRows(at: [IndexPath(row: 2, section: 2)], with: .none)
    }
    
    // MARK: DatePickerController delegate method
    
    // Reloads the tableView when the dat picker has picked a new date.
    public func datePicker(_ datePickerController: DatePickerController, didChooseDate date: Date, forIdentifier identifier: String?) {
        if identifier == "start" {
            newCalendarEvent.startDate = date
        } else {
            newCalendarEvent.endDate = date
        }
        tableView.reloadData()
    }
    
    // MARK: AddFoodEventCell delegate method
    
    // This method is called when a cell is about to be unfosued, so it saves the input to the new instance of MealEvent.
    public func addFoodEventCell(_ addFoodEventCell: AddFoodEventCell, shouldSaveData input: Any?) {
        saveDataIntoEvent()
    }
    
    // Saves data to the new created event
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
    
    // Saves data from the new created event
    internal func getCurrentData() {
        (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddFoodEventCell)?.input = newCalendarEvent.summary
        (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AddFoodEventCell)?.input = newCalendarEvent.location
        (tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? AddFoodEventCell)?.input = newCalendarEvent.allDay
        (tableView.cellForRow(at: IndexPath(row: 1, section: 2)) as? AddFoodEventCell)?.input = newCalendarEvent.notes
        
    }
    
}
