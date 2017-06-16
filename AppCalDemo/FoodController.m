//
//  FoodController.m
//  AppCalDemo
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "FoodController.h"
#import <AppsoluteCalendar/AppsoluteCalendar.h>
#import <CoreData/CoreData.h>
#import "CalendarNavigationController.h"
#import "FoodEvent+CoreDataClass.h"

@interface FoodController ()

@property (nonatomic, strong) NSMutableArray<FoodEvent *> *foodEvents;
@property (nonatomic, retain) AppDelegate *appDelegate;

@end

@implementation FoodController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
}

- (BOOL)calendarShouldMarkDate:(AppsoluteCalendarMonth *)calendar date:(NSDate *)date {
    NSCalendar *nsCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    for (FoodEvent *event in self.foodEvents) {
        if ([nsCalendar component:NSCalendarUnitDay fromDate:event.startDate] == [nsCalendar component:NSCalendarUnitDay fromDate:date] &&
            [nsCalendar component:NSCalendarUnitMonth fromDate:event.startDate] == [nsCalendar component:NSCalendarUnitMonth fromDate:date] &&
            [nsCalendar component:NSCalendarUnitYear fromDate:event.startDate] == [nsCalendar component:NSCalendarUnitYear fromDate:date]) {
            return YES;
        }
    }
    return NO;
}

- (void)initialize {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewEvent)];
    self.appCal = [[AppsoluteCalendar alloc] init];
    self.appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    self.foodEvents = (NSMutableArray<FoodEvent *> *)[self.appDelegate.persistentContainer.viewContext executeFetchRequest:[FoodEvent fetchRequest] error:nil];
    NSMutableArray<NSMutableDictionary *> *fetchedData = [self fetchData];
    NSLog(@"%@", fetchedData);
    [self.appCal reloadEvents:fetchedData];
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
    printf("FoodController: warning: submit method is not yet implemented.\n");
}

- (void)calendarDidSelectDate:(AppsoluteCalendarMonth *)calendar date:(NSDate *)date eventsForDate:(NSMutableArray *)eventsForDate {
    for (AppsoluteCalendarDefaultObject *defObjct in eventsForDate) {
        NSLog(@"%@", defObjct.event);
    }
    [self setSegmentControlValue:2];
}

- (void)dayViewDidSelectDefaultEvent:(AppsoluteCalendarDay *)dayView date:(NSDate *)date eventsForDate:(AppsoluteCalendarDefaultObject *)eventsForDate {
    NSLog(@"Event: %@", eventsForDate.event);
}


- (NSMutableArray<NSMutableDictionary *> *)fetchData {
    NSMutableArray<NSMutableDictionary *> *appCalEvents = [[NSMutableArray alloc] init];
    for (FoodEvent *event in self.foodEvents) {
        [appCalEvents addObject:(NSMutableDictionary *)[self NSDictionaryFromFoodEvent:event]];
    }
    return appCalEvents;
}

- (NSDictionary *)NSDictionaryFromFoodEvent:(FoodEvent *)event {
    NSMutableDictionary *dictionaryEvent = [[NSMutableDictionary alloc] init];
    [dictionaryEvent setObject:@(event.allDay) forKey:@"ALLDAY"];
    [dictionaryEvent setObject:event.startDate forKey:@"STARTDATE"];
    [dictionaryEvent setObject:event.uid forKey:@"UID"];
    [dictionaryEvent setObject:event.endTimeString forKey:@"endTimeString"];
    [dictionaryEvent setObject:event.startTimeString forKey:@"startTimeString"];
    [dictionaryEvent setObject:event.endDate forKey:@"ENDDATE"];
    [dictionaryEvent setObject:event.summary forKey:@"SUMMARY"];
    [dictionaryEvent setObject:event.notes forKey:@"NOTES"];
    [dictionaryEvent setObject:event.location forKey:@"LOCATION"];
    [dictionaryEvent setObject:event.recurrency_STRING forKey:@"recurrency_STRING"];
//    [dictionaryEvent setObject:event.photo forKey:@"PHOTO"];
    return dictionaryEvent;
}


@end







