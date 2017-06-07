//
//  Settings.m
//  AppCalDemo
//
//  Created by Nidhal on 07.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "Settings.h"

@interface Settings ()

@property (nonatomic, strong, class, readonly) NSArray<NSArray<NSDictionary *> *> *plistData;

@end

@implementation Settings

+ (ApplicationTheme)appTheme {
    NSDictionary *themeObject = [[self.plistData objectAtIndex:1] objectAtIndex:0];
    NSNumber *selectedTheme = [themeObject objectForKey:@"selectedValue"];
    return selectedTheme.integerValue == 0 ? ApplicationThemeDark : ApplicationThemeLight;
}

+ (void)setAppTheme:(ApplicationTheme)appTheme {
    if (appTheme == ApplicationThemeLight) {
        [[[self.plistData objectAtIndex:1] objectAtIndex:0] setValue:@(1) forKey:@"selectedValue"];
    } else {
        [[[self.plistData objectAtIndex:1] objectAtIndex:0] setValue:@(0) forKey:@"selectedValue"];
    }
}

+ (NSString *)firstDayOfTheWeek {
    NSDictionary *dayObject = [[self.plistData objectAtIndex:2] objectAtIndex:0];
    NSNumber *selected = [dayObject objectForKey:@"selectedValue"];
    NSArray<NSString *> *allValues = [dayObject objectForKey:@"allValues"];
    return [allValues objectAtIndex:selected.integerValue];
}

+ (void)setFirstDayOfTheWeek:(NSString *)firstDayOfTheWeek {
    NSDictionary *dayObject = [[self.plistData objectAtIndex:2] objectAtIndex:0];
    NSArray<NSString *> *allValues = [dayObject objectForKey:@"allValues"];
    [dayObject setValue:@([allValues indexOfObject:firstDayOfTheWeek]) forKey:@"selectedValue"];
}

+ (NSString *)currentDaySelectionShape {
    NSDictionary *shapeObject = [[self.plistData objectAtIndex:3] objectAtIndex:0];
    NSNumber *selected = [shapeObject objectForKey:@"selectedValue"];
    NSArray<NSString *> *allValues = [shapeObject objectForKey:@"allValues"];
    return [allValues objectAtIndex:selected.integerValue];
}

+ (void)setCurrentDaySelectionShape:(NSString *)currentDaySelectionShape {
    NSDictionary *shapeObject = [[self.plistData objectAtIndex:3] objectAtIndex:0];
    NSArray<NSString *> *allValues = [shapeObject objectForKey:@"allValues"];
    [shapeObject setValue:@([allValues indexOfObject:currentDaySelectionShape]) forKey:@"selectedValue"];
}

+ (NSArray *)plistData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
    NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
    [data writeToFile:filePath atomically:YES];
    return  data;
}

@end
