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
@property (nonatomic, strong) UIView *disclosureButton;

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
    _currentValueLabel.textColor = [UIColor lightGrayColor];
    [_currentValueLabel sizeToFit];
    [_currentValueLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_currentValueLabel];
    
    [[self.centerYAnchor constraintEqualToAnchor:_currentValueLabel.centerYAnchor] setActive:YES];
    _currentValueLabel.hidden = YES;
    
}

- (void)setCurrentValue:(NSString *)currentValue {
    _currentValueLabel.text = currentValue;
    _currentValueLabel.hidden = NO;
    _currentValueLabel.font = [FontBook regularFontOfSize:16];
    [_currentValueLabel sizeToFit];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subview in self.subviews) {
        if (subview.class == UIButton.class) {
            _disclosureButton = subview;
            break;
        }
    }
    [[_disclosureButton.leadingAnchor constraintEqualToAnchor:_currentValueLabel.trailingAnchor constant:8] setActive:YES];
}

@end
