//
//  MonthController.swift
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit
import AppsoluteCalendar

// This is a subclass of AppsoluteCalendarMonthVC which supports communication with other calendar controllers via CalendarComponentControllerDelegate property.

@objc open class MonthController: AppsoluteCalendarMonthVC {

    // CalendarComponentControllerDelegate property.
    open weak var delegate: CalendarComponentControllerDelegate?
    // This property holds the last date to be shown the next time this controller shows up.
    open var lastSavedDate: Date?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reloadController()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Scroll to the lastSavedDate if any.
        guard lastSavedDate != nil else { return }
        monthView.reloadData()
        monthView.scrollToDateAnimated(lastSavedDate!, animated: true)
    }
    
    // MARK:- CalendarComponentControllerDelegate calls.

    open func calendarComponentControllerWantsTransition(_ controller: AppsoluteCalendarTemplateViewController, toDate date: Date) {
        guard let delegate = self.delegate else { return }
        if delegate.responds(to: #selector(calendarComponentControllerWantsTransition(_:toDate:))) {
            delegate.calendarComponentControllerWantsTransition!(controller, toDate: date)
        }
    }
    
    // MARK:- AppsoluteCAlendarMonthDelegate method implementation, it asks the delegate to transit with the date got from the monthView.
        
    override open func calendarDidSelectDate(_ calendar: AppsoluteCalendarMonth, date: Date, eventsForDate: NSMutableArray) {
        calendarComponentControllerWantsTransition(self, toDate: date)
    }
    
    // MARK: Reload the controller when asked.
    
    open func reloadController() {
        let titleLabel = UILabel()
        titleLabel.text = "AppCalDemo"
        titleLabel.font = FontBook.boldFont(ofSize: 18)
        titleLabel.textColor = Settings.mainColor
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.tintColor = Settings.mainColor
        guard monthView != nil else { return }
        monthView.reloadData()
    }

}
