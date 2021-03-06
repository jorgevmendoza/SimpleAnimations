//
//  ProblemAnimations.m
//  SimpleAnimation
//
//  Created by Michael Patrick Ellard on 7/20/12.
//  Copyright (c) 2012 Michael Patrick Ellard. All rights reserved.
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by/3.0/ or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

#import "ProblemAnimations.h"

@interface ProblemAnimations ()

@end

@implementation ProblemAnimations
@synthesize jerkyStar;
@synthesize correctStar;
@synthesize immobileStar;
@synthesize wrongWayStar;
@synthesize transformAndRotateStar;

@synthesize flipTooMuchView;
@synthesize flipTooLittleView;
@synthesize flipTooLittleBacking;
@synthesize flipCorrectlyView;
@synthesize flipCorrectlyBacking;
@synthesize rotateColorProblemView;
@synthesize rotateColorWorkingView;
@synthesize nonFadingStar;
@synthesize blinkStar;
@synthesize blinkHelperView;
@synthesize fadeStar;

#pragma mark Standard Viewcontroller Housekeeping methods

// There's not much going on here in initWithNibName.  We do set the title and tab bar image so that this view controller's name and image will be shown in the tab bar.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Problems", @"Problems");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

// A standard viewDidUnload here.  All the code in this method was automatically created by Xcode when we dragged established connections between our .xib file and our .h file using the Connections Inspector in Interface Builder.  

- (void)viewDidUnload
{
    [self setBlinkStar:nil];
    [self setFadeStar:nil];
    [self setRotateColorProblemView:nil];
    [self setRotateColorWorkingView:nil];
    [self setFlipTooMuchView:nil];
    [self setFlipTooLittleView:nil];
    [self setFlipTooLittleBacking:nil];
    [self setFlipCorrectlyView:nil];
    [self setFlipCorrectlyBacking:nil];
    [self setImmobileStar:nil];
    [self setWrongWayStar:nil];
    [self setJerkyStar:nil];
    [self setCorrectStar:nil];
    [self setNonFadingStar:nil];
    [self setBlinkHelperView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Star Fade examples

//  The following animation doesn't work.  The star doesn't fade out or even become hidden.  It just kind of flickers for a second. 

//  It appears that what's happening here is this:  'hidden' is not an animatable property, so shere is nothing animatable in this code.  Thus,  UIView applies the hidden property immediately.  UIView doesn't take a full second to do the initial animation, since there's nothing to animate for the requested duration.  Thus, it goes directly to the completion block, where there's also nothing to animate.  The result is that the star flickers out (i.e. is hidden) for a fraction of a second, and then is unhidden again.  

//  The lesson to take away here is that not every UIView or CALayer property is animatable.  The documentation is usually pretty clear about which properties are animatable and which aren't - if you're not sure, check the documentation or do a quick using some test code.   


- (IBAction)doNotFadeTapped:(id)sender 
{   
    [UIView animateWithDuration:1.0 animations:^
     {
         self.nonFadingStar.hidden = true;
     }
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:1.0 animations:^
          {
              self.nonFadingStar.hidden = false;
          }];
     }];
}

//  In this example, the star doesn't fade.  It just blinks out.  This is better, but still not what we want.  

//  Our code here is essentially the same as the code above, but I've added a change to an animatable property along with my request to set the star's property to hidden.  The change is a barely noticable color change to a tiny helper view, but this is enough so that the initial animation block and the completion block will take the full duration that I've requested to complete.  

//  While the animated parts take a second to complete, hidden is not animatable and takes effect immediately.  


- (IBAction)blinkTapped:(id)sender 
{
    [UIView animateWithDuration:1.0 animations:^
    {
        self.blinkStar.hidden = true;
        self.blinkHelperView.backgroundColor = [UIColor darkGrayColor];
        
    }
     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:1.0 animations:^
          {
              self.blinkStar.hidden = false;
              self.blinkHelperView.backgroundColor = [UIColor blackColor];
          }];

     }];
}

// This animation works.  The code is essentially the same as doNotFadeTapped:, but in this case we're using the alpha property, so everything animates nicely.  Views with an alpha of 0 are just like views whose hidden value is true - they're not visible and they don't respond to touch events.  

- (IBAction)fadeTapped:(id)sender 
{   
    [UIView animateWithDuration:1.0 animations:^
     {
         self.fadeStar.alpha = 0;
     }
     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:1.0 animations:^
          {
              self.fadeStar.alpha = 1;
          }];
     }];
}

#pragma mark - Color Rotation

// The following animation won't work.  UIView only animates one change to a particular property at a time - a new animation request for a property that is already being animated will cancel the existing animation and replace it with the new animation request.  Since the same animatable property is being changed multiple times in the code below, all of the changes except the last change are ignored.  

- (IBAction)dontRotateColors:(id)sender 
{
    [UIView animateWithDuration:3.0 animations:^
     {
         self.rotateColorProblemView.backgroundColor = [UIColor blackColor];
         self.rotateColorProblemView.backgroundColor = [UIColor blueColor];
         self.rotateColorProblemView.backgroundColor = [UIColor greenColor];
         self.rotateColorProblemView.backgroundColor = [UIColor redColor];
         self.rotateColorProblemView.backgroundColor = [UIColor blackColor];
     }];
}

//  Here's a better way to rotate colors: Go through the desired colors one by one in separate animation blocks.  

- (IBAction)rotateColors:(id)sender 
{
    self.rotateColorWorkingView.backgroundColor = [UIColor blackColor];
    
    [UIView animateWithDuration:1.0 animations:^
     {
         self.rotateColorWorkingView.backgroundColor = [UIColor blueColor];
     }
     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:1.0 animations:^
          {
              self.rotateColorWorkingView.backgroundColor = [UIColor greenColor];
          }
          completion:^(BOOL finished)
          {
              [UIView animateWithDuration:1.0 animations:^
               {
                   self.rotateColorWorkingView.backgroundColor = [UIColor redColor];
               }
               completion:^(BOOL finished)
               {
                   [UIView animateWithDuration:1.0 animations:^
                    {
                        self.rotateColorWorkingView.backgroundColor = [UIColor blackColor];
                    }];
               }];          
          }];
     }];

}

#pragma mark - Flip Animations

// We have animation in this one, but way too much.  The problem is that the transition occurs in the context of the superview of the view being transitioned away from.  Since the superview of the view being transitioned away from is UIViewController's main view, the whole screen flips.  

- (IBAction)flipTooMuchPressed:(id)sender  
{
UIView *copiedView = [[UIView alloc] initWithFrame:self.flipTooMuchView.frame];
copiedView.backgroundColor = self.flipTooMuchView.backgroundColor;

[UIView transitionFromView:self.flipTooMuchView
                    toView:copiedView
                  duration:1.0 
                   options:UIViewAnimationOptionTransitionFlipFromLeft 
                completion:^(BOOL finished)
 {
     self.flipTooMuchView = copiedView;
 }];
}


// This method doesn't work.  Everything is correct, but there's one problem: there are a couple of Apple constants that have very similar names.  The correct option here is UIViewAnimationOptionTransitionFlipFromLeft.  We've used UIViewAnimationTransitionFlipFromLeft - note the lack of 'Option' in the middle - and that makes the animation fail.  

- (IBAction)flipTooLittlePressed:(id)sender 
{
    UIView *copiedView = [[UIView alloc] initWithFrame:self.flipTooLittleView.frame];
    copiedView.backgroundColor = self.flipTooLittleView.backgroundColor;
    
    [UIView transitionFromView:self.flipTooLittleView
                        toView:copiedView
                      duration:1.0 
                       options:UIViewAnimationTransitionFlipFromLeft 
                    completion:^(BOOL finished)
     {
         self.flipTooLittleView = copiedView;
     }];
}

// This method works correctly.  We create a new view, and flip to it!  Woo hoo, it works!

- (IBAction)flipCorrectlyPressed:(id)sender 
{
    UIView *copiedView = [[UIView alloc] initWithFrame:self.flipCorrectlyView.frame];
    copiedView.backgroundColor = self.flipCorrectlyView.backgroundColor;
    
    [UIView transitionFromView:self.flipCorrectlyView
                        toView:copiedView
                      duration:1.0 
                       options:UIViewAnimationOptionTransitionFlipFromLeft 
                    completion:^(BOOL finished)
     {
         self.flipCorrectlyView = copiedView;
     }];
}

#pragma mark - Spinning Animations

-(void)spinStar:(UIImageView *)whichStar
  noOfRotations:(float)noOfRotations
{
    whichStar.transform = CGAffineTransformRotate(whichStar.transform, noOfRotations * 2 * M_PI);
}

// added by Jorge M
//
// I did find this problem when i was trying to make a rotation wheel with prizes!
// the problem is that after you perform a layer transformation and run an animation
// to the same object after, it takes back the transformation to the original state
// and then it performs the animation 
//(at least in the case of rotation transformations) you're able to see a jump
// at the end at the animation or at the begining 
//

- (CABasicAnimation *)rotateWheelOne {
    float rotDeg = (2*M_PI)/180;
    CABasicAnimation *fullRotation;
    fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    fullRotation.toValue = [NSNumber numberWithFloat:rotDeg];
    fullRotation.fromValue = [NSNumber numberWithFloat:( M_PI * 4.0)];
    fullRotation.duration = 3.0f;
    fullRotation.repeatCount = 0;
    fullRotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fullRotation.removedOnCompletion = NO;
    fullRotation.autoreverses=NO;
    return fullRotation;
}

-(void)transformAndSpinStar:(UIImageView *)whichStar
  noOfRotations:(float)noOfRotations
{
    whichStar.transform = CGAffineTransformRotate(whichStar.transform, noOfRotations * 2 * M_PI);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView animateWithDuration:1.5f animations:^{
        [whichStar.layer addAnimation:[self rotateWheelOne] forKey:nil];
    }];
    [UIView commitAnimations];
    
}

//Another, rotation problem (Transform + Rotation)!

- (IBAction)transformRotatePressed:(id)sender 
{
    //static int animationCounter = 0;
    
    [UIView animateWithDuration:1.0
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^
     {
         [self transformAndSpinStar:transformAndRotateStar noOfRotations:.25];
     }
                     completion:^(BOOL finished)
     {
         
     }];
}


// This animation doesn't work.  The problem is that UIView tries to optimize the animation as much as possible, so it compares the end state with the beginning state.  A full rotation will mean that the end state and beginning state are the same, so UIView optimizes this animation by simply not moving the star at all.  

- (IBAction)doNotRotatePressed:(id)sender 
{
    [UIView animateWithDuration:1.0
                     animations:^
     {
         [self spinStar:immobileStar noOfRotations:1];
     }];
}

// This animation kind of works, but not the way we might want.  In this case, we're doing series of rations that take the star exactly 180° - 1/2 way around the circle.  UIView looks at the beginning state and end state, and optimizes how to get from the beginning state to the end state.  Oddly enough, in doing the initial rotate, it goes counter-clockwise.  However, if you rotate it again, it will go clockwise the next time.

//  Hypothesis: the "wrong way" rotation is caused by the fact that the math for one rotation ends up with a positive rotation, while the math for the other ends up with a negative rotation.  You're encouraged to play with this, investigate the math, and see if you can find a way to make the 1/2 rotations spins work correctly.  

- (IBAction)wrongWayRotatePressed:(id)sender 
{
    [UIView animateWithDuration:1.0
                    animations:^
    {
         [self spinStar:wrongWayStar noOfRotations:0.5];
    }];
}

// In this method, we're doing a series of 1/4 rotations.  This works, but the animation is jerky.  The reason that it's jerky is that the default for animations is "ease in / ease out", meaning that the animations will go slowly at the beginning and end of the animation, then more quickly in the middle.  In an animation that is really a series of animations chained together, this causes jerky updating.  

- (IBAction)jerkyRotatePressed:(id)sender 
{
    static int animationCounter = 0;

    [UIView animateWithDuration:1.0
                     animations:^
     {
         [self spinStar:jerkyStar noOfRotations:0.25];
     }
                     completion:^(BOOL finished)
     {
         animationCounter ++;
         
         animationCounter == 8 ? animationCounter = 0 : [self jerkyRotatePressed:nil];
     }];
}

//Finally, a working rotate!

- (IBAction)correctRotatePressed:(id)sender 
{
    static int animationCounter = 0;
    
    [UIView animateWithDuration:1.0
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^
     {
         [self spinStar:correctStar noOfRotations:.25];
     }
                     completion:^(BOOL finished)
     {
         animationCounter ++;
         
         animationCounter == 8 ? animationCounter = 0 : [self correctRotatePressed:nil];
     }];
}




@end
