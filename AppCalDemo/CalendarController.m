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

@property (nonatomic, strong) UISegmentedControl *segment;

@end

@implementation CalendarController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navbar = [[UINavigationBar alloc] init];
    [self.navbar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.navbar];
    [[self.navbar.topAnchor constraintEqualToAnchor:self.navigationBar.bottomAnchor constant:-8] setActive:YES];
    [[self.navbar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[self.navbar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
    [[self.navbar.heightAnchor constraintEqualToConstant:50] setActive:YES];
    self.navbar.barTintColor = Settings.appTheme == ApplicationThemeDark ? [UIColor darkGrayColor] : [UIColor whiteColor];
    self.navbar.translucent = NO;
    
    _segment = [[UISegmentedControl alloc] initWithItems:@[@"Year", @"Month", @"Day"]];
    [_segment setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.navbar addSubview:_segment];
    [[_segment.centerXAnchor constraintEqualToAnchor:self.navbar.centerXAnchor] setActive:YES];
    [[_segment.centerYAnchor constraintEqualToAnchor:self.navbar.centerYAnchor] setActive:YES];
    _segment.tintColor = [Settings mainColor];
    _segment.selectedSegmentIndex = 1;
    [_segment addTarget:self action:@selector(didChangeSegmentedControlValue:) forControlEvents:UIControlEventValueChanged];
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:[FontBook regularFontOfSize:12] forKey:NSFontAttributeName] forState:UIControlStateNormal];
    
}

- (void)didChangeSegmentedControlValue:(NSInteger)newValue {
    if ([self.segmentDelegate respondsToSelector:@selector(didChangeSegmentedControlValue:)]) {
        [self.segmentDelegate didChangeSegmentedControlValue:_segment.selectedSegmentIndex];
    }
}

- (void)reloadController {
    [super reloadController];
    self.navbar.barTintColor = Settings.appTheme == ApplicationThemeDark ? [UIColor darkGrayColor] : [UIColor whiteColor];
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:[FontBook regularFontOfSize:12] forKey:NSFontAttributeName] forState:UIControlStateNormal];
    _segment.tintColor = [Settings mainColor];
}

- (void)setShowsToolbar:(BOOL)showsToolbar {
    self.navbar.hidden = !showsToolbar;
}

- (void)setSegmentValue:(NSInteger)index {
    self.segment.selectedSegmentIndex = index;
    [self didChangeSegmentedControlValue:index];
}

@end







