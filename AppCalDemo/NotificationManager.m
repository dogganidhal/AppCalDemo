//
//  NotificationManager.m
//  AppCalDemo
//
//  Created by Nidhal on 21.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "NotificationManager.h"

@interface NotificationManager ()

// The timer that will be fired after the refresh interval is elapsed.
@property (nonatomic, strong) NSTimer *timer;
// Received Objects from data sources.
@property (nonatomic, strong) NSMutableArray *objects;
// A boolean indicating whether the manager is currently looking for notifications.
@property (nonatomic) BOOL isObserving;

@end

@implementation NotificationManager

static NotificationManager *_shared;

+ (void)initialize {
    _shared = [[NotificationManager alloc] init];
}

+ (NotificationManager *)shared {
    return _shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataSources = [[NSMutableArray alloc] init];
        self.delegate = nil;
        self.refreshInterval = 10.0;
    }
    return self;
}

// Starts observing and fires the timer in ther RunLoop.
- (void)startNotificationObserving {
    self.isObserving = YES;
    self.timer = [NSTimer timerWithTimeInterval:self.refreshInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (self.isObserving) {
            [self notificationManager:self didReceiveNotificationWithObjects:[self notificationManager:self objectsAtDate:timer.fireDate]];
        }
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

// Stops observing and invalidates the timer.
- (void)stopNotificationObserving {
    self.isObserving = NO;
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Notification manager delegate

- (void)notificationManager:(NotificationManager * _Nonnull)manager didReceiveNotificationWithObjects:(NSMutableArray * _Nonnull)objects {
    if ([self.delegate respondsToSelector:@selector(notificationManager:didReceiveNotificationWithObjects:)]) {
        [(id)self.delegate notificationManager:self didReceiveNotificationWithObjects:objects];
    }
    
}

#pragma mark - Notification manager data source

- (NSMutableArray * _Nonnull)notificationManager:(NotificationManager * _Nonnull)manager objectsAtDate:(NSDate *)date {
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    for (id<NotificationsDataSource> dataSource in self.dataSources) {
        if ([dataSource respondsToSelector:@selector(notificationManager:objectsAtDate:)]) {
            [objects addObjectsFromArray:[dataSource notificationManager:self objectsAtDate:date]];
        }
    }
    return objects;
}



@end
