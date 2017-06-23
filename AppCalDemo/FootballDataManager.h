//
//  FootballDataManager.h
//  FBAPI
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Appsolute GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarEvent.h"

// This class is a model class, which handles the retrieving of the football data from JSON files.

@interface FootballDataManager : NSObject

@property (nonatomic, strong) NSMutableArray *fixtures;
@property (nonatomic, strong) NSArray<CalendarEvent *> *calendarEvents;
@property (nonatomic, strong) NSArray<NSDictionary *> *events;

- (void)reloadData;

@end
