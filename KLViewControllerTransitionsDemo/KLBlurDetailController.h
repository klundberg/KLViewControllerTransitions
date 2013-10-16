//
//  KLDetailViewController.h
//  KLModalTransitionsDemo
//
//  Created by Kevin Lundberg on 9/26/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KLBlurredBackgroundCoverTransition.h"

@interface KLBlurDetailController : UIViewController <UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) KLTransitionType transitionType;
@property (weak, nonatomic) IBOutlet UISwitch *animatedSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *styleControl;

- (IBAction)presentController:(id)sender;
@end
