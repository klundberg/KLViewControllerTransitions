//
//  KLDetailViewController.m
//  KLModalTransitionsDemo
//
//  Created by Kevin Lundberg on 9/26/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "KLBlurDetailController.h"
#import "KLBlurredBackgroundCoverTransition.h"

@implementation KLBlurDetailController

- (IBAction)presentController:(id)sender
{
    [self performSegueWithIdentifier:@"modalSegue" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *target = segue.destinationViewController;
    target.transitioningDelegate = self;
    target.modalPresentationStyle = UIModalPresentationCustom;
}

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    KLBlurredBackgroundCoverTransition *transition = [[KLBlurredBackgroundCoverTransition alloc] init];
    transition.blurStyle = self.styleControl.selectedSegmentIndex;
    transition.tintColor = self.view.tintColor;
    transition.animated = self.animatedSwitch.on;
    return transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    KLBlurredBackgroundCoverTransition *transition = [[KLBlurredBackgroundCoverTransition alloc] initWithDirection:KLTransitionDirectionReverse];
    transition.animated = self.animatedSwitch.on;
    return transition;
}

@end
