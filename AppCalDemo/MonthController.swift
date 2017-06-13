//
//  MonthController.swift
//  AppCalDemo
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit
import AppsoluteCalendar

class MonthController: CalendarController {
    
    var manager = FootballDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    /*
     NSCalendar *nsCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
     NSInteger dateDay = [nsCalendar component:NSCalendarUnitDay fromDate:date];
     BOOL found = NO;
     for (NSMutableDictionary *event in [self.manager calendarEvents]) {
     NSInteger eventDay = [nsCalendar component:NSCalendarUnitDay fromDate:[event objectForKey:@"STARTDATE"]];
     if (eventDay == dateDay) {
     found = YES;
     break;
     }
     }
     return found;
     */
    
    
    
    
}
