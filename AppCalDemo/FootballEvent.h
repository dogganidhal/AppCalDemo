//
//  FootballEvent.h
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "CalendarEvent.h"

@interface FootballEvent : CalendarEvent

@property (nonatomic, strong) NSString *league;
@property (nonatomic, strong) NSString *homeTeam;
@property (nonatomic, strong) NSString *awayTeam;
@property (nonatomic) NSInteger matchday;

@end
