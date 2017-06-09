//
//  YearController.swift
//  AppCalDemo
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit
import AppsoluteCalendar

@objc open class YearController: BaseController, AppsoluteCalendarDelegate,CalendarControllerDelegate, AppsoluteCalendarMonthDelegate, AppsoluteCalendarMonthDataSource {
    
    open var appCal: AppsoluteCalendar = AppDelegate.appCal
    open lazy var monthView: AppsoluteCalendarMonth = AppsoluteCalendarMonth(frame: self.visibleFrame)
    open lazy var yearView: AppsoluteCalendarYear = AppsoluteCalendarYear(frame: self.visibleFrame)
    open lazy var dayView: AppsoluteCalendarDay = AppsoluteCalendarDay(frame: self.dayFrame)
    
    internal var calendarController: CalendarController? {
        return self.navigationController as? CalendarController
    }
    internal var visibleFrame: CGRect {
        return CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height - 153)
    }
    internal var dayFrame: CGRect {
        return CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height - 144)
    }
    
    fileprivate var lastSelectedIndex: UInt = 1

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        // Appsolute calendar setup
        appCal.setCustomizationFromSettings()
        appCal.calDelegate = self
        
        // Appsolute views setup
        view.addSubview(monthView)
        view.addSubview(dayView)
        view.addSubview(yearView)
        
        monthView.myDelegate = self
        monthView.myDataSource = self
        
//        dayView.isHidden = true
//        yearView.isHidden = true
        
        dayView.frame.origin.x += view.frame.width
        yearView.frame.origin.x -= view.frame.width
        
        self.calendarController?.segmentDelegate = self
        

        
        
    }
    
    @objc open func reloadCalendar() {
        appCal.setCustomizationFromSettings()
        yearView.reloadData()
        monthView.reloadData()
        //dayView.reloadData()
    }
    

    // MARK:- Appsolute calendar month data source methods
    
    public func calendarShouldMarkDate(_ calendar: AppsoluteCalendarMonth, date: Date) -> Bool {
        return false
    }
    
    // MARK:- Appsolute calendar delegate methods
    public func didChangeSegmentedControlValue(_ newValue: UInt) {
        /*
        switch newValue {
        case 0:
            yearView.isHidden = false
            monthView.isHidden = true
            dayView.isHidden = true
        case 1:
            yearView.isHidden = true
            monthView.isHidden = false
            dayView.isHidden = true
        default:
            yearView.isHidden = true
            monthView.isHidden = true
            dayView.isHidden = false
        }
        */
        UIView.animate(withDuration: 0.5) { 
            self.dayView.frame.origin.x += CGFloat(self.lastSelectedIndex - newValue) * self.view.frame.width
            self.monthView.frame.origin.x += CGFloat(self.lastSelectedIndex - newValue) * self.view.frame.width
            self.yearView.frame.origin.x += CGFloat(self.lastSelectedIndex - newValue) * self.view.frame.width
        }
    }
    
}


public extension AppsoluteCalendar {
    public func setCustomizationFromSettings() {
        self.setEventTextFont(FontBook.regularFont(ofSize: 16))
        self.setMonthNameFont(FontBook.regularFont(ofSize: 16))
        self.setEventHeadlineFont(FontBook.regularFont(ofSize: 16))
        
        self.setMonthNameColor(Settings.monthNameColor)
        self.setMonthSeparatorTintColor(Settings.monthSeparatorColor)
        
        self.setHourTextColor(Settings.hourTextColor)
        self.setHourSeparatorColor(Settings.hourSeparatorColor)
        
        
        self.setCalendarFontColor(Settings.calendarFontColor)
        self.setCalendarTintColor(Settings.calendarTintColor)
        self.setCalendarEventColor(Settings.calendarEventColor)
        self.setCalendarButtonTintColor(Settings.calendarButtonTintColor)
        
        self.setCurrentDayFontColor(Settings.currentDayFontColor)
        self.setCurrentDayCircleColor(Settings.currentDayCircleColor)
        
        self.setOverallBackgroundColor(Settings.overallBackgroundColor)
    }
}








