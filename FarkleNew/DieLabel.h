//
//  DieLabel.h
//  FarkleNew
//
//  Created by Chee Vue on 5/24/15.
//  Copyright (c) 2015 Chee Vue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DieLabelDelegate <NSObject>

- (void)dieLabelSelector:(id)viewController didSelectDie:(UILabel *)dieLabel;

//-(void)drinkTableViewCell:(id)cell didSelectImage:(UIImage *)image;
//-(void)drinkTableViewCell:(id)cell didTapButton:(UIButton *)sender;

@end

@interface DieLabel : UILabel

@property (nonatomic) UIImageView *dieImageView;
@property (nonatomic) id <DieLabelDelegate> delegate;

- (void)showDieNumber:(int)num;
- (int)getDieNumber;
- (void)roll;


@end
