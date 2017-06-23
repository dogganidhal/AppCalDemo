//
//  YearController.swift
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit
import AppsoluteCalendar

// This is a subclass of AppsoluteCalendarYearVC which supports communication with other calendar controllers via CalendarComponentControllerDelegate property.

open class YearController: AppsoluteCalendarYearVC {
    
    // CalendarComponentControllerDelegate property.
    open weak var delegate: CalendarComponentControllerDelegate?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        reloadController()
    }
    
    // MARK:- CalendarComponentControllerDelegate calls.
    
    open func calendarComponentControllerWantsTransition(_ controller: AppsoluteCalendarTemplateViewController, toDate date: Date) {
        guard let delegate = self.delegate else { return }
        if delegate.responds(to: #selector(calendarComponentControllerWantsTransition(_:toDate:))) {
            delegate.calendarComponentControllerWantsTransition!(controller, toDate: date)
        }
    }

    // MARK:- AppsoluteCalendarYearDelegate method implementation, here where this controller asks the delegate to transit with the date we get from the yearView.
    
    open override func calendarDidSelectMonth(_ calendar: AppsoluteCalendarYear, month: Int, year: Int) {
        var dateComps = DateComponents()
        dateComps.year = year
        dateComps.month = month + 1
        let calendar = Calendar(identifier: .gregorian)
        calendarComponentControllerWantsTransition(self, toDate: calendar.date(from: dateComps)!)
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
    }
    
}
