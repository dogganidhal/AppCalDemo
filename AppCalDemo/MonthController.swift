//
//  MonthController.swift
//  AppCalDemo
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit
import AppsoluteCalendar

class MonthController: BaseController, AppsoluteCalendarDetailViewDelegate {
    
    internal var appCal: AppsoluteCalendar?
    internal var monthView: AppsoluteCalendarMonth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ***
        appCal = AppsoluteCalendar()
        appCal?.setCalVisible()
        appCal?.setAddButtonVisibility(true)
        // ****
        monthView = AppsoluteCalendarMonth(frame: view.frame)
        view.addSubview(monthView)
    }
    
    public func detailViewWillEditEvent(_ detailView: AppsoluteCalendarDetail, eventsForDate: AppsoluteCalendarDefaultObject) {
        print("will edit event")
    }
    
    public func detailViewWillDeleteEvent(_ detailView: AppsoluteCalendarDetail, eventsForDate: AppsoluteCalendarDefaultObject) {
        print("will delete event")
    }
    
    public func detailViewWillDeleteOneEvent(_ detailView: AppsoluteCalendarDetail, eventsForDate: AppsoluteCalendarDefaultObject) {
        print("will delete one event")
    }
    
    public func detailViewWillDeleteFollowingEvent(_ detailView: AppsoluteCalendarDetail, eventsForDate: AppsoluteCalendarDefaultObject) {
        print("will delete following event")
    }
    
    
    
}
