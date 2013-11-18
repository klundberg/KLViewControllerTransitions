//
//  KLModalTransitions.m
//  KLModalTransitions
//
//  Created by Kevin Lundberg on 9/26/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "KLBlurredBackgroundCoverTransition.h"
#import "UIView+UIImageEffects.h"
#import "KLTransitionContextDecorator.h"

static NSInteger const BlurredViewTag = 19;

@implementation KLBlurredBackgroundCoverTransition

- (instancetype)init
{
    return [self initWithDirection:KLTransitionDirectionForwards];
}

- (instancetype)initWithDirection:(KLTransitionDirection)direction
{
    self = [super init];
    if (self) {
        _direction = direction;
        _blurStyle = KLTransitionBlurStyleLight;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    id<KLViewControllerContextTransitioning> decoratedContext = [[KLTransitionContextDecorator alloc] initWithTransitionContext:transitionContext
                                                                                                                      direction:self.direction];
    [self setupAnimation:decoratedContext];

    if (self.animated) {
        [UIView animateWithDuration:[self transitionDuration:decoratedContext]
                              delay:0
                            options:[self animationOptions]
                         animations:^{
                             [self performAnimation:decoratedContext];
                         } completion:^(BOOL finished) {
                             [self finalizeAnimation:decoratedContext];
                             [decoratedContext completeTransition:finished];
                         }];
    } else {
        [self performAnimation:decoratedContext];
        [self finalizeAnimation:decoratedContext];
        [decoratedContext completeTransition:YES];
    }
}

#pragma mark - helpers

- (void)setupAnimation:(id<KLViewControllerContextTransitioning>)transitionContext
{
    if (self.direction == KLTransitionDirectionForwards) {
        [self setupForwardAnimation:transitionContext];
    } else {
        [self setupReverseAnimation:transitionContext];
    }
}

- (void)setupForwardAnimation:(id<KLViewControllerContextTransitioning>)transitionContext
{
    UIView *container = [transitionContext containerView];

    UIView *blurredImageView = [self createBlurredViewForContext:transitionContext];
    [container addSubview:blurredImageView];

    UIViewController *modalController = [transitionContext presentedViewController];
    modalController.view.frame = [self initialPresentedControllerFrame:transitionContext];
    [container addSubview:modalController.view];

    if ([modalController isKindOfClass:[UINavigationController class]]) {
        [self adjustNavigationBarForPresentedNavigationController:(id)modalController];
    }
}

- (void)adjustNavigationBarForPresentedNavigationController:(UINavigationController *)navController
{
    // due to a bug in apple's code, the navigation bar of a navigation controller is 44 points tall when animating, and jumps to
    // be tall enough to encompass the status bar only when the animation finishes. We need to manually set the frame of the navbar here to
    // make it look correct while animating in.
    CGRect frame = navController.navigationBar.frame;
    frame.size.height += [[UIApplication sharedApplication] statusBarFrame].size.height;
    navController.navigationBar.frame = frame;
}

- (void)setupReverseAnimation:(id<KLViewControllerContextTransitioning>)transitionContext
{
    UIViewController *sourceController = [transitionContext originalViewController];
    UIView *container = [transitionContext containerView];

    [container addSubview:sourceController.view];
    [container sendSubviewToBack:sourceController.view];
}

- (UIViewAnimationOptions)animationOptions
{
    return UIViewAnimationOptionCurveEaseOut;
}

- (void)performAnimation:(id<KLViewControllerContextTransitioning>)transitionContext
{
    UIView *blurredImageView = [self blurredViewForContext:transitionContext];
    UIViewController *modalController = [transitionContext presentedViewController];

    blurredImageView.frame = [self finalBlurredViewFrame:transitionContext];
    modalController.view.frame = [self finalPresentedControllerFrame:transitionContext];
}

- (void)finalizeAnimation:(id<KLViewControllerContextTransitioning>)transitionContext
{
    if (self.direction == KLTransitionDirectionForwards) {
        [self finalizeForwardTransition:transitionContext];
    } else {
        [self finalizeReverseTransition:transitionContext];
    }
}

- (void)finalizeForwardTransition:(id<KLViewControllerContextTransitioning>)transitionContext
{
    UIViewController *sourceController = [transitionContext originalViewController];
    [sourceController.view removeFromSuperview];
}

- (void)finalizeReverseTransition:(id<KLViewControllerContextTransitioning>)transitionContext
{
    UIView *blurredImageView = [self blurredViewForContext:transitionContext];
    UIViewController *modalController = [transitionContext presentedViewController];

    [blurredImageView removeFromSuperview];
    [modalController.view removeFromSuperview];
}

#pragma mark - blurred view states

- (UIView *)createBlurredViewForContext:(id<KLViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromController = [transitionContext fromViewController];

    UIImageView *blurredImageView = [self blurredView:fromController.view forStyle:self.blurStyle];
    blurredImageView.tag = BlurredViewTag;
    blurredImageView.contentMode = UIViewContentModeBottom;
    blurredImageView.clipsToBounds = YES;
    blurredImageView.frame = [self initialBlurredViewFrame:transitionContext];

    return blurredImageView;
}

- (UIView *)blurredViewForContext:(id<KLViewControllerContextTransitioning>)transitionContext
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

- (CGRect)initialBlurredViewFrame:(id<KLViewControllerContextTransitioning>)transitionContext
{
    if (self.direction == KLTransitionDirectionForwards) {
        return [self uncoveredBlurredViewFrame:transitionContext];
    } else {
        return [self coveredBlurredViewFrame:transitionContext];
    }
}

- (CGRect)finalBlurredViewFrame:(id<KLViewControllerContextTransitioning>)transitionContext
{
    if (self.direction == KLTransitionDirectionForwards) {
        return [self coveredBlurredViewFrame:transitionContext];
    } else {
        return [self uncoveredBlurredViewFrame:transitionContext];
    }
}

- (CGRect)coveredBlurredViewFrame:(id<KLViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromController = [transitionContext originalViewController];
    return fromController.view.frame;
}

- (CGRect)uncoveredBlurredViewFrame:(id<KLViewControllerContextTransitioning>)transitionContext
{
    CGRect frame = [self coveredBlurredViewFrame:transitionContext];
    frame.origin.y = frame.size.height;
    frame.size.height = 0;
    return frame;
}

#pragma mark - modal view states

- (CGRect)initialPresentedControllerFrame:(id<KLViewControllerContextTransitioning>)transitionContext
{
    if (self.direction == KLTransitionDirectionForwards) {
        return [self uncoveredPresentedControllerFrame:transitionContext];
    } else {
        return [self coveredPresentedControllerFrame:transitionContext];
    }
}

- (CGRect)finalPresentedControllerFrame:(id<KLViewControllerContextTransitioning>)transitionContext
{
    if (self.direction == KLTransitionDirectionForwards) {
        return [self coveredPresentedControllerFrame:transitionContext];
    } else {
        return [self uncoveredPresentedControllerFrame:transitionContext];
    }
}

- (CGRect)coveredPresentedControllerFrame:(id<KLViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toController = [transitionContext presentedViewController];

    return CGRectMake(0, 0, toController.view.frame.size.width, toController.view.frame.size.height);
}

- (CGRect)uncoveredPresentedControllerFrame:(id<KLViewControllerContextTransitioning>)transitionContext
{
    CGRect frame = [self coveredPresentedControllerFrame:transitionContext];
    frame.origin.y = frame.size.height;

    return frame;
}

@end
