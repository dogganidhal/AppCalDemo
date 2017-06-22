//
//  Settings.m
//  AppCalDemo
//
//  Created by Nidhal on 07.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "Settings.h"
#import "UIColor_Extensions.h"

@interface Settings ()

@property (nonatomic, strong, class, readonly) NSArray<NSArray<NSDictionary *> *> *plistData;

@end

@implementation Settings

+ (ApplicationTheme)appTheme {
    NSDictionary *themeObject = [[self.plistData objectAtIndex:1] objectAtIndex:0];
    NSNumber *selectedTheme = [themeObject objectForKey:@"selectedValue"];
    return selectedTheme.integerValue == 0 ? ApplicationThemeDark : ApplicationThemeLight;
}

+ (NSTimeInterval)notificationsRefreshDelai {
    NSDictionary *notificationsObject = [[self.plistData objectAtIndex:5] objectAtIndex:0];
    NSNumber *selectedDelai = [notificationsObject objectForKey:@"selectedValue"];
    return selectedDelai.floatValue;
}

+ (NSInteger)firstDayOfTheWeek {
    NSDictionary *dayObject = [[self.plistData objectAtIndex:2] objectAtIndex:0];
    NSNumber *selected = [dayObject objectForKey:@"selectedValue"];
    return selected.integerValue + 1;
}

+ (NSString *)league {
    NSDictionary *leagueObject = [[self.plistData objectAtIndex:4] objectAtIndex:0];
    NSNumber *selectedLeague = [leagueObject objectForKey:@"selectedValue"];
    NSArray<NSString *> *allValues = [leagueObject objectForKey:@"allValues"];
    return [allValues objectAtIndex:selectedLeague.integerValue];
}

+ (UIColor *)mainColor {
    NSDictionary *colorObject = [[self.plistData objectAtIndex:1] objectAtIndex:1];
    NSNumber *selected = [colorObject objectForKey:@"selectedValue"];
    NSArray<NSString *> *allValues = [colorObject objectForKey:@"allValues"];
    NSString *retrievedColor = [allValues objectAtIndex:selected.integerValue];
    NSString *colorSelector = nil;
    if (![retrievedColor isEqualToString:@"LightGray"]) {
        colorSelector = [NSString stringWithFormat:@"%@Color", [retrievedColor lowercaseString]];
    } else {
        return [UIColor colorWithRed:224/255 green:224/255 blue:224/255 alpha:0.25];
    }
    return [UIColor performSelector:NSSelectorFromString(colorSelector)];
}

+ (UIColor *)colorAtIndex:(NSUInteger)index {
    NSDictionary *colorObject = [[self.plistData objectAtIndex:3] objectAtIndex:index];
    NSNumber *selected = [colorObject objectForKey:@"selectedValue"];
    NSArray<NSString *> *allValues = [colorObject objectForKey:@"allValues"];
    NSString *retrievedColor = [allValues objectAtIndex:selected.integerValue];
    NSString *colorSelector = nil;
    if (![retrievedColor isEqualToString:@"LightGray"]) {
        colorSelector = [NSString stringWithFormat:@"%@Color", [retrievedColor lowercaseString]];
    } else {
        return [UIColor groupTableViewBackgroundColor];
    }
    return [UIColor performSelector:NSSelectorFromString(colorSelector)];
}

+ (UIColor *)monthNameColor {
    return [Settings colorAtIndex:0];
}

+ (UIColor *)monthSeparatorColor {
    return [Settings colorAtIndex:1];
}

+ (UIColor *)hourTextColor {
    return [Settings colorAtIndex:2];
}

+ (UIColor *)hourSeparatorColor {
    return [Settings colorAtIndex:3];
}

+ (UIColor *)calendarEventColor {
    return [Settings colorAtIndex:6];
}

+ (UIColor *)calendarTintColor {
    return [Settings colorAtIndex:5];
}

+ (UIColor *)calendarButtonTintColor {
    return [Settings colorAtIndex:7];
}

+ (UIColor *)calendarFontColor {
    return [Settings colorAtIndex:4];
}

+ (UIColor *)currentDayCircleColor {
    return [Settings colorAtIndex:8];
}

+ (UIColor *)currentDayFontColor {
    return [Settings colorAtIndex:9];
}

+ (UIColor *)overallBackgroundColor {
    return [Settings colorAtIndex:10];
}

+ (UIColor *)todaysBarColor {
    return [Settings colorAtIndex:11];
}

+ (NSArray *)plistData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
    NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
    [data writeToFile:filePath atomically:YES];
    return  data;
}

@end
