//
//  MainTabbarController.m
//  AppCalDemo
//
//  Created by Dogga Nidhal on 05/06/2017.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <AppsoluteCalendar/AppsoluteCalendar.h>
#import "MainTabbarController.h"
#import "TemplateController.h"
#import "BaseController.h"
#import "SettingsController.h"
#import "FontBook.h"
#import "Settings.h"
#import "AppCalDemo-Swift.h"
#import "CalendarController.h"

@interface MainTabbarController ()



@end

@implementation MainTabbarController

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view.
    [self setupController];
    AppsoluteCalendar *appCal = [[AppsoluteCalendar alloc] init];
    [appCal isSubclassed:YES];
}

- (void)setupController {
    // TabbarItem Font setting
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[FontBook lightFontOfSize:12], NSFontAttributeName, nil] forState:UIControlStateNormal];
    // Instantiating the children controllers
    TemplateController *foodController = [[TemplateController alloc] initWithRootViewController:[[BaseController alloc] init]];
    TemplateController *sportController = [[CalendarController alloc] initWithRootViewController:[[BaseController alloc] init]];
    TemplateController *calendarController = [[MonthController alloc] initWithRootViewController:[[BaseController alloc] init]];
    TemplateController *notifsController = [[TemplateController alloc] initWithRootViewController:[[BaseController alloc] init]];
    TemplateController *settingsController = [[TemplateController alloc] initWithRootViewController:[[SettingsController alloc] init]];
    // Setting the tabbarItems for children controllers
    foodController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Food" image:[UIImage imageNamed:@"food"] tag:0];
    sportController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Football" image:[UIImage imageNamed:@"Football"] tag:0];
    calendarController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Calendar" image:[UIImage imageNamed:@"calendar"] tag:0];
    notifsController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Notifications" image:[UIImage imageNamed:@"notifs"] tag:0];
    settingsController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[UIImage imageNamed:@"settings"] tag:0];
    // Appearence customization
    self.viewControllers = @[foodController, sportController, calendarController, notifsController, settingsController];
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = [UIColor orangeColor];
    self.tabBar.barTintColor = Settings.appTheme == ApplicationThemeDark ? [UIColor darkGrayColor] : [UIColor whiteColor];
}

@end
