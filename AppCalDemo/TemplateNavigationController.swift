//
//  TemplateNavigationController.swift
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

// This class is a subclass of TemplateController and the super every NavigationController with calendar views.

@objc open class TemplateNavigationController: TemplateController, AppsoluteCalendarDelegate, CalendarComponentControllerDelegate, UINavigationControllerDelegate {
    // Children View controllers
    open var yearController: YearController = YearController()
    open var monthController: MonthController = MonthController()
    open var dayController: DayController = DayController()
    // Data & date objects communicating between the ChildrenViewControllers.
    internal var lastUsedDate: Date? = Date()
    internal var lastUsedData: AnyObject?
    internal var events: NSMutableArray = NSMutableArray()
    // Calendar object for every instance to display different events.
    internal var appCal: AppsoluteCalendar = AppsoluteCalendar()
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Pushing the year view to be displayed first.
        pushViewController(yearController, animated: false)
        yearController.delegate = self
        monthController.delegate = self
        dayController.delegate = self
        delegate = self
        // Calendar object setup
        appCal.calDelegate = self
        appCal.isSubclassed(true)
        appCal.setAddButtonVisibility(false)
        appCal.enableCalendarAnimations(true)
    }
    
    // MARK:- Calendar component controller delegate methods for override later.
    
    public func calendarComponentControllerWantsTransition(_ controller: AppsoluteCalendarTemplateViewController, toDate date: Date) {
        
    }
    
    public func calendarComponentControllerShouldPassData(_ controller: AppsoluteCalendarTemplateViewController, dataToPass data: AnyObject) {
        lastUsedData = data
    }
    
    // MARK:- Navigation controller delegate methods for override later.
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
    
    // MARK: Reload the view whenever the parent TabBarController asks for it.
    
    open override func reload() {
        super.reload()
        self.appCal.setCustomizationOnCalendar()
        self.appCal.updateOnStyleChanges()
    }
    
}
