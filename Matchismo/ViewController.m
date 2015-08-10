//
//  ViewController.m
//  Matchismo
//
//  Created by Bartosz Stelmaszuk on 06/05/15.
//  Copyright (c) 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;
@property (nonatomic) NSInteger selectedGameMode;
@property (weak, nonatomic) IBOutlet UILabel *playerMoveOutput;
@property (nonatomic) NSInteger scoreChange;
@property (strong, nonatomic) NSMutableArray *selectedCards;

@end

@implementation ViewController
const int RESTART_SELECTEDCARDS_ARRAY = -1;

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (Deck *) createDeck //abstract
{
    return nil;
}
- (IBAction)newGameButton:(id)sender {
    
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    self.gameModeControl.enabled = 1;
    [self updateUI: RESTART_SELECTEDCARDS_ARRAY];
}
- (IBAction)gameModeButton:(UISegmentedControl *)sender {
    self.selectedGameMode = [(UISegmentedControl *)sender selectedSegmentIndex]+2;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSInteger previousScore = self.game.score;
    NSInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex gameMode: self.selectedGameMode];
    self.gameModeControl.enabled = 0;
    self.scoreChange = (long)self.game.score - previousScore;
    [self updateUI: chosenButtonIndex];

}
- (NSMutableArray *)selectedCards
{
    if(!_selectedCards) _selectedCards = [[NSMutableArray alloc] init];
    return _selectedCards;
}
- (void) updateUI: (NSInteger) chosenButtonIndex
{
    NSString *string = @"";
    for (UIButton *cardButton in self.cardButtons) {
        NSInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle: [self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
    
    Card *card = [self.game cardAtIndex:chosenButtonIndex];
    
    if (self.scoreChange != 0 && chosenButtonIndex != -1) {
        [self.selectedCards addObject:card];
    }
    for( Card *myObject in self.selectedCards) {
        string = [string stringByAppendingFormat:@"%@ ", myObject.contents];
    }
    if (self.scoreChange == -1) {
        
        string = [string stringByAppendingString:@"is chosen "];
        self.playerMoveOutput.text = string;
    
    } else if (self.scoreChange == 0) {
    
        [self.selectedCards removeObject:[self.game cardAtIndex:chosenButtonIndex]];
        NSString *string2 = @"";
        for( Card *myObject in self.selectedCards) {
            string2 = [string2 stringByAppendingFormat:@"%@ ", myObject.contents];
        }
        string2 = [string2 stringByAppendingFormat:@"chose next card!"];
        self.playerMoveOutput.text = string2;
    
    } else if (self.scoreChange > 0) {
      
        string = [string stringByAppendingFormat:@"is a pair! It scores: %ld", (long)self.scoreChange];
        self.playerMoveOutput.text = string;
        [self.selectedCards removeAllObjects];
    
    } else if (self.scoreChange < 0 && chosenButtonIndex != -1) {
    
        string = [string stringByAppendingFormat:@"is NOT a pair! It scores: %ld", (long)self.scoreChange];
        self.playerMoveOutput.text = string;
        [self.selectedCards removeAllObjects];
        [self.selectedCards addObject:card];
    
    } else if (chosenButtonIndex == -1){    //changing gamemode during game
        [self.selectedCards removeAllObjects];
    }
}

- (NSString *)titleForCard: (Card *) card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard: (Card *) card
{
    return [UIImage imageNamed: (card.isChosen) ? @"cardfront" : @"Pati"];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.selectedGameMode = 2;
}

@end
