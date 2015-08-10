//
//  ViewController.h
//  Matchismo
//
//  Created by Bartosz Stelmaszuk on 06/05/15.
//  Copyright (c) 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface ViewController : UIViewController

//protected
//for subclass
- (Deck *) createDeck;

@end

