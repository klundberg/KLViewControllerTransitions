//
//  KLDetailViewController.m
//  KLModalTransitionsDemo
//
//  Created by Kevin Lundberg on 9/26/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "KLBlurDetailController.h"
#import "KLTransitionEnums.h"
#import "KLBlurredBackgroundCoverTransition.h"
#import "KLSpinFromCenterTransition.h"
#import "KLScaleFromCenterTransition.h"

@interface KLBlurDetailController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end

@implementation KLBlurDetailController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.navigationController.delegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return [self animationControllerForPresentedController:toVC presentingController:fromVC sourceController:fromVC];
    } else if (operation == UINavigationControllerOperationPop) {
        self.navigationController.delegate = nil;
        return [self animationControllerForDismissedController:fromVC];
    }
    return nil;
}

- (IBAction)presentController:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"How to show"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Present", @"Push", nil];
    [sheet showFromBarButtonItem:sender animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *segue = (buttonIndex == 0 ? @"modalSegue" : @"pushSegue");

    if (self.transitionType != KLTransitionTypeCoverVertical) {
        [self performSegueWithIdentifier:[segue stringByAppendingString:@"Opaque"] sender:nil];
    } else {
        [self performSegueWithIdentifier:segue sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *target = segue.destinationViewController;
    target.transitioningDelegate = self;
    target.modalPresentationStyle = UIModalPresentationCustom;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    if (self.transitionType == KLTransitionTypeCoverVertical) {
        KLBlurredBackgroundCoverTransition *transition = [[KLBlurredBackgroundCoverTransition alloc] init];
        transition.blurStyle = self.styleControl.selectedSegmentIndex;
        transition.tintColor = self.view.tintColor;
        transition.animated = self.animatedSwitch.on;
        transition.direction = KLTransitionDirectionForwards;
        return transition;
    } else if (self.transitionType == KLTransitionTypeSpinFromCenter) {
        KLSpinFromCenterTransition *transition = [[KLSpinFromCenterTransition alloc] init];
        transition.direction = KLTransitionDirectionForwards;
        return transition;
    } else if (self.transitionType == KLTransitionTypeScaleFromCenter) {
        KLScaleFromCenterTransition *transition = [[KLScaleFromCenterTransition alloc] init];
        transition.direction = KLTransitionDirectionForwards;
        return transition;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactiveTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    if (self.transitionType == KLTransitionTypeCoverVertical) {
        KLBlurredBackgroundCoverTransition *transition = [[KLBlurredBackgroundCoverTransition alloc] init];
        transition.blurStyle = self.styleControl.selectedSegmentIndex;
        transition.tintColor = self.view.tintColor;
        transition.animated = self.animatedSwitch.on;
        transition.direction = KLTransitionDirectionReverse;
        return transition;
    } else if (self.transitionType == KLTransitionTypeSpinFromCenter) {
        KLSpinFromCenterTransition *transition = [[KLSpinFromCenterTransition alloc] init];
        transition.direction = KLTransitionDirectionReverse;
        return transition;
    } else if (self.transitionType == KLTransitionTypeScaleFromCenter) {
        KLScaleFromCenterTransition *transition = [[KLScaleFromCenterTransition alloc] init];
        transition.direction = KLTransitionDirectionReverse;
        return transition;
    }
    return nil;
}

@end
