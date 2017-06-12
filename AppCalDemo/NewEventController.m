//
//  NewEventController.m
//  AppCalDemo
//
//  Created by Nidhal on 09.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "NewEventController.h"
#import "CalendarController.h"

@interface NewEventController ()

@property (nonatomic, strong) AppsoluteCalendar *appCal;
@property (nonatomic, strong) AppsoluteCalendarDetail *detailView;

@end

@implementation NewEventController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _appCal = [[AppsoluteCalendar alloc] init];
    [_appCal setAddButtonVisibility:YES];
    [_appCal setCalVisible];
    _detailView.myDelegate = self;
    [self.view addSubview:_detailView];
}

- (void)detailViewWillEditEvent:(AppsoluteCalendarDetail *)detailView eventsForDate:(AppsoluteCalendarDefaultObject *)eventsForDate {
    
}

- (void)detailViewWillDeleteEvent:(AppsoluteCalendarDetail *)detailView eventsForDate:(AppsoluteCalendarDefaultObject *)eventsForDate {
    
}

- (void)detailViewWillDeleteOneEvent:(AppsoluteCalendarDetail *)detailView eventsForDate:(AppsoluteCalendarDefaultObject *)eventsForDate {
    
}

- (void)detailViewWillDeleteFollowingEvent:(AppsoluteCalendarDetail *)detailView eventsForDate:(AppsoluteCalendarDefaultObject *)eventsForDate {
    
}

@end
