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

@end

@implementation CalendarController {
    UINavigationBar *segmentToolbar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    segmentToolbar = [[UINavigationBar alloc] init];
    [segmentToolbar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:segmentToolbar];
    [[segmentToolbar.topAnchor constraintEqualToAnchor:self.navigationBar.bottomAnchor constant:0] setActive:YES];
    [[segmentToolbar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[segmentToolbar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
    [[segmentToolbar.heightAnchor constraintEqualToConstant:50] setActive:YES];
    _segment = [[UISegmentedControl alloc] initWithItems:@[@"Year", @"Month", @"Day"]];
    [_segment setTranslatesAutoresizingMaskIntoConstraints:NO];
    [segmentToolbar addSubview:_segment];
    [[_segment.centerXAnchor constraintEqualToAnchor:segmentToolbar.centerXAnchor] setActive:YES];
    [[_segment.centerYAnchor constraintEqualToAnchor:segmentToolbar.centerYAnchor] setActive:YES];
    _segment.tintColor = [UIColor orangeColor];
    _segment.selectedSegmentIndex = 1;
    [_segment addTarget:self action:@selector(didChangeSegmentedControlValue:) forControlEvents:UIControlEventValueChanged];
    segmentToolbar.barTintColor = Settings.appTheme == ApplicationThemeDark ? [UIColor darkGrayColor] : [UIColor whiteColor];
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:[FontBook regularFontOfSize:12] forKey:NSFontAttributeName] forState:UIControlStateNormal];
}

- (void)didChangeSegmentedControlValue:(NSUInteger)newValue {
    if ([self.segmentDelegate respondsToSelector:@selector(didChangeSegmentedControlValue:)]) {
        [self.segmentDelegate didChangeSegmentedControlValue:_segment.selectedSegmentIndex];
    }
}


@end







