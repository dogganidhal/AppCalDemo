//
//  CalendarEvent.h
//  AppCalDemo
//
//  Created by Nidhal on 12.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarEvent : NSObject

@property (nonatomic, strong) NSString *UID;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *startTimeString;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *endTimeString;
@property (nonatomic, strong) NSString *recurrencyString;
@property (nonatomic) BOOL allday;

+ (instancetype)EventFromDictionary:(NSDictionary *)event;
+ (NSArray<CalendarEvent *> *)eventsWithDictionaries:(NSArray<NSDictionary *>*)events;
- (NSDictionary *)toDictionary;

@end
