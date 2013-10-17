//
//  KLModalTransitions.h
//  KLModalTransitions
//
//  Created by Kevin Lundberg on 9/26/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KLTransitionEnums.h"


@interface KLBlurredBackgroundCoverTransition : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithDirection:(KLTransitionDirection)direction;

@property (nonatomic, assign, readonly) KLTransitionDirection direction;
@property (nonatomic, assign) KLTransitionBlurStyle blurStyle;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, assign, getter = isAnimated) BOOL animated;

@end
