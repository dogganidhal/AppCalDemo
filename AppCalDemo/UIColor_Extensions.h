//
//  UIColor_Extensions.h
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexCode)

+ (UIColor *)colorFromHex:(NSInteger)netHex;

@end

@implementation UIColor (HexCode)

+ (UIColor *)colorFromHex:(NSInteger)netHex {
    return [UIColor colorWithRed:((float)((netHex & 0xFF0000) >> 16))/255.0 \
                           green:((float)((netHex & 0x00FF00) >>  8))/255.0 \
                            blue:((float)((netHex & 0x0000FF) >>  0))/255.0 \
                           alpha:1.0];
}

@end
