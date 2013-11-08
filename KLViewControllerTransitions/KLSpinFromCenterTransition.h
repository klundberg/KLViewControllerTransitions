//
//  KLSpinFromCenterTransition.h
//  KLViewControllerTransitions
//
//  Created by Kevin Lundberg on 11/7/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KLTransitionEnums.h"

@interface KLSpinFromCenterTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) KLTransitionDirection direction;
@property (nonatomic, assign) NSUInteger rotations;

@end
