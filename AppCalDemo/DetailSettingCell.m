//
//  DetailSettingCell.m
//  AppCalDemo
//
//  Created by Nidhal on 06.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "DetailSettingCell.h"

@interface DetailSettingCell ()

@end

@implementation DetailSettingCell

// Sets the checkmark if the cell has to be cheked.
- (void)setChecked:(BOOL)checked {
    self.accessoryType = checked ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

@end
