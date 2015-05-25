//
//  ViewController.m
//  FarkleNew
//
//  Created by Chee Vue on 5/24/15.
//  Copyright (c) 2015 Chee Vue. All rights reserved.
//

#import "GameViewController.h"
#import "DieLabel.h"

@interface GameViewController () <DieLabelDelegate>

@property (weak, nonatomic) IBOutlet UIButton *rollButton;
@property (weak, nonatomic) IBOutlet DieLabel *firstDieLabel;
@property (weak, nonatomic) IBOutlet DieLabel *secondDieLabel;
@property (weak, nonatomic) IBOutlet DieLabel *thirdDieLabel;
@property (weak, nonatomic) IBOutlet DieLabel *fourthDieLabel;
@property (weak, nonatomic) IBOutlet DieLabel *fifthDieLabel;
@property (weak, nonatomic) IBOutlet DieLabel *sixthDieLabel;
@property NSMutableArray *dices;
@property NSMutableArray *currentDiceSelection;
@property NSMutableArray *hotDiceCombinations;
@property NSArray *firstRollDice; //store array to check for Hot Dice
@property (weak, nonatomic) IBOutlet UILabel *p1TotalScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *p1RoundScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankScoreLabel;

@property int roundScore;
@property int totalScore;
@property int countOfRolls;
@property (weak, nonatomic) IBOutlet UILabel *farkleLabel;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dices = [[NSMutableArray alloc] init];
//    self.dicePositionLabels = [NSMutableArray arrayWithObjects:self.firstDieLabel, self.secondDieLabel, self.thirdDieLabel, self.fourthDieLabel, self.fifthDieLabel, self.sixthDieLabel, nil];

    //Set the delegate properties of all the DieLabels to the ViewController instance.
    self.firstDieLabel.delegate = self;
    self.secondDieLabel.delegate = self;
    self.thirdDieLabel.delegate = self;
    self.fourthDieLabel.delegate = self;
    self.fifthDieLabel.delegate = self;
    self.sixthDieLabel.delegate = self;

    self.currentDiceSelection = [[NSMutableArray alloc] init];
    self.hotDiceCombinations = [[NSMutableArray alloc] init];

    //hide "Farkle" label until player Farkle
    self.farkleLabel.hidden = YES;

    //initialize scores and count of roll
    self.p1TotalScoreLabel.text = @"0";
    self.p1RoundScoreLabel.text = @"0";
    self.bankScoreLabel.text = @"0";
    self.countOfRolls = 0;
    self.roundScore = 0;

}

- (IBAction)onRollButtonPressed:(UIButton *)sender {

//    self.firstRollDice = [[NSArray alloc] initWithObjects:self.firstDieLabel.text, self.secondDieLabel.text, self.thirdDieLabel.text,self.fourthDieLabel.text, self.fifthDieLabel.text, self.sixthDieLabel.text, nil];
//
//    if (self.countOfRolls == 0) {
//
//    }

    DieLabel *dieLabel = [[DieLabel alloc] init];
    //***Test; calling DieLabel's method***
    //int firstNumber = [dieLabel getDieNumber]; //getDieNumber is the random generator
    //[self.firstDieLabel showDieNumber:firstNumber];

    //Check whether a given object is present in the array.
    //If a die label is not present (== NO) in the array then roll die
    if ([self.dices containsObject:self.firstDieLabel] == NO) {
        [self.firstDieLabel showDieNumber:[dieLabel getDieNumber]];
    }

    if ([self.dices containsObject:self.secondDieLabel] == NO) {
        [self.secondDieLabel showDieNumber:[dieLabel getDieNumber]];
    }

    if ([self.dices containsObject:self.thirdDieLabel] == NO) {
        [self.thirdDieLabel showDieNumber:[dieLabel getDieNumber]];
    }

    if ([self.dices containsObject:self.fourthDieLabel] == NO) {
        [self.fourthDieLabel showDieNumber:[dieLabel getDieNumber]];
    }

    if ([self.dices containsObject:self.fifthDieLabel] == NO) {
        [self.fifthDieLabel showDieNumber:[dieLabel getDieNumber]];
    }

    if ([self.dices containsObject:self.sixthDieLabel] == NO) {
        [self.sixthDieLabel showDieNumber:[dieLabel getDieNumber]];
    }

    //hint: You can fast enumerate through your IBOutletCollection of labels
    NSLog(@"Die Position: #1=%@, #2=%@, #3=%@, #4=%@, #5=%@, #6=%@", self.firstDieLabel.text, self.secondDieLabel.text, self.thirdDieLabel.text, self.fourthDieLabel.text, self.fifthDieLabel.text,self.sixthDieLabel.text);

    self.countOfRolls += 1;

}

//-(void)calculateScore: (NSMutableArray *)score displayScoreOnLabel:(UILabel *)displayLabel{
//}

-(void)dieLabelSelector:(id)viewController didSelectDie:(DieLabel *)dieLabel{

    //Add selected die label to array
    if ([self.dices containsObject:dieLabel] == NO) {
        [self.dices addObject:dieLabel];
        [self.currentDiceSelection addObject:dieLabel.text];
        dieLabel.layer.borderColor = [UIColor redColor].CGColor;
        dieLabel.layer.borderWidth = 3;
        NSLog(@"Selected item: %@", dieLabel.text);
        NSLog(@"Dice array count: %i", (int)self.dices.count);

    } else if ([self.dices containsObject:dieLabel] == YES){
        [self.dices removeObject:dieLabel];
        [self.currentDiceSelection removeObject:dieLabel.text];
        dieLabel.layer.borderColor = [UIColor clearColor].CGColor;
        dieLabel.layer.borderWidth = 0;
        NSLog(@"Deselected items: %@", dieLabel);
        NSLog(@"Dice array count: %i", (int)self.dices.count);
    }

    //Count number of instances of Die numbers
    int score = 0;
    int countOfOne = 0;
    int countOfTwo = 0;
    int countOfThree = 0;
    int countOfFour = 0;
    int countOfFive = 0;
    int countOfSix = 0;


//    for (int i = 0; i < self.dices.count; i++) {
//        DieLabel *countString = [self.dices objectAtIndex:i];
//        int count = [countString.text intValue];
//    }

    
    NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray:self.currentDiceSelection];
    countOfOne = (int)[countedSet countForObject:@"1"];
    countOfTwo = (int)[countedSet countForObject:@"2"];
    countOfThree = (int)[countedSet countForObject:@"3"];
    countOfFour = (int)[countedSet countForObject:@"4"];
    countOfFive = (int)[countedSet countForObject:@"5"];
    countOfSix = (int)[countedSet countForObject:@"6"];
    NSLog(@"1s= %i, 2s= %i, 3s= %i, 4s= %i, 5s= %i, 6s= %i", countOfOne, countOfTwo, countOfThree, countOfFour, countOfFive, countOfSix);

    if (countOfOne == 1) {
        score += 100;
    } else if (countOfOne == 2) {
        score += 200;
    } else if (countOfOne == 3) {
        score += 1000;
    } else if (countOfOne == 4) {
        score += 1100;
    } else if (countOfOne == 5) {
        score += 1200;
    } else if (countOfOne == 6) {
        score += 2000;
    }

    if (countOfTwo == 3) {
        score += 200;
    } else if (countOfTwo == 6) {
        score += 400;
    }

    if (countOfThree == 3) {
        score += 300;
    } else if (countOfThree == 6) {
        score += 600;
    }

    if (countOfFour == 3) {
        score += 400;
    } else if (countOfFour == 6) {
        score += 800;
    }

    if (countOfFive == 1) {
        score += 50;
    } else if (countOfFive == 2) {
        score += 100;
    } else if (countOfFive == 3) {
        score += 500;
    } else if (countOfFive == 4) {
        score += 550;
    } else if (countOfFive == 5) {
        score += 600;
    } else if (countOfFive == 6) {
        score += 1000;
    }

    if (countOfSix == 3) {
        score += 600;
    } else if (countOfSix == 6) {
        score += 1200;
    }

    self.roundScore = score;
    self.bankScoreLabel.text= [NSString stringWithFormat:@"%i", self.roundScore];

    [self checkFarkle:self.roundScore];
    [self checkHotDice:self.roundScore];
}

- (void)checkFarkle:(int)score{
    if (self.dices.count == 0 && score == 0)
    {
        self.farkleLabel.text = @"FARKLE!";
    }
}


- (void)checkHotDice:(int)firstScore{

    //int totalDieLabelOnTurn =
    if (self.dices.count == 6 && firstScore >= 350) //minimum combo score is (3) 5's & (3) 2's = 350
    {
        self.farkleLabel.text = @"HOT DICE!";
    }
}



- (IBAction)onBankButtonPressed:(UIButton *)sender {

    self.countOfRolls += 0; //increment count by one each time

    //call the onRollButtonPressed method
    [self performSelector: @selector(onRollButtonPressed:) withObject:self afterDelay: 0.0];

    self.totalScore = self.totalScore + self.roundScore;
    self.p1RoundScoreLabel.text = [NSString stringWithFormat:@"%i", self.roundScore];
    self.p1TotalScoreLabel.text = [NSString stringWithFormat:@"%i",self.totalScore];

    //check for Farkle and Hot Dice
    [self checkFarkle:self.roundScore];
    [self checkHotDice:self.roundScore];

    //reset current die selection
    [self.currentDiceSelection removeAllObjects];

    //reset round score and bank score to 0
    self.roundScore = 0;
    self.bankScoreLabel.text = @"0";

    //disable tap gesture for selected dice labels
    for (UILabel *selectedDieLabel in self.dices) {
        [selectedDieLabel setUserInteractionEnabled:NO];
    }
}





@end
