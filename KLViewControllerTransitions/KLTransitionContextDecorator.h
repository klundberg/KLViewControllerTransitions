//
//  KLTransitionContextDecorator.h
//  KLViewControllerTransitions
//
//  Created by Kevin Lundberg on 10/16/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KLTransitionEnums.h"

@protocol KLViewControllerContextTransitioning <UIViewControllerContextTransitioning>

@property (nonatomic, strong, readonly) UIViewController *fromViewController;
@property (nonatomic, strong, readonly) UIViewController *toViewController;
@property (nonatomic, strong, readonly) UIViewController *originalViewController;
@property (nonatomic, strong, readonly) UIViewController *presentedViewController;

@end


@interface KLTransitionContextDecorator : NSProxy <KLViewControllerContextTransitioning>

- (instancetype)initWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext direction:(KLTransitionDirection)direction;

@end
