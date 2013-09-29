//
//  KLModalTransitions.m
//  KLModalTransitions
//
//  Created by Kevin Lundberg on 9/26/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "KLBlurredBackgroundPresentTransition.h"
#import "UIView+UIImageEffects.h"

static NSInteger const BlurredViewTag = 19;

@implementation KLBlurredBackgroundPresentTransition

- (instancetype)init
{
    return [self initWithDirection:KLTransitionDirectionForwards];
}

- (instancetype)initWithDirection:(KLTransitionDirection)direction
{
    self = [super init];
    if (self) {
        _direction = direction;
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
    modalController.view.frame = [self initialDestinationControllerRect:transitionContext];

    if (self.direction == KLTransitionDirectionForwards) {
        [container addSubview:blurredImageView];
        [container addSubview:modalController.view];
    }

    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         blurredImageView.frame = [self finalBlurredViewRect:transitionContext];
                         modalController.view.frame = [self finalDestinationControllerRect:transitionContext];
                     } completion:^(BOOL finished) {
                         if (self.direction == KLTransitionDirectionReverse) {
                             [blurredImageView removeFromSuperview];
                             [modalController.view removeFromSuperview];
                         }

                         [transitionContext completeTransition:finished];
                     }];
}

- (UIViewController *)modalController:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.direction == KLTransitionDirectionForwards) {
        return [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    } else {
        return [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    }
}

#pragma mark - blurred view states

- (UIView *)blurredView:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.direction == KLTransitionDirectionForwards) {
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
    if (self.direction == KLTransitionDirectionForwards) {
        return [self uncoveredBlurredViewRect:transitionContext];
    } else {
        return [self coveredBlurredViewRect:transitionContext];
    }
}

- (CGRect)finalBlurredViewRect:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.direction == KLTransitionDirectionForwards) {
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

#pragma mark - destination view states

- (CGRect)initialDestinationControllerRect:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.direction == KLTransitionDirectionForwards) {
        return [self uncoveredDestinationControllerRect:transitionContext];
    } else {
        return [self coveredDestinationControllerRect:transitionContext];
    }
}

- (CGRect)finalDestinationControllerRect:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.direction == KLTransitionDirectionForwards) {
        return [self coveredDestinationControllerRect:transitionContext];
    } else {
        return [self uncoveredDestinationControllerRect:transitionContext];
    }
}

- (CGRect)coveredDestinationControllerRect:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    return CGRectMake(0, 0, toController.view.frame.size.width, toController.view.frame.size.height);
}

- (CGRect)uncoveredDestinationControllerRect:(id<UIViewControllerContextTransitioning>)transitionContext
{
    CGRect frame = [self coveredDestinationControllerRect:transitionContext];
    frame.origin.y = frame.size.height;

    return frame;
}


@end
