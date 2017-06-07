//
//  Settings.h
//  AppCalDemo
//
//  Created by Nidhal on 07.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontBook.h"
#import "AppDelegate.h"

@interface Settings : NSObject

@property (nonatomic, class) ApplicationTheme appTheme;
//@property (nonatomic, strong, class) NSString *language;
@property (nonatomic, class) NSString *firstDayOfTheWeek;
//@property (nonatomic, strong, class) NSString *dataServer;
@property (nonatomic, strong, class) NSString *currentDaySelectionShape;
//@property (nonatomic, strong, class) UIColor *currentDaySelectionColor;

@end
