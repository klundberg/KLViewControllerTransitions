//
//  KLModalTransitions.h
//  KLModalTransitions
//
//  Created by Kevin Lundberg on 9/26/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KLTransitionMode) {
    KLTransitionModeForwards,
    KLTransitionModeReverse
};

typedef NS_ENUM(NSInteger, KLTransitionBlurStyle) {
    KLTransitionBlurStyleLight,
    KLTransitionBlurStyleExtraLight,
    KLTransitionBlurStyleDark,
    KLTransitionBlurStyleCustomTint
};

@interface KLBlurredBackgroundCoverTransition : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithMode:(KLTransitionMode)direction;

@property (nonatomic, assign, readonly) KLTransitionMode mode;
@property (nonatomic, assign) KLTransitionBlurStyle blurStyle;
@property (nonatomic, strong) UIColor *tintColor;

@end
