//
//  FootballDataManager.h
//  FBAPI
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Appsolute GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FootballDataManager : NSObject

- (NSArray *)fixtures;
- (NSArray *)teams;

@end
