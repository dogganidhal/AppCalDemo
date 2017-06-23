//
//  FootballDataManager.m
//  FBAPI
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Appsolute GmbH. All rights reserved.
//

#import "FootballDataManager.h"
#import "Settings.h"

@interface FootballDataManager ()

@property (nonatomic, strong) NSDictionary *apiData;

@end

@implementation FootballDataManager

- (instancetype)init {
    self = [super init];
    if (self) {
        [self reloadData];
    }
    return self;
}

// Reloads the league and it's data.
- (void)reloadData {
    NSString *path = [[NSBundle mainBundle] pathForResource:Settings.league ofType:@"json"];
    NSData *data= [NSData dataWithContentsOfFile:path];
    self.apiData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.fixtures = [self.apiData objectForKey:@"fixtures"];
    self.events = [self createEvents];
}

- (NSMutableArray *)fixtures {
    return [self.apiData objectForKey:@"fixtures"];
}

- (NSArray<NSDictionary *> *)createEvents {
    NSMutableArray *eventsArray = [[NSMutableArray alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSCalendar *nsCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    for (NSDictionary *fixture in self.fixtures) {
        NSMutableDictionary *event = [[NSMutableDictionary alloc] init];
        [event setValue:@(NO) forKey:@"ALLDAY"];
        [event setValue:[formatter dateFromString:[fixture objectForKey:@"date"]] forKey:@"STARTDATE"];
        [event setValue:[[event valueForKey:@"STARTDATE"] dateByAddingTimeInterval:6300] forKey:@"ENDDATE"];
        [event setValue:[NSString stringWithFormat:@"%@'s Stadium", [fixture objectForKey:@"homeTeamName"]] forKey:@"LOCATION"];
        [event setValue:[NSString stringWithFormat:@"%@ vs %@ \n%@ matchday %ld", [fixture objectForKey:@"homeTeamName"], [fixture objectForKey:@"awayTeamName"], Settings.league, (long)((NSNumber *)[fixture objectForKey:@"matchday"]).integerValue] forKey:@"SUMMARY"];
        [event setValue:[NSString stringWithFormat:@"Match %@ at %ld - %ld", [fixture objectForKey:@"status"], (long)((NSNumber *)[[fixture objectForKey:@"result"] objectForKey:@"goalsHomeTeam"]).integerValue, (long)((NSNumber *)[[fixture objectForKey:@"result"] objectForKey:@"goalsAwayTeam"]).integerValue] forKey:@"NOTES"];
        [event setValue:[NSString stringWithFormat:@"%i:%i", (int)[nsCalendar component:NSCalendarUnitHour fromDate:[event valueForKey:@"STARTDATE"]], (int)[nsCalendar component:NSCalendarUnitMinute fromDate:[event valueForKey:@"STARTDATE"]]] forKey:@"startTimeString"];
        [event setValue:[NSString stringWithFormat:@"%i:%i", (int)[nsCalendar component:NSCalendarUnitHour fromDate:[event valueForKey:@"ENDDATE"]], (int)[nsCalendar component:NSCalendarUnitMinute fromDate:[event valueForKey:@"ENDDATE"]]] forKey:@"entTimeString"];
        [event setValue:@"none" forKey:@"recurrency_STRING"];
        [event setValue:[self uuid] forKey:@"UID"];
        [eventsArray addObject:event];
    }
    return eventsArray;
}

// Method allowing to creat a dummy unique UID. 
- (NSString *)uuid {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge NSString *)(uuidStringRef);
}

@end






