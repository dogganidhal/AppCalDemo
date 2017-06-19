//
//  CalendarComponentControllerDelegate.swift
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit
import AppsoluteCalendar


@objc public protocol CalendarComponentControllerDelegate: NSObjectProtocol {
    
    @objc(calendarComponentControllerWantsTransition:toDate:)
    optional func calendarComponentControllerWantsTransition(_ controller: AppsoluteCalendarTemplateViewController, toDate date: Date)
    
    @objc(calendarComponentControllerShouldPassData:dataToPass:)
    optional func calendarComponentControllerShouldPassData(_ controller: AppsoluteCalendarTemplateViewController, dataToPass data: AnyObject)
    
}
