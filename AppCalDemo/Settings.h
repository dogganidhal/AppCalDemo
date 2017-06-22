//
//  Settings.h
//  AppCalDemo
//
//  Created by Nidhal on 07.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontBook.h"
#import "AppDelegate.h"

@interface Settings : NSObject

@property (nonatomic, class, readonly) ApplicationTheme appTheme;
@property (nonatomic, class, readonly) NSTimeInterval notificationsRefreshDelai;

@property (nonatomic, class, readonly) NSInteger firstDayOfTheWeek;

@property (nonatomic, strong, class, readonly) NSString *league;

@property (nonatomic, strong, class, readonly) UIColor *mainColor;

@property (nonatomic, strong, class, readonly) UIColor *monthNameColor;
@property (nonatomic, strong, class, readonly) UIColor *monthSeparatorColor;

@property (nonatomic, strong, class, readonly) UIColor *hourTextColor;
@property (nonatomic, strong, class, readonly) UIColor *hourSeparatorColor;

@property (nonatomic, strong, class, readonly) UIColor *calendarTintColor;
@property (nonatomic, strong, class, readonly) UIColor *calendarEventColor;
@property (nonatomic, strong, class, readonly) UIColor *calendarButtonTintColor;
@property (nonatomic, strong, class, readonly) UIColor *calendarFontColor;

@property (nonatomic, strong, class, readonly) UIColor *currentDayCircleColor;
@property (nonatomic, strong, class, readonly) UIColor *currentDayFontColor;

@property (nonatomic, strong, class, readonly) UIColor *overallBackgroundColor;
@property (nonatomic, strong, class, readonly) UIColor *todaysBarColor;

@end
