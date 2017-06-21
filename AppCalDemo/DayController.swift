//
//  DayController.swift
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

open class DayController: AppsoluteCalendarDayVC {
    
    open weak var delegate: CalendarComponentControllerDelegate?
    open var receivedDate: Date?

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reloadController()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dayView.reloadDays()
        guard self.receivedDate != nil else { return }
        dayView.receivedDate = receivedDate!
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    open func calendarComponentControllerWantsTransition(_ controller: AppsoluteCalendarTemplateViewController, toDate date: Date) {
        guard let delegate = self.delegate else { return }
        if delegate.responds(to: #selector(calendarComponentControllerWantsTransition(_:toDate:))) {
            delegate.calendarComponentControllerWantsTransition!(controller, toDate: date)
        }
    }
    
    open func calendarComponentControllerShouldPassData(_ controller: AppsoluteCalendarTemplateViewController, dataToPass data: AnyObject) {
        guard let delegate = self.delegate else { return }
        if delegate.responds(to: #selector(calendarComponentControllerShouldPassData(_:dataToPass:))) {
            delegate.calendarComponentControllerShouldPassData!(controller, dataToPass: data)
        }
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
    
    override open func dayViewDidSelectDefaultEvent(_ dayView: AppsoluteCalendarDay, date: Date, eventsForDate: AppsoluteCalendarDefaultObject) {
        calendarComponentControllerShouldPassData(self, dataToPass: eventsForDate)
        calendarComponentControllerWantsTransition(self, toDate: date)
    }

}
