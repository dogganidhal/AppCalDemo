//
//  SettingsController.h
//  AppCalDemo
//
//  Created by Dogga Nidhal on 05/06/2017.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

// This class is a subclass of UITableViewController, which handles the reading, writing and displaying the settings plist-based. 

@interface SettingsController : UITableViewController

- (void)reload;
- (void)reloadController;

@end
