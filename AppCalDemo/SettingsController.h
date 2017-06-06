//
//  SettingsController.h
//  AppCalDemo
//
//  Created by Dogga Nidhal on 05/06/2017.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SettingsController : UITableViewController<UINavigationControllerDelegate>

@property (nonatomic) ApplicationTheme appTheme;

- (void)reload;

@end
