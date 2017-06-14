//
//  MainCalendarController.m
//  AppCalDemo
//
//  Created by Nidhal on 13.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "CalendarController.h"
#import "FoodEvent+CoreDataClass.h"
#import "AppDelegate.h"
#import "TemplateController.h"

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
    TemplateController *presentedController = [[TemplateController alloc] initWithRootViewController:[[BaseController alloc] init]];
    presentedController.topViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismissCurrentViewController)];
    presentedController.topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(submitNewEvent)];
    [self presentViewController:presentedController animated:YES completion:nil];
}

- (void)dismissCurrentViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)submitNewEvent {
    printf("CalendarController: warning: submit method is not yet implemented.\n");
}


@end
