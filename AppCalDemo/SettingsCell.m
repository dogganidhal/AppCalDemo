//
//  SettingsCell.m
//  AppCalDemo
//
//  Created by Nidhal on 06.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "SettingsCell.h"
#import "FontBook.h"
#import "Settings.h"

@interface SettingsCell()

@property (nonatomic, strong) UILabel *currentValueLabel;

@end

@implementation SettingsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    _currentValueLabel = [[UILabel alloc] init];
    _currentValueLabel.font = [FontBook regularFontOfSize:16];
    _currentValueLabel.textColor = Settings.appTheme == ApplicationThemeLight ? [UIColor lightGrayColor] : [UIColor lightGrayColor];
    [_currentValueLabel sizeToFit];
    [_currentValueLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_currentValueLabel];
    [[self.trailingAnchor constraintEqualToAnchor:_currentValueLabel.trailingAnchor constant:32] setActive:YES];
    [[self.centerYAnchor constraintEqualToAnchor:_currentValueLabel.centerYAnchor] setActive:YES];
    _currentValueLabel.hidden = YES;
}

- (void)setCurrentValue:(NSString *)currentValue {
    _currentValueLabel.text = currentValue;
    _currentValueLabel.hidden = NO;

}

@end
