//
//  DatePickerController.swift
//  AppCalDemo
//
//  Created by Nidhal on 19.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

@objc public protocol DatePickerControllerDelegate: NSObjectProtocol {

    @objc optional func datePicker(_ datePickerController: DatePickerController, didChooseDate date: Date, forIdentifier identifier: String?)
    
}

@objc open class DatePickerController: BaseController {
    
    open var datePicker: UIDatePicker = UIDatePicker()
    open weak var delegate: DatePickerControllerDelegate?
    open var senderIdentifier: String?

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDone))
    }
    
    internal func datePicker(_ datePickerController: DatePickerController, didChooseDate date: Date, forIdentifier identifier: String?) {
        guard let delegate = self.delegate else { return }
        if delegate.responds(to: #selector(datePicker(_:didChooseDate:forIdentifier:))) {
            delegate.datePicker!(self, didChooseDate: datePicker.date, forIdentifier: senderIdentifier ?? "")
        }
    }
    
    @objc private func handleDone() {
        navigationController?.popViewController(animated: true)
        datePicker(self, didChooseDate: datePicker.date, forIdentifier: senderIdentifier)
    }

}
