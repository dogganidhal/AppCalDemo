//
//  AppDelegate.h
//  AppCalDemo
//
//  Created by Dogga Nidhal on 05/06/2017.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <AppsoluteCalendar/AppsoluteCalendar.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

typedef NS_ENUM(NSInteger, ApplicationTheme) {
    ApplicationThemeLight,
    ApplicationThemeDark
};
