//
//  FootballDataManager.m
//  FBAPI
//
//  Created by Nidhal on 08.06.17.
//  Copyright © 2017 Appsolute GmbH. All rights reserved.
//

#import "FootballDataManager.h"

@interface FootballDataManager ()

@property (nonatomic, strong) NSString *apiURL;
@property (nonatomic, strong) NSDictionary *apiData;
@property (nonatomic, strong) NSObject *bundesLiga;

@end

@implementation FootballDataManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _apiURL = @"https://api.football-data.org/v1/competitions/430";
        NSError *error;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_apiURL]];
        _apiData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    }
    return self;
}

- (NSArray *)fixtures {
    NSError *error;
    NSString *fixturesURL = [[[_apiData objectForKey:@"_links"] objectForKey:@"fixtures"] objectForKey:@"href"];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fixturesURL]];
    NSArray *fixtures = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"fixtures"];
    return fixtures;
}

- (NSArray *)teams {
    NSError *error;
    NSString *fixturesURL = [NSString stringWithFormat:@"%@/teams", _apiURL];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fixturesURL]];
    NSArray *teams = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"teams"];
    return teams;
}

@end






