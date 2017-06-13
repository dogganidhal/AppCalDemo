//
//  FoodController.m
//  AppCalDemo
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "FoodController.h"
#import <AppsoluteCalendar/AppsoluteCalendar.h>

@interface FoodController ()


@end

@implementation FoodController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.appCal = [[AppsoluteCalendar alloc] init];
    [self.appCal reloadEvents:[self createDummyEvents]];
}

- (BOOL)calendarShouldMarkDate:(AppsoluteCalendarMonth *)calendar date:(NSDate *)date {
    NSCalendar *nsCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger dateDay = [nsCalendar component:NSCalendarUnitDay fromDate:date];
    for (NSMutableDictionary *event in [self createDummyEvents]) {
        if ([nsCalendar component:NSCalendarUnitDay fromDate:[event objectForKey:@"STARTDATE"]] == dateDay) {
            return YES;
        }
    }
    return NO;
}

- (NSMutableArray *)createDummyEvents {
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    NSCalendar *nsCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [nsCalendar setLocale:[NSLocale currentLocale]];
    nsCalendar.timeZone = [[NSTimeZone alloc] initWithName:@"GMT"];
    
    for (int i = 0; i <= 2; i++) {
        NSMutableDictionary *testEvent = [[NSMutableDictionary alloc] init];
        NSDate *startDate = [[NSDate alloc] initWithTimeIntervalSinceNow:100000 * i];
        NSDate *endDate = [NSDate dateWithTimeInterval:7200 sinceDate:startDate];
        
        NSString *counter = [NSString stringWithFormat:@"%i",i];
        NSString *time = [NSString stringWithFormat:@"%i:00",(i + 11)];
        
        [testEvent setValue:counter forKey:@"UID"];
        [testEvent setValue:counter forKey:@"SUMMARY"];
        [testEvent setValue:startDate forKey:@"STARTDATE"];
        [testEvent setValue:endDate forKey:@"ENDDATE"];
        [testEvent setValue:[NSNumber numberWithBool:false] forKey:@"ALLDAY"];
        if (i == 8) {
            [testEvent setValue:@"10:00" forKey:@"startTimeString"];
        }
        else {
            [testEvent setValue:@"09:00" forKey:@"startTimeString"];
        }
        if (i == 6) {
            [testEvent setValue:time forKey:@"endTimeString"];
        }
        else {
            [testEvent setValue:time forKey:@"endTimeString"];
        }
        [testEvent setValue:@"Karlsruhe" forKey:@"LOCATION"];
        [testEvent setValue:@"Testinfo für den Key NOTES" forKey:@"NOTES"];
        [testEvent setValue:@"Alle 2 Wochen" forKey:@"recurrency_STRING"];
        [returnArray addObject:testEvent];
    }
    return returnArray;
}

- (void)calendarDidSelectMonth:(AppsoluteCalendarYear *)calendar month:(NSInteger)month year:(NSInteger)year {
    NSLog(@"Month selected");
}

- (void)calendarDidSelectDate:(AppsoluteCalendarMonth *)calendar date:(NSDate *)date eventsForDate:(NSMutableArray *)eventsForDate {
    [self.navigationController pushViewController:[[AppsoluteCalendarDetailVC alloc] init] animated:YES];
}

@end








