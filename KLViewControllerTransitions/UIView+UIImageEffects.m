//
//  UIView+UIImageEffects.m
//  KLModalTransitions
//
//  Created by Kevin Lundberg on 9/27/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "UIView+UIImageEffects.h"
#import "UIImage+ImageEffects.h"

@implementation UIView (UIImageEffects)

- (UIImage *)imageRepresentation
{
    UIGraphicsBeginImageContext(self.bounds.size);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    return image;
}

- (UIImageView *)lightBlurredView
{
    UIImage *image = [self imageRepresentation];
    return [[UIImageView alloc] initWithImage:[image applyLightEffect]];
}

- (UIImageView *)extraLightBlurredView
{
    UIImage *image = [self imageRepresentation];
    return [[UIImageView alloc] initWithImage:[image applyExtraLightEffect]];
}

- (UIImageView *)darkBlurredView
{
    UIImage *image = [self imageRepresentation];
    return [[UIImageView alloc] initWithImage:[image applyDarkEffect]];
}

- (UIImageView *)blurredViewWithTintColor:(UIColor *)color
{
    UIImage *image = [self imageRepresentation];
    return [[UIImageView alloc] initWithImage:[image applyTintEffectWithColor:color]];
}

@end
