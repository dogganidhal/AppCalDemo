//
//  CalendarController.h
//  AppCalDemo
//
//  Created by Nidhal on 07.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "CalendarController.h"
#import "AppDelegate.h"
#import "Settings.h"

@interface CalendarController()

@end

@implementation CalendarController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController navigationBarClass:(Class)navigationbarClass {
    self = [super initWithNavigationBarClass:navigationbarClass toolbarClass:nil];
    if (self) {
        self.viewControllers = @[rootViewController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)segmentControlDidChangeValue:(NSInteger)newValue {
    if ([self.topViewController respondsToSelector:@selector(segmentControlDidChangeValue:)]) {
        [(id)self.topViewController segmentControlDidChangeValue:newValue];
    }
}

- (void)reloadController {
    [super reloadController];
    if (self.navigationBar.class == CalendarNavigationBar.class) {
        [(CalendarNavigationBar *)self.navigationBar reloadView];
    }
}

@end







