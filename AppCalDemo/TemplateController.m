//
//  ViewController.m
//  AppCalDemo
//
//  Created by Dogga Nidhal on 05/06/2017.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "TemplateController.h"
#import "Settings.h"

@interface TemplateController ()

@end

@implementation TemplateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Customization
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [Settings mainColor];
    // Dealing with the appTheme
    self.navigationBar.barTintColor = Settings.appTheme == ApplicationThemeLight ? [UIColor whiteColor] : [UIColor darkGrayColor];
}

@end
