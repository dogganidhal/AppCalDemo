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
- (void)notificationManager:(NotificationManager * _Nonnull)manager didReceiveNotificationWithObjects:(id _Nullable)objects;

@end

@protocol NotificationsDataSource <NSObject>

@required
- (NSTimeInterval)refreshInterval;
- (NSTimeInterval)notifyBeforeTimeInterval;
- (NSArray * _Nullable)notificationManager:(NotificationManager * _Nonnull)manager objectsAtDate:(NSDate * _Nonnull)date;

@end

@interface NotificationManager : NSObject

@property (nonatomic, strong, class, readonly) NotificationManager * _Nonnull shared;
@property (nonatomic, nullable, assign) id<NotificationsDataSource> dataSource;
@property (nonatomic, nullable, assign) id<NotificationsDelegate> delegate;

- (void)startNotificationObserving;
- (void)stopNotificationObserving;
- (BOOL)hasObject:(id _Nonnull)object;

@end
