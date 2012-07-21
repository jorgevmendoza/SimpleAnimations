//
//  FirstViewController.h
//  SimpleAnimation
//
//  Created by Michael Patrick Ellard on 5/28/12.
//  Copyright (c) 2012 Michael Patrick Ellard. All rights reserved.
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by/3.0/ or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

#import <UIKit/UIKit.h>

@class SALetterLabel;

@interface FirstViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UILabel *startingA;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *letters;

@property (strong, nonatomic) SALetterLabel *firstLetter;

@property (strong, nonatomic) NSArray *allLetters;

@property (strong, nonatomic) NSMutableArray *containerViews;
@property (strong, nonatomic) NSMutableArray *cardBacks;

@end
