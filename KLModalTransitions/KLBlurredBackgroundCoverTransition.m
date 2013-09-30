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
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *modalController = [self modalController:transitionContext];
    UIView *container = [transitionContext containerView];

    UIView *blurredImageView = [self blurredView:transitionContext];

    blurredImageView.frame = [self initialBlurredViewRect:transitionContext];
    modalController.view.frame = [self initialModalControllerRect:transitionContext];

    if (self.mode == KLTransitionModeForwards) {
        [container addSubview:blurredImageView];
        [container addSubview:modalController.view];
    }

    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
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

#pragma mark - blurred view states

- (UIView *)blurredView:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.mode == KLTransitionModeForwards) {
        UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

        UIImageView *blurredImageView = [fromController.view lightBlurredView];
        blurredImageView.tag = BlurredViewTag;
        blurredImageView.contentMode = UIViewContentModeBottom;
        blurredImageView.clipsToBounds = YES;

        return blurredImageView;
    } else {
        return [[transitionContext containerView] viewWithTag:BlurredViewTag];
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
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

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
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    return CGRectMake(0, 0, toController.view.frame.size.width, toController.view.frame.size.height);
}

- (CGRect)uncoveredModalControllerRect:(id<UIViewControllerContextTransitioning>)transitionContext
{
    CGRect frame = [self coveredModalControllerRect:transitionContext];
    frame.origin.y = frame.size.height;

    return frame;
}


@end
