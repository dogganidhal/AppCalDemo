//
//  DayController.swift
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

// This is a subclass of AppsoluteCalendarDayVC which supports communication with other calendar controllers via CalendarComponentControllerDelegate property.

@objc open class DayController: AppsoluteCalendarDayVC {
    
    // CalendarComponentControllerDelegate property.
    open weak var delegate: CalendarComponentControllerDelegate?

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reloadController()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Just before the DayController appears, reload the dayView to show proper data and date.
//        dayView.reloadDays()
    }
    
    // MARK:- CalendarComponentControllerDelegate calls.
    
    open func calendarComponentControllerWantsTransition(_ controller: AppsoluteCalendarTemplateViewController, toDate date: Date) {
        guard let delegate = self.delegate else { return }
        if delegate.responds(to: #selector(calendarComponentControllerWantsTransition(_:toDate:))) {
            delegate.calendarComponentControllerWantsTransition!(controller, toDate: date)
        }
    }
    
    // In this method, we pass the selected event to the delegate to be shown in a more detailed way via a DetailController.
    open func calendarComponentControllerShouldPassData(_ controller: AppsoluteCalendarTemplateViewController, dataToPass data: AnyObject) {
        guard let delegate = self.delegate else { return }
        if delegate.responds(to: #selector(calendarComponentControllerShouldPassData(_:dataToPass:))) {
            delegate.calendarComponentControllerShouldPassData!(controller, dataToPass: data)
        }
    }
    
    // MARK:- AppsoluteCalendarDayDelegate method implementation, here where this controller asks the delegate to transit with the date and data we get from the selecetd event.
    
    override open func dayViewDidSelectDefaultEvent(_ dayView: AppsoluteCalendarDay, date: Date, eventsForDate: AppsoluteCalendarDefaultObject) {
        calendarComponentControllerShouldPassData(self, dataToPass: eventsForDate)
        calendarComponentControllerWantsTransition(self, toDate: date)
    }
    
    func reloadController() {
        let titleLabel = UILabel()
        titleLabel.text = "AppCalDemo"
        titleLabel.font = FontBook.boldFont(ofSize: 18)
        titleLabel.textColor = Settings.mainColor
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.tintColor = Settings.mainColor

    }
    
    

}
