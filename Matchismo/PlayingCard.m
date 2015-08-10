//
//  PlayingCard.m
//  Matchismo
//
//  Created by Bartosz Stelmaszuk on 06/05/15.
//  Copyright (c) 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

+ (NSArray *) validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *) rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    NSArray *rankString = [PlayingCard rankStrings];
    NSMutableArray *currentSuits = [[NSMutableArray alloc] init]; // of NSStrings
    NSMutableArray *currentRanks = [[NSMutableArray alloc] init]; // of NSUIntegers
   [currentSuits addObject: (NSString *)self.suit];
   [currentRanks addObject: (NSString *)rankString[self.rank]];
    
    for (PlayingCard *otherCard in otherCards ){
        if ([currentRanks containsObject:rankString[otherCard.rank]]) {
            score += 4;
        } else if ([currentSuits containsObject:otherCard.suit]) {
            score += 1;
        }
        if (![currentSuits containsObject:otherCard.suit]) {
            [currentSuits addObject:otherCard.suit];
        }
        if (![currentRanks containsObject:rankString[otherCard.rank]]) {
            [currentRanks addObject: (NSString *)rankString[otherCard.rank]];
        }
    }
    
    [currentSuits removeAllObjects];
    [currentRanks removeAllObjects];
    return score;
}

-(NSString *)contents
{
    NSArray *rankString = [PlayingCard rankStrings];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit: (NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank=rank;
    }
}

@end
