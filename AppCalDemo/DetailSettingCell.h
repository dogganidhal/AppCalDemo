//
//  DetailSettingCell.h
//  AppCalDemo
//
//  Created by Nidhal on 06.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>

// This class is a subclass of UITableViewCell, it handles the display of choices and the current selected one, used in DetailSettingController.

@interface DetailSettingCell : UITableViewCell

// A boolean indicates whether the cell should be cheked or not.
@property (nonatomic) BOOL checked;

@end
