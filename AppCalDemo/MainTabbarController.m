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
#import "CalendarNavigationController.h"
#import "FoodController.h"
#import "FootballController.h"
#import "NotifsController.h"
#import "CalendarNavigationBar.h"

@interface MainTabbarController ()



@end

@implementation MainTabbarController {
    CalendarNavigationController *foodController;
    CalendarNavigationController *footballController;
    CalendarNavigationController *calendarController;
    TemplateController *notifsController;
    TemplateController *settingsController;
}

- (void)loadView {
    [super loadView];
    // Instantiating the children controllers
    foodController = [[CalendarNavigationController alloc] initWithRootViewController:[[FoodController alloc] init] navigationBarClass:CalendarNavigationBar.class];
    footballController = [[CalendarNavigationController alloc] initWithRootViewController:[[FootballController alloc] init] navigationBarClass:CalendarNavigationBar.class];
    calendarController = [[CalendarNavigationController alloc] initWithRootViewController:[[CalendarController alloc] init] navigationBarClass:CalendarNavigationBar.class];
    notifsController = [[TemplateController alloc] initWithRootViewController:[[BaseController alloc] init]];
    settingsController = [[TemplateController alloc] initWithRootViewController:[[SettingsController alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupController];
    // Setting the tabbarItems for children controllers
    foodController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Food" image:[UIImage imageNamed:@"food"] tag:0];
    footballController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Football" image:[UIImage imageNamed:@"Football"] tag:1];
    calendarController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Calendar" image:[UIImage imageNamed:@"calendar"] tag:2];
    notifsController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Notifications" image:[UIImage imageNamed:@"notifs"] tag:3];
    settingsController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[UIImage imageNamed:@"settings"] tag:4];
}

- (void)setupController {
    // TabbarItem Font setting
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[FontBook lightFontOfSize:12], NSFontAttributeName, nil] forState:UIControlStateNormal];
    // Appearence customization
    self.viewControllers = @[foodController, footballController, calendarController, notifsController, settingsController];
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = [Settings mainColor];
    self.tabBar.barTintColor = Settings.appTheme == ApplicationThemeDark ? [UIColor darkGrayColor] : [UIColor whiteColor];
}

- (void)reloadController {
    [self setupController];
    for (TemplateController *childController in self.viewControllers) {
        [childController reloadController];
    }
}

@end
