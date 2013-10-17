//
//  KLTransitionEnums.h
//  KLViewControllerTransitions
//
//  Created by Kevin Lundberg on 10/16/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

typedef NS_ENUM(NSInteger, KLTransitionDirection) {
    KLTransitionDirectionForwards,
    KLTransitionDirectionReverse,
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
