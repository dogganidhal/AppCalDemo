//
//  CalendarController.h
//  AppCalDemo
//
//  Created by Nidhal on 07.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "CalendarController.h"
#import "AppDelegate.h"
#import <AppsoluteCalendar/AppsoluteCalendar.h>
#import "Settings.h"



@interface CalendarController()

@property (nonatomic, strong) UINavigationBar *segmentToolbar;

@end

@implementation CalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _segmentToolbar = [[UINavigationBar alloc] init];
    [_segmentToolbar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_segmentToolbar];
    [[_segmentToolbar.topAnchor constraintEqualToAnchor:self.navigationBar.bottomAnchor constant:1] setActive:YES];
    [[_segmentToolbar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[_segmentToolbar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
    [[_segmentToolbar.heightAnchor constraintEqualToConstant:50] setActive:YES];
    _segment = [[UISegmentedControl alloc] initWithItems:@[@"Year", @"Month", @"Day"]];
    [_segment setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_segmentToolbar addSubview:_segment];
    [[_segment.centerXAnchor constraintEqualToAnchor:_segmentToolbar.centerXAnchor] setActive:YES];
    [[_segment.centerYAnchor constraintEqualToAnchor:_segmentToolbar.centerYAnchor] setActive:YES];
    _segment.tintColor = [UIColor orangeColor];
    _segment.selectedSegmentIndex = 1;
    [_segment addTarget:self action:@selector(didChangeSegmentedControlValue) forControlEvents:UIControlEventValueChanged];
    _segmentToolbar.barTintColor = Settings.appTheme == ApplicationThemeDark ? [UIColor darkGrayColor] : [UIColor whiteColor];

}

- (void)didChangeSegmentedControlValue {
    if ([self.segmentDelegate respondsToSelector:@selector(didChangeSegmentedControlValue)]) {
        [self.segmentDelegate didChangeSegmentedControlValue:_segment.selectedSegmentIndex];
    }
}


@end







