//
//  CalendarController.h
//  AppCalDemo
//
//  Created by Nidhal on 12.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <AppsoluteCalendar/AppsoluteCalendar.h>
#import "BaseController.h"
#import "CalendarNavigationBar.h"

@interface CalendarTemplateController : BaseController<CalendarNavigationBarDelegate,
                                               AppsoluteCalendarMonthDelegate,
                                               AppsoluteCalendarMonthDataSource,
                                               AppsoluteCalendarDayDelegate,
                                               AppsoluteCalendarYearViewDelegate>

@property (nonatomic, strong) AppsoluteCalendarDay *dayView;
@property (nonatomic, strong) AppsoluteCalendarMonth *monthView;
@property (nonatomic, strong) AppsoluteCalendarYear *yearView;
@property (nonatomic, strong) AppsoluteCalendar *appCal;

@end
