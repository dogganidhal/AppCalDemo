//
//  CalendarNavigationBar.m
//  AppCalDemo
//
//  Created by Nidhal on 12.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "CalendarNavigationBar.h"
#import "Settings.h"
#import "FontBook.h"

const CGFloat CalendarNavigationBarHeightIncrease = 40;

@implementation CalendarNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = [super sizeThatFits:size];
    newSize.height += CalendarNavigationBarHeightIncrease;
    return newSize;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSArray *classNamesToReposition = @[@"UINavigationItemView", @"UINavigationButton", @"_UINavigationBarBackIndicatorView"];
    for (UIView *view in [self subviews]) {
        if ([classNamesToReposition containsObject:NSStringFromClass([view class])]) {
            CGRect frame = [view frame];
            frame.origin.y -= CalendarNavigationBarHeightIncrease;
            [view setFrame:frame];
        }
    }
}

- (void)initialize {
    [self setTitleVerticalPositionAdjustment:-(CalendarNavigationBarHeightIncrease) forBarMetrics:UIBarMetricsDefault];
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"Year", @"Month", @"Day"]];
    [self addSubview:self.segment];
    [self.segment setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self.segment.centerXAnchor constraintEqualToAnchor:self.centerXAnchor] setActive:YES];
    [[self.segment.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-12] setActive:YES];
    self.segment.selectedSegmentIndex = 1;
    [self.segment addTarget:self action:@selector(segmentControlDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self reloadView];
}

- (void)segmentControlDidChangeValue:(NSInteger)newValue {
    if ([self.delegate respondsToSelector:@selector(segmentControlDidChangeValue:)]) {
        [(id)self.delegate segmentControlDidChangeValue:self.segment.selectedSegmentIndex];
    }
}

- (void)reloadView {
    self.segment.tintColor = Settings.mainColor;
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:[FontBook lightFontOfSize:12] forKey:NSFontAttributeName] forState:UIControlStateNormal];
}

@end











