//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Bartosz Stelmaszuk on 16/07/15.
//  Copyright (c) 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"
@interface PlayingCardViewController ()

@end

@implementation PlayingCardViewController

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
