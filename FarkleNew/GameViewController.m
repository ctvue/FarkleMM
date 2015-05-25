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
@property (weak, nonatomic) IBOutlet UILabel *p1TotalScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *p1RoundScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankScoreLabel;

@property int roundScore;
@property int totalScore;
@property int countOfRolls;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dices = [[NSMutableArray alloc] init];
//    self.dicePositionLabels = [NSArray arrayWithObjects:self.firstDieLabel, self.secondDieLabel, self.thirdDieLabel, self.fourthDieLabel, self.fifthDieLabel, self.sixthDieLabel, nil];

    //Set the delegate properties of all the DieLabels to the ViewController instance.
    self.firstDieLabel.delegate = self;
    self.secondDieLabel.delegate = self;
    self.thirdDieLabel.delegate = self;
    self.fourthDieLabel.delegate = self;
    self.fifthDieLabel.delegate = self;
    self.sixthDieLabel.delegate = self;

    self.currentDiceSelection = [[NSMutableArray alloc] init];

    //initialize scores and count of roll
    self.p1TotalScoreLabel.text = @"0";
    self.p1RoundScoreLabel.text = @"0";
    self.bankScoreLabel.text = @"0";
    self.countOfRolls = 0;
    self.roundScore = 0;

}

- (IBAction)onRollButtonPressed:(UIButton *)sender {
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

}

//-(void)calculateScore: (NSMutableArray *)score displayScoreOnLabel:(UILabel *)displayLabel{
//
//
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
//        if (count == 1)
//            countOne ++;
//        if (count == 2)
//            countOne ++;
//        if (count == 3)
//            countOne ++;
//        if (count == 4)
//            countOne ++;
//        if (count == 5)
//            countOne ++;
//        if (count == 6)
//            countOne ++;
//    }

    
        NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray:self.currentDiceSelection];
        countOfOne = (int)[countedSet countForObject:@"1"];
        countOfTwo = (int)[countedSet countForObject:@"2"];
        countOfThree = (int)[countedSet countForObject:@"3"];
        countOfFour = (int)[countedSet countForObject:@"4"];
        countOfFive = (int)[countedSet countForObject:@"5"];
        countOfSix = (int)[countedSet countForObject:@"6"];
        NSLog(@"1s= %i, 2s= %i, 3s= %i, 4s= %i, 5s= %i, 6s= %i", countOfOne, countOfTwo, countOfThree, countOfFour, countOfFive, countOfSix);

//        NSLog(@"1s= %i, 2s= %i, 3s= %i, 4s= %i, 5s= %i, 6s= %i", countOne, countTwo
//          , countThree, countFour, countFive, countSix);

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
            score += 150;
        } else if (countOfFive == 4) {
            score += 200;
        } else if (countOfFive == 5) {
            score += 500;
        } else if (countOfFive == 6) {
            score += 550;
        }

        if (countOfSix == 3) {
            score += 600;
        } else if (countOfSix == 6) {
            score += 1200;
        }

    self.roundScore = score;
    self.bankScoreLabel.text= [NSString stringWithFormat:@"%i", self.roundScore];
}



- (IBAction)onBankButtonPressed:(UIButton *)sender {

    self.countOfRolls += 0; //increment count by one each time

    self.totalScore = self.totalScore + self.roundScore;
    self.p1RoundScoreLabel.text = [NSString stringWithFormat:@"%i", self.roundScore];
    self.p1TotalScoreLabel.text = [NSString stringWithFormat:@"%i",self.totalScore];

    
    //reset current die selection
    [self.currentDiceSelection removeAllObjects];

    //reset round score and bank score to 0
    self.roundScore = 0;
    self.bankScoreLabel.text = @"0";

}

//-(UIButton *)createButtonWithTitle:(NSString *)title {
//
//    CGPoint point = CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height);
//    point.x -= 100;
//    point.y -= 100;
//
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(point.x, point.y, 50, 50)];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button setTitle:title forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor whiteColor];
//    button.layer.borderColor = [UIColor blackColor].CGColor;
//    button.layer.borderWidth = 1;
//    button.layer.cornerRadius = button.bounds.size.height/2;
//    [self.view addSubview:button];
//
//    return button;
//}
//
//-(UILabel *)createLabelWithTitle:(NSString *)title withTextColor:(UIColor *)textColor withBackgroundColor:(UIColor *)backgroundColor{
//
//    CGPoint point = CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height);
//    point.x = point.x - 100;
//    point.y = point.y - 100;
//    //point.y -= 100;
//    UILabel *label = [[UILabel alloc] init];
//    //UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(point.x, point.y, 50, 50)];
//    label.text = title;
//    label.textColor = textColor;
//    label.backgroundColor = backgroundColor;
//    //label.backgroundColor = [UIColor whiteColor];
//    label.layer.borderColor = [UIColor blackColor].CGColor;
//    label.layer.borderWidth = 2;
//    //label.layer.cornerRadius = label.bounds.size.height/2;
//    [self.view addSubview:label];
//
//    return label;
//
//}





@end
