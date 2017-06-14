//
//  CalendarController.m
//  AppCalDemo
//
//  Created by Nidhal on 12.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "CalendarTemplateController.h"
#import "AppsoluteCalendar+FoodCalendar.h"
#import "Settings.h"

@interface CalendarTemplateController ()

@property (nonatomic) NSInteger lastTrackedIndex;

@end

@implementation CalendarTemplateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialiaze];
}

- (void)initialiaze {
    self.appCal = [[AppsoluteCalendar alloc] init];
    [self.appCal setCustomizationOnCalendar];
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
    [self.monthView scrollToToday:NO];
    _lastTrackedIndex = 1;
    [self reloadView];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:self action:nil];
}

- (void)reloadView {
#warning Delete this setting once the overallBackgroundColor applies on the views automatically
    self.dayView.backgroundColor = Settings.overallBackgroundColor;
    self.monthView.backgroundColor = Settings.overallBackgroundColor;
    self.yearView.backgroundColor = Settings.overallBackgroundColor;
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

- (void)setSegmentControlValue:(NSInteger)newValue {
    ((CalendarNavigationBar *)self.navigationController.navigationBar).segment.selectedSegmentIndex = newValue;
    [self segmentControlDidChangeValue:newValue];
}

- (void)reloadController {
    [super reloadController];
    [self.appCal setCustomizationOnCalendar];
    [self reloadView];
    [self.monthView reloadData];
    [self.yearView reloadData];
#warning Wait for the method to reload the dayView's data
}

@end
