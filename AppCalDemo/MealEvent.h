//
//  FoodEvent.h
//  AppCalDemo
//
//  Created by Nidhal on 19.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "CalendarEvent.h"

typedef NS_ENUM(NSInteger, FoodEventType) {
    FoodEventTypeBreakfast,
    FoodEventTypeLunch,
    FoodEventTypeDinner
};

@interface MealEvent : CalendarEvent

@property (nonatomic) FoodEventType type;
@property (nonatomic, strong) NSData *photoData;

@end
