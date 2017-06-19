//
//  FootballEvent.m
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "FootballEvent.h"

@implementation FootballEvent

+ (instancetype)EventFromDictionary:(NSDictionary *)event {
    FootballEvent *returnedEvent = [super EventFromDictionary:event];
    returnedEvent.league = [event valueForKey:@"LEAGUE"];
    returnedEvent.matchday = (NSInteger)[event valueForKey:@"MATCHDAY"];
    returnedEvent.homeTeam = [event valueForKey:@"HOMETEAM"];
    returnedEvent.awayTeam = [event valueForKey:@"AWAYTEAM"];
    return returnedEvent;
    
}

@end
