//
//  NotificationManager.m
//  AppCalDemo
//
//  Created by Nidhal on 21.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "NotificationManager.h"

@interface NotificationManager ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSTimeInterval refreshInterval;
@property (nonatomic) NSTimeInterval timeBeforeEvent;
@property (nonatomic, strong) NSMutableArray<id> *objects;
@property (nonatomic, strong) id lastObject;
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

- (void)startNotificationObserving {
    self.isObserving = YES;
    self.timer = [NSTimer timerWithTimeInterval:[self refreshInterval] repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (self.isObserving) {
            
        }
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)stopNotificationObserving {
    self.isObserving = NO;
    [self.timer invalidate];
    self.timer = nil;
}

- (BOOL)hasObject:(id)object {
    return [self.objects containsObject:object];
}

#pragma mark - Notification manager delegate

- (void)notificationManager:(NotificationManager * _Nonnull)manager didReceiveNotificationWithObject:(id _Nullable)object {
    if ([self.delegate respondsToSelector:@selector(notificationManager:didReceiveNotificationWithObject:)]) {
        [(id)self.delegate notificationManager:self didReceiveNotificationWithObject:object]; // Specify the manager and the object
    }
    
}

#pragma mark - Notification manager data source

- (NSArray * _Nullable)notificationManager:(NotificationManager * _Nonnull)manager objectsAtDate:(NSDate *)date {
    if ([self.dataSource respondsToSelector:@selector(notificationManager:objectsAtDate:)]) {
        
    }
    return nil;
}

- (NSTimeInterval)refreshInterval {
    if ([self.dataSource respondsToSelector:@selector(refreshInterval)]) {
        return [(id)self.dataSource refreshInterval];
    }
    NSLog(@"Invalid NotificationManager Data source: must implement -refreshInterval");
    return FLT_MAX;
}

- (NSTimeInterval)timeBeforeEvent {
    if ([self.dataSource respondsToSelector:@selector(notifyBeforeTimeInterval)]) {
        return [(id)self.dataSource notifyBeforeTimeInterval];
    }
    NSLog(@"Invalid NotificationManager Data source: must implement -notifyBeforeTimeEvent");
    return 0.0;
}

@end
