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
    
//    lazy var detailView: AppsoluteCalendarDetail = AppsoluteCalendarDetail(frame: self.view.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.addSubview(detailView)
//        detailView.myDelegate = self
    }
    
    public func detailViewWillEditEvent(_ detailView: AppsoluteCalendarDetail, eventsForDate: AppsoluteCalendarDefaultObject) {
        
    }
    
    public func detailViewWillDeleteEvent(_ detailView: AppsoluteCalendarDetail, eventsForDate: AppsoluteCalendarDefaultObject) {
        
    }
    
    public func detailViewWillDeleteOneEvent(_ detailView: AppsoluteCalendarDetail, eventsForDate: AppsoluteCalendarDefaultObject) {
        
    }
    
    public func detailViewWillDeleteFollowingEvent(_ detailView: AppsoluteCalendarDetail, eventsForDate: AppsoluteCalendarDefaultObject) {
        
    }
    
    
    
}
