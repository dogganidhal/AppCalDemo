//
//  NotifsController.m
//  AppCalDemo
//
//  Created by Nidhal on 21.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "NotifsController.h"

@interface NotifsController ()

@end

@implementation NotifsController

- (void)viewDidLoad {
    [super viewDidLoad];
    NotificationManager.shared.delegate = self;
}

#pragma mark - Notification delegate methods

- (void)startNotificationObservingWithTimeInterval:(NSTimeInterval)timeInterval timeBeforeEventLessThan:(NSTimeInterval)margin {
    
}

- (void)stopNotificationObserving {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    // Configure the cell...
    
    return cell;
}

- (void)notificationManager:(NotificationManager * _Nonnull)manager didReceiveNotificationWithObject:(id _Nullable)object {
    // Refresh the UI
    NSLog(@"DN: %@", object);
}

@end
