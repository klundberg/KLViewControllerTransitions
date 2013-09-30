//
//  UIView+UIImageEffects.h
//  KLModalTransitions
//
//  Created by Kevin Lundberg on 9/27/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIImageEffects)

- (UIImageView *)lightBlurredView;
- (UIImageView *)extraLightBlurredView;
- (UIImageView *)darkBlurredView;
- (UIImageView *)blurredViewWithTintColor:(UIColor *)color;

@end
