//
//  KLTransitionContextDecorator.m
//  KLViewControllerTransitions
//
//  Created by Kevin Lundberg on 10/16/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "KLTransitionContextDecorator.h"

@interface KLTransitionContextDecorator ()

@property (nonatomic, strong) id<UIViewControllerContextTransitioning>transitionContext;
@property (nonatomic, assign) KLTransitionDirection direction;

@end

@implementation KLTransitionContextDecorator

@dynamic fromViewController;
@dynamic toViewController;
@dynamic originalViewController;
@dynamic presentedViewController;


+ (instancetype)decoratorWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext direction:(KLTransitionDirection)direction
{
    return [[self alloc] initWithTransitionContext:transitionContext direction:direction];
}

- (instancetype)initWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext direction:(KLTransitionDirection)direction
{
    if (transitionContext == nil) {
        return nil;
    }
    _transitionContext = transitionContext;
    _direction = direction;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.transitionContext];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [(id)self.transitionContext methodSignatureForSelector:sel];
}

- (UIViewController *)fromViewController
{
    return [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
}

- (UIViewController *)toViewController
{
    return [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
}

- (UIViewController *)originalViewController
{
    if (self.direction == KLTransitionDirectionForwards) {
        return self.fromViewController;
    } else {
        return self.toViewController;
    }
}

- (UIViewController *)presentedViewController
{
    if (self.direction == KLTransitionDirectionForwards) {
        return self.toViewController;
    } else {
        return self.fromViewController;
    }
}

@end
