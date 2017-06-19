//
//  FootballController.swift
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

class FootballController: TemplateNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let data = FootballDataManager().events
        for item in data as! NSMutableArray {
            events.add(NSMutableDictionary(dictionary: item as! NSDictionary))
        }
        appCal.reloadEvents(events)
    }
    
    public override func calendarComponentControllerWantsTransition(_ controller: AppsoluteCalendarTemplateViewController, toDate date: Date) {
        if controller is YearController {
            pushViewController(monthController, animated: false)
        } else if controller is MonthController {
            pushViewController(dayController, animated: true)
        } else {
            pushViewController(FootballFixtureController(), animated: true)
        }
        lastUsedDate = date
    }

    override func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Configure the detail view ?
        if viewController is MonthController {
            monthController.monthView.scrollToDateAnimated(lastUsedDate!, animated: true)
        } else if viewController is DayController {
            // TODO: Scroll to the last used date
        } else if !(viewController is YearController) {
            // DetailController
            (viewController as! FootballFixtureController).eventToDisplay = lastUsedData as? AppsoluteCalendarDefaultObject
        }
    }
    
    func addEvent() {
        pushViewController(BaseController(), animated: true)
    }
    
}
