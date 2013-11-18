//
//  KLScaleFromCenterTransition.m
//  KLViewControllerTransitions
//
//  Created by Kevin Lundberg on 11/17/13.
//
//

#import "KLScaleFromCenterTransition.h"
#import "KLTransitionContextDecorator.h"

@implementation KLScaleFromCenterTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    KLTransitionContextDecorator *context = [[KLTransitionContextDecorator alloc] initWithTransitionContext:transitionContext direction:self.direction];

    CGAffineTransform transform = CGAffineTransformMakeScale(0, 0);

    if (self.direction == KLTransitionDirectionForwards) {
        context.presentedViewController.view.frame = context.containerView.bounds;
        context.presentedViewController.view.transform = transform;
        [context.containerView addSubview:context.presentedViewController.view];

        [UIView animateWithDuration:[self transitionDuration:context]
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             context.presentedViewController.view.transform = CGAffineTransformIdentity;
                         } completion:^(BOOL finished) {
                             [context completeTransition:finished];
                         }];
    } else {
        [UIView animateWithDuration:[self transitionDuration:context]
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             context.presentedViewController.view.transform = transform;
                         } completion:^(BOOL finished) {
                             [context.presentedViewController.view removeFromSuperview];
                             [context completeTransition:finished];
                         }];
    }
}

@end
