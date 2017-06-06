//
//  ViewController.m
//  AppCalDemo
//
//  Created by Dogga Nidhal on 05/06/2017.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "TemplateController.h"

@interface TemplateController ()

@end

@implementation TemplateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Getting theme property from the NSUserDefaults
    NSString *theme = [[NSUserDefaults standardUserDefaults] stringForKey:@"theme"];
    _appTheme = [theme isEqualToString:@"light"] ? ApplicationThemeLight : ApplicationThemeDark;
    
    
    // Customization
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor orangeColor];
    // Dealing with the appTheme
    self.navigationBar.barTintColor = _appTheme == ApplicationThemeLight ? [UIColor whiteColor] : [UIColor darkGrayColor];
    
}

@end
