//
//  FontBook.h
//  AppCalDemo
//
//  Created by Nidhal on 07.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontBook : NSObject

+ (UIFont *)lightFontOfSize:(CGFloat)size;
+ (UIFont *)regularFontOfSize:(CGFloat)size;
+ (UIFont *)boldFontOfSize:(CGFloat)size;

@end
