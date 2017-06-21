//
//  MonthController.swift
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit
import AppsoluteCalendar

open class MonthController: AppsoluteCalendarMonthVC {

    open weak var delegate: CalendarComponentControllerDelegate?
    open var lastSavedDate: Date?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reloadController()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard lastSavedDate != nil else { return }
        monthView.reloadData()
        monthView.scrollToDateAnimated(lastSavedDate!, animated: true)
    }

    open func calendarComponentControllerWantsTransition(_ controller: AppsoluteCalendarTemplateViewController, toDate date: Date) {
        guard let delegate = self.delegate else { return }
        if delegate.responds(to: #selector(calendarComponentControllerWantsTransition(_:toDate:))) {
            delegate.calendarComponentControllerWantsTransition!(controller, toDate: date)
        }
    }
        
    override open func calendarDidSelectDate(_ calendar: AppsoluteCalendarMonth, date: Date, eventsForDate: NSMutableArray) {
        calendarComponentControllerWantsTransition(self, toDate: date)
    }
    
    open func reloadController() {
        let titleLabel = UILabel()
        titleLabel.text = "AppCalDemo"
        titleLabel.font = FontBook.boldFont(ofSize: 18)
        titleLabel.textColor = Settings.mainColor
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.tintColor = Settings.mainColor
        monthView.reloadData()
    }

}
