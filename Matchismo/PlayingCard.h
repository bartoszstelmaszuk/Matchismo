//
//  PlayingCard.h
//  Matchismo
//
//  Created by Bartosz Stelmaszuk on 06/05/15.
//  Copyright (c) 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
