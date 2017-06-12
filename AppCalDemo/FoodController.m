//
//  FoodController.m
//  AppCalDemo
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "FoodController.h"
#import <AppsoluteCalendar/AppsoluteCalendar.h>
#import "AppDelegate.h"
#import "FootballDataManager.h"
#import "AppsoluteCalendar+FoodCalendar.h"

@interface FoodController ()

@property (nonatomic) NSInteger lastTrackedIndex;

@end

@implementation FoodController

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialiaze];
}

- (void)initialiaze {
    self.foodCalendar = [[AppsoluteCalendar alloc] init];
    [self.foodCalendar setCustomizationOnCalendar];
    self.dayView = [[AppsoluteCalendarDay alloc] initWithFrame:self.view.frame];
    self.monthView = [[AppsoluteCalendarMonth alloc] initWithFrame:self.view.frame];
    self.yearView = [[AppsoluteCalendarYear alloc] initWithFrame:self.view.frame];
    self.dayView.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height - 153);
    self.monthView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 153);
    self.yearView.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height - 153);
    [self.view addSubview:self.dayView];
    [self.view addSubview:self.monthView];
    [self.view addSubview:self.yearView];
    self.dayView.myDelegate = self;
    self.monthView.myDelegate = self;
    self.monthView.myDataSource = self;
    self.yearView.myDelegate = self;
    _lastTrackedIndex = 1;
}

#pragma mark - Appsolute calendar protocols

- (void)dayViewDidSelectDefaultEvent:(AppsoluteCalendarDay *)dayView date:(NSDate *)date eventsForDate:(AppsoluteCalendarDefaultObject *)eventsForDate {
    
}

- (void)calendarDidSelectMonth:(AppsoluteCalendarYear *)calendar month:(NSInteger)month year:(NSInteger)year {
    
}

- (BOOL)calendarShouldMarkDate:(AppsoluteCalendarMonth *)calendar date:(NSDate *)date {
    return NO;
}

#pragma mark - Calendar controller delegate method

- (void)segmentControlDidChangeValue:(NSInteger)newValue {
    NSInteger offsetIndex = _lastTrackedIndex - newValue;
    [UIView animateWithDuration:0.3 animations:^{
        self.dayView.frame = CGRectOffset(self.dayView.frame, offsetIndex * self.view.frame.size.width, 0);
        self.monthView.frame = CGRectOffset(self.monthView.frame, offsetIndex * self.view.frame.size.width, 0);
        self.yearView.frame = CGRectOffset(self.yearView.frame, offsetIndex * self.view.frame.size.width, 0);
    }];
    _lastTrackedIndex = newValue;
}

- (void)reloadController {
    [super reloadController];
    [self.foodCalendar setCustomizationOnCalendar];
}

@end








