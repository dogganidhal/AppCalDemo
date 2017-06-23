//
//  AppsoluteCalendar+AppCalDemo.h
//  AppCalDemo
//
//  Created by Nidhal on 12.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <AppsoluteCalendar/AppsoluteCalendar.h>

@interface AppsoluteCalendar (AppCalDemo)

@property (nonatomic, strong, class, readonly) AppsoluteCalendar *shared;
- (void)setCustomizationOnCalendar;

@end
