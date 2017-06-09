//
//  CalendarController.h
//  AppCalDemo
//
//  Created by Nidhal on 07.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "TemplateController.h"

@protocol CalendarControllerDelegate <NSObject>

@optional
- (void)didChangeSegmentedControlValue:(NSInteger)newValue;

@end

@interface CalendarController : TemplateController

@property (nonatomic) BOOL showsToolbar;

@property (nonatomic, strong) UINavigationBar *navbar;
@property (nonatomic, retain) id <CalendarControllerDelegate> segmentDelegate;

- (void)setSegmentValue:(NSInteger)index;

@end

