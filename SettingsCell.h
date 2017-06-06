//
//  SettingsCell.h
//  AppCalDemo
//
//  Created by Nidhal on 06.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SettingsCell : UITableViewCell

@property (nonatomic) ApplicationTheme appTheme;
@property (nonatomic, strong) NSString * _Nullable currentValue;

@end
