//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Bartosz Stelmaszuk on 18/06/15.
//  Copyright (c) 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import "CardMatchingGame.h"

static const NSUInteger MISMATCH_PENALTY = 2;
static const NSUInteger MATCH_BONUS = 4;
static const NSUInteger COST_TO_CHOOSE = 1;

@interface CardMatchingGame()
@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic,strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSMutableArray *selectedCards;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i =0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        self.score = 0;
        _selectedCards = [NSMutableArray array];
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index gameMode:(NSUInteger)gameMode
{
    Card *card= [self cardAtIndex: index];
    
        if (!card.isMatched) {
            if (card.isChosen){
                card.chosen = NO;
                [self.selectedCards removeObject:card];
            } else {
                if ([self.selectedCards count] < gameMode - 1)
                {
                    [self.selectedCards addObject: card];
                }
                else
                {
                    int matchScore = [card match:self.selectedCards];
                    self.score += matchScore * MATCH_BONUS;
                    
                    if (matchScore > 0) {
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                    }
                    
                    for (Card *otherCard in self.selectedCards){
                        
                        if (matchScore > 0) {
                            otherCard.matched = YES;
                            card.matched = YES;
                        } else {
                            otherCard.chosen = NO;
                        }
                    }
                    [self.selectedCards removeAllObjects];
                    if (matchScore <=0) {
                        [self.selectedCards addObject: card];
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
}
@end
