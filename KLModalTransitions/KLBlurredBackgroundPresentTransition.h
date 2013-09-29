//
//  KLModalTransitions.h
//  KLModalTransitions
//
//  Created by Kevin Lundberg on 9/26/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KLTransitionDirection) {
    KLTransitionDirectionForwards,
    KLTransitionDirectionReverse
};

@interface KLBlurredBackgroundPresentTransition : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithDirection:(KLTransitionDirection)direction;

@property (nonatomic, assign, readonly) KLTransitionDirection direction;

@end
