//
//  Deck.h
//  Matchismo
//
//  Created by Bartosz Stelmaszuk on 06/05/15.
//  Copyright (c) 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop: (BOOL)atTop;
- (void)addCard: (Card *)card;

- (Card *)drawRandomCard;
@end
