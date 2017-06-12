//
//  FootballController.m
//  AppCalDemo
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "FootballController.h"
#import "FootballDataManager.h"


@interface FootballController ()

@property (nonatomic, strong) FootballDataManager *manager;

@end

@implementation FootballController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _manager = [[FootballDataManager alloc] init];
    [self.appCal reloadEvents:[_manager calendarEvents]];
}


- (BOOL)calendarShouldMarkDate:(AppsoluteCalendarMonth *)calendar date:(NSDate *)date {
    NSCalendar *nsCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger dateDay = [nsCalendar component:NSCalendarUnitDay fromDate:date];
    for (NSMutableDictionary *event in [_manager calendarEvents]) {
        if ([nsCalendar component:NSCalendarUnitDay fromDate:[event objectForKey:@"STARTDATE"]] == dateDay) {
            NSLog(@"%ld", (long)dateDay);
            return YES;
        }
    }
    return NO;
}

- (void)calendarDidSelectDate:(AppsoluteCalendarMonth *)calendar date:(NSDate *)date eventsForDate:(NSMutableArray *)eventsForDate {
    
}

@end



