//
//  CalendarEvent.m
//  AppCalDemo
//
//  Created by Nidhal on 12.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "CalendarEvent.h"

@implementation CalendarEvent

+ (instancetype)EventFromDictionary:(NSDictionary *)event {
    CalendarEvent *newEvent = [super init];
    newEvent.allday = [event objectForKey:@"ALLDAY"];
    newEvent.UID = [event objectForKey:@"UID"];
    newEvent.endDate = [event objectForKey:@"ENDDATE"];
    newEvent.startDate = [event objectForKey:@"STARTDATE"];
    newEvent.summary = [event objectForKey:@"SUMMARY"];
    newEvent.startTimeString = [event objectForKey:@"startTimeString"];
    newEvent.notes = [event objectForKey:@"NOTES"];
    newEvent.location = [event objectForKey:@"LOCATION"];
    newEvent.endTimeString = [event objectForKey:@"endTimeString"];
    newEvent.recurrencyString = [event objectForKey:@"recurrency_STRING"];
    return newEvent;
}

+ (NSArray<CalendarEvent *> *)eventsWithDictionaries:(NSArray<NSDictionary *>*)events {
    NSMutableArray<CalendarEvent *> *calendarEvents = [[NSMutableArray alloc] init];
    for (NSDictionary *subEvent in events) {
        [calendarEvents addObject:[CalendarEvent EventFromDictionary:subEvent]];
    }
    return calendarEvents;
}


- (NSDictionary *)toDictionary {
    NSMutableDictionary *event = [[NSMutableDictionary alloc] init];
    [event setObject:@(self.allday) forKey:@"ALLDAY"];
    [event setObject:self.UID forKey:@"UID"];
    [event setObject:self.endTimeString forKey:@"endTimeString"];
    [event setObject:self.startTimeString forKey:@"startTimeString"];
    [event setObject:self.endDate forKey:@"ENDDATE"];
    [event setObject:self.startDate forKey:@"STARTDATE"];
    [event setObject:self.summary forKey:@"SUMMARY"];
    [event setObject:self.notes forKey:@"NOTES"];
    [event setObject:self.location forKey:@"LOCATION"];
    [event setObject:self.recurrencyString forKey:@"recurrency_STRING"];
    return event;
}

@end
