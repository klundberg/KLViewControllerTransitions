//
//  KLSpinFromCenterTransition.m
//  KLViewControllerTransitions
//
//  Created by Kevin Lundberg on 11/7/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "KLSpinFromCenterTransition.h"
#import "KLTransitionContextDecorator.h"

#define DEGREES_TO_RADIANS(deg) (deg / 180.0 * M_PI)

@implementation KLSpinFromCenterTransition

- (id)init
{
    self = [super init];
    if (self) {
        _rotations = 1;
    }
    return self;
}

- (void)setRotations:(NSUInteger)rotations
{
    if (rotations == 0) {
        _rotations = 1;
    } else {
        _rotations = rotations;
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    KLTransitionContextDecorator *context = [KLTransitionContextDecorator decoratorWithTransitionContext:transitionContext direction:self.direction];

    context.toViewController.view.frame = context.containerView.bounds;
    context.toViewController.view.transform = CGAffineTransformMakeScale(0, 0);

    [context.containerView addSubview:context.toViewController.view];

    [self startAnimation:context.toViewController.view withStep:0 withContext:context];

}

- (void)startAnimation:(UIView *)view withStep:(NSInteger)step withContext:(KLTransitionContextDecorator *)context
{
    double steps = 4 * self.rotations;

    [UIView animateWithDuration:[self transitionDuration:context] / steps
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         view.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(step/steps, step/steps), DEGREES_TO_RADIANS(90 * step));
                     }
                     completion:^(BOOL finished) {
                         if (step < steps){
                             // perform the next rotation animation
                             [self startAnimation:view withStep:step + 1 withContext:context];
                         } else {
                             [context completeTransition:finished];
                         }
                     }];
}

@end
