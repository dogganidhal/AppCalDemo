//
//  FootballController.m
//  AppCalDemo
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "FootballController.h"
#import "FootballDataManager.h"
#import "Settings.h"
#import "CalendarNavigationController.h"

@interface FootballController ()

@property (nonatomic, strong) FootballDataManager *manager;

@end

@implementation FootballController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.manager = [[FootballDataManager alloc] init];
    [self.appCal reloadEvents:(NSMutableArray *)[self.manager events]];
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)calendarShouldMarkDate:(AppsoluteCalendarMonth *)calendar date:(NSDate *)date {
    NSCalendar *nsCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    for (CalendarEvent *event in self.manager.calendarEvents) {
        if ([nsCalendar component:NSCalendarUnitDay fromDate:date] == [nsCalendar component:NSCalendarUnitDay fromDate:event.startDate] &&
            [nsCalendar component:NSCalendarUnitMonth fromDate:date] == [nsCalendar component:NSCalendarUnitMonth fromDate:event.startDate] &&
            [nsCalendar component:NSCalendarUnitYear fromDate:date] == [nsCalendar component:NSCalendarUnitYear fromDate:event.startDate]) {
            return YES;
        }
    }
    return NO;
}

- (void)calendarDidSelectDate:(AppsoluteCalendarMonth *)calendar date:(NSDate *)date eventsForDate:(NSMutableArray *)eventsForDate {
    NSLog(@"%@", eventsForDate);
    [self.navigationController pushViewController:[[BaseController alloc] init] animated:YES];
}

- (void)dayViewDidSelectDefaultEvent:(AppsoluteCalendarDay *)dayView date:(NSDate *)date eventsForDate:(AppsoluteCalendarDefaultObject *)eventsForDate {
    NSLog(@"Did select event");

}

- (void)reloadController {
    [super reloadController];
    [self.manager reloadData];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController != self) {
        [((CalendarNavigationBar *)self.navigationController.navigationBar).segment setEnabled:NO];
    } else {
        [((CalendarNavigationBar *)self.navigationController.navigationBar).segment setEnabled:YES];
    }
}

@end



