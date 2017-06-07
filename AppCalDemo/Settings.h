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

@property (nonatomic, class, readonly) ApplicationTheme appTheme;
//@property (nonatomic, strong, class) NSString *language;
@property (nonatomic, class, readonly) NSString *firstDayOfTheWeek;
//@property (nonatomic, strong, class) NSString *dataServer;
@property (nonatomic, strong, class, readonly) NSString *currentDaySelectionShape;
@property (nonatomic, strong, class, readonly) UIColor *currentDaySelectionColor;

@end
