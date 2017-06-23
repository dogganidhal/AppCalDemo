//
//  NotificationManager.h
//  AppCalDemo
//
//  Created by Nidhal on 21.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NotificationManager;

// This protocol allows the receiver class to get events from the NotificationManager.

@protocol NotificationsDelegate <NSObject>

// Tells the delegate that the NotificationManager updated the events.
@optional
- (void)notificationManager:(NotificationManager * _Nonnull)manager didReceiveNotificationWithObjects:(NSMutableArray * _Nonnull)objects;

@end

// this protocol allows the NotificationManager to ask for events every update cycle.

@protocol NotificationsDataSource <NSObject>

// Asks the data source to provide events for a particualr date.
@required
- (NSMutableArray * _Nonnull)notificationManager:(NotificationManager * _Nonnull)manager objectsAtDate:(NSDate * _Nonnull)date;

@end

// This class is a model object of a notifications handler from multiple data sources.

@interface NotificationManager : NSObject

// Shared instance which will be used in the application.
@property (nonatomic, strong, class, readonly) NotificationManager * _Nonnull shared;
// NSMutableArray holding all the data sources of the NotificationManager.
@property (nonatomic, nullable) NSMutableArray<id<NotificationsDataSource>> *dataSources;
@property (nonatomic, nullable) id<NotificationsDelegate> delegate;
@property (nonatomic) NSTimeInterval refreshInterval;

- (void)startNotificationObserving;
- (void)stopNotificationObserving;

@end
