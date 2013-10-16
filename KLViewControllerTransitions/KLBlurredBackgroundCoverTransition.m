//
//  KLModalTransitions.m
//  KLModalTransitions
//
//  Created by Kevin Lundberg on 9/26/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "KLBlurredBackgroundCoverTransition.h"
#import "UIView+UIImageEffects.h"

static NSInteger const BlurredViewTag = 19;

@implementation KLBlurredBackgroundCoverTransition

- (instancetype)init
{
    return [self initWithMode:KLTransitionModeForwards];
}

- (instancetype)initWithMode:(KLTransitionMode)mode
{
    self = [super init];
    if (self) {
        _mode = mode;
        _blurStyle = KLTransitionBlurStyleLight;
        _transitionDuration = 0.4;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.mode == KLTransitionModeForwards) {
        [self setupForwardAnimation:transitionContext];
    } else {
        [self setupReverseAnimation:transitionContext];
    }

    if (self.animated) {
        [UIView animateWithDuration:self.transitionDuration
                              delay:0
                            options:[self animationOptions]
                         animations:^{
                             [self performAnimation:transitionContext];
                         } completion:^(BOOL finished) {
                             if (self.mode == KLTransitionModeForwards) {
                                 [self finalizeForwardTransition:transitionContext];
                             } else {
                                 [self finalizeReverseTransition:transitionContext];
                             }
                             [transitionContext completeTransition:finished];
                         }];
    } else {
        [self performAnimation:transitionContext];
        if (self.mode == KLTransitionModeForwards) {
            [self finalizeForwardTransition:transitionContext];
        } else {
            [self finalizeReverseTransition:transitionContext];
        }
        [transitionContext completeTransition:YES];
    }
}

- (void)setupForwardAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *container = [transitionContext containerView];
    UIView *blurredImageView = [self createBlurredViewForContext:transitionContext];
    [container addSubview:blurredImageView];

    UIViewController *modalController = [self presentedController:transitionContext];
    modalController.view.frame = [self initialPresentedControllerFrame:transitionContext];
    [container addSubview:modalController.view];

    if ([modalController isKindOfClass:[UINavigationController class]]) {
        [self adjustNavigationBarForPresentedNavigationController:(id)modalController];
    }
}

- (void)adjustNavigationBarForPresentedNavigationController:(UINavigationController *)navController
{
    // due to a bug in apple's code, the navigation bar of a navigation controller is 44 points tall when animating, and jumps to
    // be tall enough to encompas the status bar only once the animation finishes. We need to manually set the frame of the navbar here to
    // make it look correct.
    CGRect frame = navController.navigationBar.frame;
    frame.size.height += [[UIApplication sharedApplication] statusBarFrame].size.height;
    navController.navigationBar.frame = frame;
}

- (void)setupReverseAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *sourceController = [self sourceController:transitionContext];
    UIView *container = [transitionContext containerView];

    [container addSubview:sourceController.view];
    [container sendSubviewToBack:sourceController.view];
}

- (UIViewAnimationOptions)animationOptions
{
    return UIViewAnimationOptionCurveEaseOut;
}

- (void)performAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *blurredImageView = [self blurredViewForContext:transitionContext];
    UIViewController *modalController = [self presentedController:transitionContext];

    blurredImageView.frame = [self finalBlurredViewFrame:transitionContext];
    modalController.view.frame = [self finalPresentedControllerFrame:transitionContext];
}

- (void)finalizeForwardTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *sourceController = [self sourceController:transitionContext];
    [sourceController.view removeFromSuperview];
}

- (void)finalizeReverseTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *blurredImageView = [self blurredViewForContext:transitionContext];
    UIViewController *modalController = [self presentedController:transitionContext];

    [blurredImageView removeFromSuperview];
    [modalController.view removeFromSuperview];
}

#pragma mark - View Controller helpers

- (UIViewController *)presentedController:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.mode == KLTransitionModeForwards) {
        return [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    } else {
        return [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    }
}

- (UIViewController *)sourceController:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.mode == KLTransitionModeForwards) {
        return [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    } else {
        return [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    }
}

#pragma mark - blurred view states

- (UIView *)createBlurredViewForContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIImageView *blurredImageView = [self blurredView:fromController.view forStyle:self.blurStyle];
    blurredImageView.tag = BlurredViewTag;
    blurredImageView.contentMode = UIViewContentModeBottom;
    blurredImageView.clipsToBounds = YES;
    blurredImageView.frame = [self initialBlurredViewFrame:transitionContext];

    return blurredImageView;
}

- (UIView *)blurredViewForContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return [[transitionContext containerView] viewWithTag:BlurredViewTag];
}

- (UIImageView *)blurredView:(UIView *)view forStyle:(KLTransitionBlurStyle)style
{
    switch (style) {
        case KLTransitionBlurStyleExtraLight:
            return [view extraLightBlurredView];
        case KLTransitionBlurStyleDark:
            return [view darkBlurredView];
        case KLTransitionBlurStyleCustomTint:
            return [view blurredViewWithTintColor:self.tintColor];
        case KLTransitionBlurStyleLight:
        default:
            return [view lightBlurredView];
    }
}

- (CGRect)initialBlurredViewFrame:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.mode == KLTransitionModeForwards) {
        return [self uncoveredBlurredViewFrame:transitionContext];
    } else {
        return [self coveredBlurredViewFrame:transitionContext];
    }
}

- (CGRect)finalBlurredViewFrame:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.mode == KLTransitionModeForwards) {
        return [self coveredBlurredViewFrame:transitionContext];
    } else {
        return [self uncoveredBlurredViewFrame:transitionContext];
    }
}

- (CGRect)coveredBlurredViewFrame:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromController = [self sourceController:transitionContext];
    return fromController.view.frame;
}

- (CGRect)uncoveredBlurredViewFrame:(id<UIViewControllerContextTransitioning>)transitionContext
{
    CGRect frame = [self coveredBlurredViewFrame:transitionContext];
    frame.origin.y = frame.size.height;
    frame.size.height = 0;
    return frame;
}

#pragma mark - modal view states

- (CGRect)initialPresentedControllerFrame:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.mode == KLTransitionModeForwards) {
        return [self uncoveredPresentedControllerFrame:transitionContext];
    } else {
        return [self coveredPresentedControllerFrame:transitionContext];
    }
}

- (CGRect)finalPresentedControllerFrame:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.mode == KLTransitionModeForwards) {
        return [self coveredPresentedControllerFrame:transitionContext];
    } else {
        return [self uncoveredPresentedControllerFrame:transitionContext];
    }
}

- (CGRect)coveredPresentedControllerFrame:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toController = [self presentedController:transitionContext];

    return CGRectMake(0, 0, toController.view.frame.size.width, toController.view.frame.size.height);
}

- (CGRect)uncoveredPresentedControllerFrame:(id<UIViewControllerContextTransitioning>)transitionContext
{
    CGRect frame = [self coveredPresentedControllerFrame:transitionContext];
    frame.origin.y = frame.size.height;

    return frame;
}


@end
