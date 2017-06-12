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
//    self.manager = [[FootballDataManager alloc] init];
}


- (BOOL)calendarShouldMarkDate:(AppsoluteCalendarMonth *)calendar date:(NSDate *)date {
    return NO;
}

@end



