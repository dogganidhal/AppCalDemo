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

// UILabel instance to display the current value string if any.
@property (nonatomic, strong) UILabel *currentValueLabel;
// A reference to the disclosure button, used to set contraints on the current value label.
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

// Basic setup from the settings of the cell.
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

// Setter of the current value property, which garantees the update of the label's text.
- (void)setCurrentValue:(NSString *)currentValue {
    _currentValueLabel.text = currentValue;
    _currentValueLabel.hidden = NO;
    _currentValueLabel.font = [FontBook regularFontOfSize:16];
    [_currentValueLabel sizeToFit];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    // Referencing the disclosure button. 
    for (UIView *subview in self.subviews) {
        if (subview.class == UIButton.class) {
            _disclosureButton = subview;
            break;
        }
    }
    [[_disclosureButton.leadingAnchor constraintEqualToAnchor:_currentValueLabel.trailingAnchor constant:8] setActive:YES];
}

@end
