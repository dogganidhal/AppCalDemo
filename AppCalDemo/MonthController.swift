//
//  MonthController.swift
//  AppCalDemo
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit
import AppsoluteCalendar

class MonthController: BaseController, AppsoluteCalendarMonthDelegate, AppsoluteCalendarMonthDataSource {
    
    internal var appCal: AppsoluteCalendar?
    let monthView = AppsoluteCalendarMonth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.        
        appCal = AppsoluteCalendar()
        appCal?.isSubclassed(true)
        
        view.backgroundColor = .white
        view.addSubview(monthView)
        
        monthView.myDelegate = self
        monthView.myDataSource = self
                
        monthView.translatesAutoresizingMaskIntoConstraints = false
        
        monthView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        monthView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        monthView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        monthView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
    func calendarShouldMarkDate(_ calendar: AppsoluteCalendarMonth, date: Date) -> Bool {
        return false
    }
    
    
}
