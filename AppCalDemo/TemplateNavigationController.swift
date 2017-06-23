//
//  TemplateNavigationController.swift
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

@objc open class TemplateNavigationController: TemplateController, AppsoluteCalendarDelegate, CalendarComponentControllerDelegate, UINavigationControllerDelegate {
    
    open var yearController: YearController = YearController()
    open var monthController: MonthController = MonthController()
    open var dayController: DayController = DayController()
    internal var lastUsedDate: Date? = Date()
    internal var lastUsedData: AnyObject?
    internal var appCal: AppsoluteCalendar = AppsoluteCalendar()
    internal var events: NSMutableArray = NSMutableArray()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pushViewController(yearController, animated: false)
        yearController.delegate = self
        monthController.delegate = self
        dayController.delegate = self
        delegate = self
        
        appCal.calDelegate = self
        appCal.isSubclassed(true)
        appCal.setAddButtonVisibility(false)
        appCal.enableCalendarAnimations(true)
    }
    
    public func calendarComponentControllerWantsTransition(_ controller: AppsoluteCalendarTemplateViewController, toDate date: Date) {
        
    }
    
    public func calendarComponentControllerShouldPassData(_ controller: AppsoluteCalendarTemplateViewController, dataToPass data: AnyObject) {
        lastUsedData = data
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
    
    open override func reload() {
        super.reload()
        self.appCal.setCustomizationOnCalendar()
    }
    
}
