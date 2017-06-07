//
//  FontBook.m
//  AppCalDemo
//
//  Created by Nidhal on 07.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "FontBook.h"

@interface FontBook ()

@property (nonatomic, strong, class, readonly) NSArray<NSArray<NSDictionary *> *> *plistData;
@property (nonatomic, strong, class, readonly) NSDictionary *plistFontData;

@end

@implementation FontBook

+ (UIFont *)lightFontOfSize:(CGFloat)size {
    NSNumber *selectedFont = [[[self.plistData objectAtIndex:1] objectAtIndex:2] objectForKey:@"selectedValue"];
    NSArray<NSString *> *allValues = [[[self.plistData objectAtIndex:1] objectAtIndex:2] objectForKey:@"allValues"];
    NSString *fontName = [allValues objectAtIndex:selectedFont.integerValue];
    return [UIFont fontWithName:[[self.plistFontData objectForKey:fontName] objectForKey:@"Light"] size:size];
}

+ (UIFont *)regularFontOfSize:(CGFloat)size {
    NSNumber *selectedFont = [[[self.plistData objectAtIndex:1] objectAtIndex:2] objectForKey:@"selectedValue"];
    NSArray<NSString *> *allValues = [[[self.plistData objectAtIndex:1] objectAtIndex:2] objectForKey:@"allValues"];
    NSString *fontName = [allValues objectAtIndex:selectedFont.integerValue];
    return [UIFont fontWithName:[[self.plistFontData objectForKey:fontName] objectForKey:@"Regular"] size:size];
}

+ (UIFont *)boldFontOfSize:(CGFloat)size {
    NSNumber *selectedFont = [[[self.plistData objectAtIndex:1] objectAtIndex:2] objectForKey:@"selectedValue"];
    NSArray<NSString *> *allValues = [[[self.plistData objectAtIndex:1] objectAtIndex:2] objectForKey:@"allValues"];
    NSString *fontName = [allValues objectAtIndex:selectedFont.integerValue];
    return [UIFont fontWithName:[[self.plistFontData objectForKey:fontName] objectForKey:@"Bold"] size:size];
}

+ (NSDictionary *)plistFontData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Fonts" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    [dict writeToFile:filePath atomically:YES];
    return  dict;
}

+ (NSArray *)plistData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
    NSArray *dict = [NSArray arrayWithContentsOfFile:filePath];
    [dict writeToFile:filePath atomically:YES];
    return  dict;
}

@end
