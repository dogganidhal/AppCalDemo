//
//  CalendarNavigationBar.h
//  AppCalDemo
//
//  Created by Nidhal on 12.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalendarNavigationBarDelegate <UINavigationBarDelegate>

@optional
- (void)segmentControlDidChangeValue:(NSInteger)newValue;
- (void)setSegmentControlValue:(NSInteger)newValue;

@end

@interface CalendarNavigationBar : UINavigationBar

@property (nonatomic, strong) UISegmentedControl *segment;

- (void)reloadView;

@end
