//
//  ViewController.m
//  AppCalDemo
//
//  Created by Dogga Nidhal on 05/06/2017.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "TemplateController.h"
#import "Settings.h"
#import "AppCalDemo-Swift.h"

@interface TemplateController ()

@end

@implementation TemplateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationBar.translucent = NO;
    [self reloadController];
}

- (void)reloadController {
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[FontBook lightFontOfSize:12], NSFontAttributeName, nil];
    self.navigationBar.tintColor = [Settings mainColor];
    self.navigationBar.barTintColor = Settings.appTheme == ApplicationThemeLight ? [UIColor whiteColor] : [UIColor darkGrayColor];
    for (UIViewController * childController in self.viewControllers) {
        if ([childController respondsToSelector:@selector(reloadController)]) {
            [(id)childController reloadController];
        }
    }
}

@end
