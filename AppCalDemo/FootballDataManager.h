//
//  FootballDataManager.h
//  FBAPI
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Appsolute GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarEvent.h"

@interface FootballDataManager : NSObject

- (NSMutableArray *)fixtures;
- (NSArray<CalendarEvent *> *)calendarEvents;
- (NSArray<NSDictionary *> *)events;

@end
