//
//  DetailSettingController.h
//  AppCalDemo
//
//  Created by Nidhal on 06.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

// This class is a subclass of UITableViewController, which displays the available choices.

@interface DetailSettingController : UITableViewController<UINavigationControllerDelegate>

// Convenience initializer, with indexPath of the sender cell.
- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath;

@end
