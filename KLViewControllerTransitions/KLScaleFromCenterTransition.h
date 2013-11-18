//
//  KLScaleFromCenterTransition.h
//  KLViewControllerTransitions
//
//  Created by Kevin Lundberg on 11/17/13.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KLTransitionEnums.h"

@interface KLScaleFromCenterTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) KLTransitionDirection direction;

@end
