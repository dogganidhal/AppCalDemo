//
//  NotificationManager.h
//  AppCalDemo
//
//  Created by Nidhal on 21.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NotificationManager;

@protocol NotificationsDelegate <NSObject>

@optional
- (void)notificationManager:(NotificationManager * _Nonnull)manager didReceiveNotificationWithObjects:(NSMutableArray * _Nonnull)objects;

@end

@protocol NotificationsDataSource <NSObject>

@required
- (NSMutableArray * _Nonnull)notificationManager:(NotificationManager * _Nonnull)manager objectsAtDate:(NSDate * _Nonnull)date;

@end

@interface NotificationManager : NSObject

@property (nonatomic, strong, class, readonly) NotificationManager * _Nonnull shared;
@property (nonatomic, nullable) NSMutableArray<id<NotificationsDataSource>> *dataSources;
@property (nonatomic, nullable) id<NotificationsDelegate> delegate;
@property (nonatomic) NSTimeInterval refreshInterval;

- (void)startNotificationObserving;
- (void)stopNotificationObserving;

@end
