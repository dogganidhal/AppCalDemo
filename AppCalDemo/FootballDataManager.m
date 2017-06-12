//
//  FootballDataManager.m
//  FBAPI
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Appsolute GmbH. All rights reserved.
//

#import "FootballDataManager.h"

@interface FootballDataManager ()

@property (nonatomic, strong) NSString *apiURL;
@property (nonatomic, strong) NSDictionary *apiData;
@property (nonatomic, strong) NSObject *bundesLiga;

@end

@implementation FootballDataManager

- (instancetype)init {
   self = [super init];
   if (self) {
      NSString *path = [[NSBundle mainBundle] pathForResource:@"Fixtures" ofType:@"json"];
      NSData *data= [NSData dataWithContentsOfFile:path];
      _apiData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
   }
   return self;
}

- (NSMutableArray *)fixtures {
   return [_apiData objectForKey:@"fixtures"];
}

- (NSMutableArray *)calendarEvents {
   NSMutableArray *events = [[NSMutableArray alloc] init];
   NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
   NSCalendar *nsCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
   formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
   for (NSDictionary *fixture in [self fixtures]) {
      CalendarEvent *event = [[CalendarEvent alloc] init];
      event.allday = NO;
      event.startDate = [formatter dateFromString:[fixture objectForKey:@"date"]];
      event.endDate = [event.startDate dateByAddingTimeInterval:6300];
      event.location = [NSString stringWithFormat:@"%@'s Stadium", [fixture objectForKey:@"homeTeamName"]];
      event.summary = [NSString stringWithFormat:@"%@ vs %@ Bundes Liga matchday %ld", [fixture objectForKey:@"homeTeamName"], [fixture objectForKey:@"awayTeamName"], (long)((NSNumber *)[fixture objectForKey:@"matchday"]).integerValue];
      event.notes = [NSString stringWithFormat:@"Match %@ at %ld - %ld", [fixture objectForKey:@"status"], (long)((NSNumber *)[[fixture objectForKey:@"result"] objectForKey:@"goalsHomeTeam"]).integerValue, (long)((NSNumber *)[[fixture objectForKey:@"result"] objectForKey:@"goalsAwayTeam"]).integerValue];
      event.startTimeString = [NSString stringWithFormat:@"%i:%i", (int)[nsCalendar component:NSCalendarUnitHour fromDate:event.startDate], (int)[nsCalendar component:NSCalendarUnitMinute fromDate:event.startDate]];
      event.endTimeString = [NSString stringWithFormat:@"%i:%i", (int)[nsCalendar component:NSCalendarUnitHour fromDate:event.endDate], (int)[nsCalendar component:NSCalendarUnitMinute fromDate:event.endDate]];
      event.recurrencyString = @"none";
      event.UID = [self uuid];
      [events addObject:[event toDictionary]];
   }
   return events;
}

- (NSString *)uuid {
   CFUUIDRef uuidRef = CFUUIDCreate(NULL);
   CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
   CFRelease(uuidRef);
   return (__bridge NSString *)(uuidStringRef);
}

@end






