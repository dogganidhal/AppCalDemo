//
//  AppsoluteCalendar+AppCalDemo.m
//  AppCalDemo
//
//  Created by Nidhal on 12.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <AppsoluteCalendar/AppsoluteCalendar.h>
#import "AppsoluteCalendar+AppCalDemo.h"
#import "Settings.h"
#import "FontBook.h"

@implementation AppsoluteCalendar (AppCalDemo)

static AppsoluteCalendar *_shared;

+ (void)initialize {
    _shared = [[AppsoluteCalendar alloc] init];
}

+ (AppsoluteCalendar *)shared {
    return _shared;
}

- (void)setCustomizationOnCalendar {
    [self setEventTextFont:[FontBook regularFontOfSize:16]];
    [self setMonthNameFont:[FontBook regularFontOfSize:16]];
    [self setEventHeadlineFont:[FontBook regularFontOfSize:16]];
    
    [self setMonthNameColor:Settings.monthNameColor];
    [self setMonthSeparatorTintColor:Settings.monthSeparatorColor];
    
    [self setHourTextColor:Settings.hourTextColor];
    [self setHourSeparatorColor:Settings.hourSeparatorColor];
    
    [self setCalendarFontColor:Settings.calendarFontColor];
    [self setCalendarTintColor:Settings.calendarTintColor];
    [self setCalendarEventColor:Settings.calendarEventColor];
    [self setCalendarButtonTintColor:Settings.calendarButtonTintColor];
    
    [self setCurrentDayFontColor:Settings.currentDayFontColor];
    [self setCurrentDayCircleColor:Settings.currentDayCircleColor];
    
    [self setOverallBackgroundColor:Settings.overallBackgroundColor];
    [self setNavBarTodayBarColor:Settings.todaysBarColor];
    
    [self setFirstDayInWeek:Settings.firstDayOfTheWeek];
}

@end
