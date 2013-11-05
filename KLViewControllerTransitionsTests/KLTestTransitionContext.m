//
//  KLTestTransitionContext.m
//  KLViewControllerTransitions
//
//  Created by Kevin Lundberg on 11/5/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "KLTestTransitionContext.h"

@implementation KLTestTransitionContext

- (UIModalPresentationStyle)presentationStyle
{
    return UIModalPresentationCustom;
}

- (BOOL)isAnimated
{
    return YES;
}

- (BOOL)transitionWasCancelled
{
    return NO;
}

- (CGRect)initialFrameForViewController:(UIViewController *)vc
{
    return CGRectZero;
}

- (CGRect)finalFrameForViewController:(UIViewController *)vc
{
    return CGRectZero;
}

- (void)cancelInteractiveTransition
{

}

- (BOOL)isInteractive
{
    return NO;
}

- (UIViewController *)viewControllerForKey:(NSString *)key
{
    return nil;
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete
{

}

@end
