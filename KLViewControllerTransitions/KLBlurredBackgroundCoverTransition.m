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
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *modalController = [self modalController:transitionContext];
    UIView *container = [transitionContext containerView];

    UIView *blurredImageView = [self blurredViewForContext:transitionContext];

    blurredImageView.frame = [self initialBlurredViewRect:transitionContext];
    modalController.view.frame = [self initialModalControllerRect:transitionContext];

    if (self.mode == KLTransitionModeForwards) {
        [container addSubview:blurredImageView];
        [container addSubview:modalController.view];
    } else {

    }

    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:[self animationOptions]
                     animations:^{
                         blurredImageView.frame = [self finalBlurredViewRect:transitionContext];
                         modalController.view.frame = [self finalModalControllerRect:transitionContext];
                     } completion:^(BOOL finished) {
                         if (self.mode == KLTransitionModeReverse) {
                             [blurredImageView removeFromSuperview];
                             [modalController.view removeFromSuperview];
                         }

                         [transitionContext completeTransition:finished];
                     }];
}

- (UIViewAnimationOptions)animationOptions
{
    if (self.mode == KLTransitionModeForwards) {
        return UIViewAnimationOptionCurveEaseOut;
    } else {
        return UIViewAnimationOptionCurveEaseIn;
    }
}

#pragma mark - blurred view states

- (UIView *)blurredViewForContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.mode == KLTransitionModeForwards) {
        UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

        UIImageView *blurredImageView = [self blurredView:fromController.view forStyle:self.blurStyle];
        blurredImageView.tag = BlurredViewTag;
        blurredImageView.contentMode = UIViewContentModeBottom;
        blurredImageView.clipsToBounds = YES;

        return blurredImageView;
    } else {
        return [[transitionContext containerView] viewWithTag:BlurredViewTag];
    }
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

- (CGRect)initialBlurredViewRect:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.mode == KLTransitionModeForwards) {
        return [self uncoveredBlurredViewRect:transitionContext];
    } else {
        return [self coveredBlurredViewRect:transitionContext];
    }
}

- (CGRect)finalBlurredViewRect:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.mode == KLTransitionModeForwards) {
        return [self coveredBlurredViewRect:transitionContext];
    } else {
        return [self uncoveredBlurredViewRect:transitionContext];
    }
}

- (CGRect)coveredBlurredViewRect:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromController = [self sourceController:transitionContext];

    return fromController.view.frame;
}

- (CGRect)uncoveredBlurredViewRect:(id<UIViewControllerContextTransitioning>)transitionContext
{
    CGRect frame = [self coveredBlurredViewRect:transitionContext];
    frame.origin.y = frame.size.height;
    frame.size.height = 0;
    return frame;
}

#pragma mark - modal view states

- (UIViewController *)modalController:(id<UIViewControllerContextTransitioning>)transitionContext
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

- (CGRect)initialModalControllerRect:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.mode == KLTransitionModeForwards) {
        return [self uncoveredModalControllerRect:transitionContext];
    } else {
        return [self coveredModalControllerRect:transitionContext];
    }
}

- (CGRect)finalModalControllerRect:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.mode == KLTransitionModeForwards) {
        return [self coveredModalControllerRect:transitionContext];
    } else {
        return [self uncoveredModalControllerRect:transitionContext];
    }
}

- (CGRect)coveredModalControllerRect:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toController = [self modalController:transitionContext];

    return CGRectMake(0, 0, toController.view.frame.size.width, toController.view.frame.size.height);
}

- (CGRect)uncoveredModalControllerRect:(id<UIViewControllerContextTransitioning>)transitionContext
{
    CGRect frame = [self coveredModalControllerRect:transitionContext];
    frame.origin.y = frame.size.height;

    return frame;
}


@end
