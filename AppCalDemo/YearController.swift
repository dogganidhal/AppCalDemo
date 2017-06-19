//
//  YearController.swift
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit
import AppsoluteCalendar

open class YearController: AppsoluteCalendarYearVC {
    
    open weak var delegate: CalendarComponentControllerDelegate?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        reloadController()
        
    }
    
    open func calendarComponentControllerWantsTransition(_ controller: AppsoluteCalendarTemplateViewController, toDate date: Date) {
        guard let delegate = self.delegate else { return }
        if delegate.responds(to: #selector(calendarComponentControllerWantsTransition(_:toDate:))) {
            delegate.calendarComponentControllerWantsTransition!(controller, toDate: date)
        }
    }

    open override func calendarDidSelectMonth(_ calendar: AppsoluteCalendarYear, month: Int, year: Int) {
        var dateComps = DateComponents()
        dateComps.year = year
        dateComps.month = month + 1
        let calendar = Calendar(identifier: .gregorian)
        calendarComponentControllerWantsTransition(self, toDate: calendar.date(from: dateComps)!)
    }
    
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
