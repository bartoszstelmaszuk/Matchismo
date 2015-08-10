//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Bartosz Stelmaszuk on 18/06/15.
//  Copyright (c) 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designed initializer
- (instancetype)initWithCardCount:(NSUInteger) count
                        usingDeck:(Deck *)deck;
- (void) chooseCardAtIndex:(NSUInteger)index gameMode: (NSUInteger) gameMode;
- (Card *)cardAtIndex:(NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;

@end
