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
    self.calendarController.segmentDelegate = self;
    
}

#pragma mark - Calendar controller delegate method

- (void)didChangeSegmentedControlValue:(NSUInteger)newValue {
    
}

@end








