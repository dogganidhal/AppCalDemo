//
//  BaseController.m
//  AppCalDemo
//
//  Created by Dogga Nidhal on 05/06/2017.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Setup the logo on the navigation bar
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"AppCalDemo";
    titleLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:18];
    titleLabel.textColor = [UIColor orangeColor];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    // Other setup
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
