//
//  DatePickerController.swift
//  AppCalDemo
//
//  Created by Nidhal on 19.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

// This protocol allows the passing of dates between controllers.

@objc public protocol DatePickerControllerDelegate: NSObjectProtocol {

    // Tells the delegate that a date is selected and ready for use.
    @objc optional func datePicker(_ datePickerController: DatePickerController, didChooseDate date: Date, forIdentifier identifier: String?)
    
}

// This class is a simple wrapper of UIDatePicker, which allows the delegate to get the dates picked via conforming to the DatePickerControllerDelegate.

@objc open class DatePickerController: BaseController {
    
    // UIDatePicker instance.
    open var datePicker: UIDatePicker = UIDatePicker()
    // DatePickerControllerDelegate property.
    open weak var delegate: DatePickerControllerDelegate?
    // This property differenciates which object sent this controller and should get this data.
    open var senderIdentifier: String?

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Basic setup of the date picker.
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        // Setup of the done button.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDone))
    }
    
    // MARK:- DatePickerControllerDelegate method.
    
    internal func datePicker(_ datePickerController: DatePickerController, didChooseDate date: Date, forIdentifier identifier: String?) {
        guard let delegate = self.delegate else { return }
        if delegate.responds(to: #selector(datePicker(_:didChooseDate:forIdentifier:))) {
            delegate.datePicker!(self, didChooseDate: datePicker.date, forIdentifier: senderIdentifier ?? "")
        }
    }
    
    // This method handles the notification of the delegate that a user has submitted a date.
    @objc private func handleDone() {
        navigationController?.popViewController(animated: true)
        datePicker(self, didChooseDate: datePicker.date, forIdentifier: senderIdentifier)
    }

}
