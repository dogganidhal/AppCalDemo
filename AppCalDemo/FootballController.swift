//
//  FootballController.swift
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

// This class is a subclass of TemplateNavigationController, it handles the dislpay of static events, from local JSON files of the last season's football fixtures as events suing AppsoluteCalendar.

@objc open class FootballController: TemplateNavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Filling the Events from the football data manager.
        let data = FootballDataManager().events
        for item in data as! NSMutableArray {
            events.add(NSMutableDictionary(dictionary: item as! NSDictionary))
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reloads the events whenver the view is about to be shown
        appCal.reloadEvents(events)
        monthController.monthView?.reloadData()
        yearController.yearView?.reloadData()
        dayController.dayView?.reloadDays()
        
    }
    
    // MARK:- CalendarComponentControllerDelegate method.
    
    // In this method we push the proper controller and pass the necessary data.
    public override func calendarComponentControllerWantsTransition(_ controller: AppsoluteCalendarTemplateViewController, toDate date: Date) {
        if controller is YearController {
            pushViewController(monthController, animated: false)
        } else if controller is MonthController {
            dayController.receivedDate = date
            pushViewController(dayController, animated: true)
        } else {
            pushViewController(FootballFixtureController(), animated: true)
        }
        lastUsedDate = date
    }
    
    // MARK:- UINavigationControllerDelegate method. 

    // Additional setup after the new Controller is shown.
    override public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController is MonthController {
            monthController.monthView.scrollToDateAnimated(lastUsedDate!, animated: true)
        } else if viewController is FootballFixtureController {
            (viewController as! FootballFixtureController).eventToDisplay = lastUsedData as? AppsoluteCalendarDefaultObject
        }
    }
    
}
