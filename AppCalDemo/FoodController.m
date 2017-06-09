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

@interface FoodController ()

@property (nonatomic, retain) CalendarController *calendarController;
@property (nonatomic, strong) AppsoluteCalendar *appCal;

@end

@implementation FoodController

- (void)loadView {
    [super loadView];
    _calendarController = (CalendarController *)self.navigationController;
    _appCal = [AppDelegate appCal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _calendarController.segmentDelegate = self;
    self.view.frame = CGRectMake(0, 0, 256, 256);
    self.view.backgroundColor = [UIColor cyanColor];
}

#pragma mark - Calendar controller delegate method

- (void)didChangeSegmentedControlValue:(NSUInteger)newValue {
    NSLog(@"%ld", (long)newValue);
}

@end








