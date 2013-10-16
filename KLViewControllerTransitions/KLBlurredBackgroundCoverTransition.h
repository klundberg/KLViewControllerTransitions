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
    KLTransitionModeReverse,
};

typedef NS_ENUM(NSInteger, KLTransitionBlurStyle) {
    KLTransitionBlurStyleLight,
    KLTransitionBlurStyleExtraLight,
    KLTransitionBlurStyleDark,
    KLTransitionBlurStyleCustomTint,
};

typedef NS_ENUM(NSInteger, KLTransitionType) {
    KLTransitionTypeCoverVertical,
    KLTransitionTypeCrossFade,
    KLTransitionTypePageCurl,
};

@interface KLBlurredBackgroundCoverTransition : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithMode:(KLTransitionMode)direction;

@property (nonatomic, assign, readonly) KLTransitionMode mode;
@property (nonatomic, assign) KLTransitionBlurStyle blurStyle;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, assign) NSTimeInterval transitionDuration;
@property (nonatomic, assign, getter = isAnimated) BOOL animated;

@end
