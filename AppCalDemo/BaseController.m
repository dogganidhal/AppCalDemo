//
//  BaseController.m
//  AppCalDemo
//
//  Created by Dogga Nidhal on 05/06/2017.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "BaseController.h"
#import "FontBook.h"
#import "Settings.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Setup the logo on the navigation bar
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"AppCalDemo";
    titleLabel.font = [FontBook boldFontOfSize:18];
    titleLabel.textColor = [Settings mainColor];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    // Other setup
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
