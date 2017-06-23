//
//  CalendarComponentControllerDelegate.swift
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit
import AppsoluteCalendar

// This protocol allows to pass dates and events between controllers wrapped in a NavigationController for instance.

@objc public protocol CalendarComponentControllerDelegate: NSObjectProtocol {
    
    
    // Tells the delegate that it should transit to the date passed in parameter.
    @objc(calendarComponentControllerWantsTransition:toDate:)
    optional func calendarComponentControllerWantsTransition(_ controller: AppsoluteCalendarTemplateViewController, toDate date: Date)
    
    // Tells the delegate that is has to get some data (event) in this call.
    @objc(calendarComponentControllerShouldPassData:dataToPass:)
    optional func calendarComponentControllerShouldPassData(_ controller: AppsoluteCalendarTemplateViewController, dataToPass data: AnyObject)
    
}
