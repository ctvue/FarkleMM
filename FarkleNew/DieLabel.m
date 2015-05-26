//
//  DieLabel.m
//  FarkleNew
//
//  Created by Chee Vue on 5/24/15.
//  Copyright (c) 2015 Chee Vue. All rights reserved.
//

#import "DieLabel.h"

@implementation DieLabel

//This method gets called first. When image gets created it calls the initWithCoder method for each die view image
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //Create new uiimageview and assign to property; calling initWithFrame so it knows where to put it based on CGRect;
        //set to as wide as die label's height and width
        self.dieImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

        self.backgroundColor = [UIColor clearColor]; //clear background
        self.userInteractionEnabled = YES;  //enable user interaction and tap gesture on die labels
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onLabelTap)];
        [self addGestureRecognizer:tapGesture];
        
        [self addSubview:self.dieImageView];  //add the imageview to the view
    }

    return self;

}

- (void)showDieNumber:(int)num {
    //construct filename based on input parameter
    NSString *fileName = [NSString stringWithFormat:@"dice%d.png", num];

    //set the image to the imageview
    self.dieImageView.image = [UIImage imageNamed:fileName];
    self.text = [NSString stringWithFormat:@"%i", num];  //set label text value
}

- (int)getDieNumber{
    int random = (arc4random() % 6) + 1;  //give from 1 to 6
//    self.text = [NSString stringWithFormat:@"%i", random];
    return random;
}

//- (void)roll {
//    int random = (arc4random() % 6) + 1;  //give from 1 to 6
//    self.text = [NSString stringWithFormat:@"%i", random];
//}

-(void)onLabelTap{
    [self.delegate dieLabelSelector:self didSelectDie:self];
    //NSLog(@"Die Value: %@", self.text);
}



@end
