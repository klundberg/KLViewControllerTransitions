//
//  KLDetailViewController.h
//  KLModalTransitionsDemo
//
//  Created by Kevin Lundberg on 9/26/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KLTransitionType)
{
    KLTransitionTypeCoverVertical
};

@interface KLBlurDetailController : UIViewController <UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) KLTransitionType transitionType;
@property (strong, nonatomic) IBOutlet UISegmentedControl *styleControl;

- (IBAction)presentController:(id)sender;
@end
