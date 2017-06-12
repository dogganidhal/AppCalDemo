//
//  CalendarController.h
//  AppCalDemo
//
//  Created by Nidhal on 07.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <AppsoluteCalendar/AppsoluteCalendar.h>
#import "TemplateController.h"
#import "CalendarNavigationBar.h"

@interface CalendarController : TemplateController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController navigationBarClass:(Class)navigationbarClass;

@end

