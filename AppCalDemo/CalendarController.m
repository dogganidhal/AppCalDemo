//
//  MainCalendarController.m
//  AppCalDemo
//
//  Created by Nidhal on 13.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "CalendarController.h"

@interface CalendarController ()

@end

@implementation CalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
}

- (void)initialize {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewEvent)];
}

- (void)addNewEvent {
    [self.navigationController pushViewController:[[BaseController alloc] init] animated:YES];
}

@end
