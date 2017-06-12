//
//  YearController.swift
//  AppCalDemo
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit
import AppsoluteCalendar

@objc open class YearController: BaseController, AppsoluteCalendarDelegate , AppsoluteCalendarMonthDelegate, AppsoluteCalendarMonthDataSource, UINavigationControllerDelegate, AppsoluteCalendarYearViewDelegate {
    
    open var appCal: AppsoluteCalendar = AppsoluteCalendar(url: "http://test-baikal.calframe.info/cal.php/", calName: "default", userName: "test", password: "niyOhYQ%X7MDbCcSYQbW", barTintColor: Settings.mainColor)
//    open var appCal: AppsoluteCalendar = AppsoluteCalendar()
    open lazy var monthView: AppsoluteCalendarMonth = AppsoluteCalendarMonth(frame: self.visibleFrame)
    open lazy var yearView: AppsoluteCalendarYear = AppsoluteCalendarYear(frame: self.visibleFrame)
    open lazy var dayView: AppsoluteCalendarDay = AppsoluteCalendarDay(frame: self.dayFrame)
    
    internal var visibleFrame: CGRect {
        print(CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height - 153))
        return CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height - 153)
    }
    internal var dayFrame: CGRect {
        return CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height - 153)
    }
    
    fileprivate var lastSelectedIndex: Int = 1
    fileprivate var events: NSMutableArray = []

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = Settings.overallBackgroundColor
        // Appsolute calendar setup
        appCal.setCustomizationFromSettings()
        appCal.calDelegate = self
        appCal.setAddButtonVisibility(true)
        
        // Appsolute views setup
        view.addSubview(monthView)
        view.addSubview(dayView)
        view.addSubview(yearView)
        
        monthView.myDelegate = self
        monthView.myDataSource = self
        yearView.myDelegate = self
        
        dayView.frame.origin.x += view.frame.width
        yearView.frame.origin.x -= view.frame.width
        
        self.navigationController?.delegate = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEvent))
        
        
    }
    
    @objc open func reloadCalendar() {
        appCal.setCustomizationFromSettings()
        yearView.reloadData()
        monthView.reloadData()
        //dayView.reloadData()
    }
    
    @objc internal func addEvent() {
        self.navigationController!.pushViewController(NewEventController(), animated: true)
    }
    
//    public func returnNewEvent(_ event: NSMutableDictionary) {
//        events.add(event)
//        appCal.reloadEvents(events)
//        print(events)
//    }

    // MARK:- Appsolute calendar month data source methods
    
    public func calendarShouldMarkDate(_ calendar: AppsoluteCalendarMonth, date: Date) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        
        return calendar.component(.day, from: date) == 9 && calendar.component(.month, from: date) == 6
    }
    
    public func calendarDidSelectDate(_ calendar: AppsoluteCalendarMonth, date: Date, eventsForDate: NSMutableArray) {
    }
    
    // MARK:- Appsolute calendar year view delelgate methods
    
    public func calendarDidSelectMonth(_ calendar: AppsoluteCalendarYear, month: Int, year: Int) {
    }
    
    // MARK:- Calendar controller delegate methods
    
    public func didChangeSegmentedControlValue(_ newValue: Int) {
        UIView.animate(withDuration: 0.3) {
            self.dayView.frame.origin.x += CGFloat(self.lastSelectedIndex - newValue) * self.view.frame.width
            self.monthView.frame.origin.x += CGFloat(self.lastSelectedIndex - newValue) * self.view.frame.width
            self.yearView.frame.origin.x +=  CGFloat(self.lastSelectedIndex - newValue) * self.view.frame.width
        }
        lastSelectedIndex = newValue
    }
    
    // MARK:- Navigation controller delegate
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == self {
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
        
    }
    
}







