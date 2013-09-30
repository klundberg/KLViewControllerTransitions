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

@interface KLBlurredBackgroundCoverTransition : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithMode:(KLTransitionMode)direction;

@property (nonatomic, assign, readonly) KLTransitionMode mode;

@end
