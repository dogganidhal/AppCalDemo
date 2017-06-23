//
//  SettingsCell.h
//  AppCalDemo
//
//  Created by Nidhal on 06.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

// This class is a subclass of UITableViewCell, which handles the display of a current value label at the left corner, used in SettingsController.

@interface SettingsCell : UITableViewCell

// String indicates the current value of the object represented by this cell. 
@property (nonatomic, strong) NSString * _Nullable currentValue;

@end
