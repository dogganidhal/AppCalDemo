//
//  FoodController.h
//  AppCalDemo
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "BaseController.h"
#import "CalendarController.h"
#import <AppsoluteCalendar/AppsoluteCalendar.h>
#import "AppsoluteCalendar+FoodCalendar.h"

@interface FoodController : BaseController<CalendarNavigationBarDelegate,
                                           AppsoluteCalendarMonthDelegate,
                                           AppsoluteCalendarMonthDataSource,
                                           AppsoluteCalendarDayDelegate,
                                           AppsoluteCalendarYearViewDelegate>

@property (nonatomic, strong) AppsoluteCalendarDay *dayView;
@property (nonatomic, strong) AppsoluteCalendarMonth *monthView;
@property (nonatomic, strong) AppsoluteCalendarYear *yearView;
@property (nonatomic, strong) AppsoluteCalendar *foodCalendar;

@end
