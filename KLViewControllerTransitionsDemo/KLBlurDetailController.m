//
//  KLDetailViewController.m
//  KLModalTransitionsDemo
//
//  Created by Kevin Lundberg on 9/26/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "KLBlurDetailController.h"
#import "KLBlurredBackgroundCoverTransition.h"

@implementation KLBlurDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.styleControl = [[UISegmentedControl alloc] initWithItems:@[@"Light",@"Extra Light",@"Dark",@"Custom"]];
    self.styleControl.selectedSegmentIndex = 0;

    self.toolbarItems = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:Nil action:nil],
                          [[UIBarButtonItem alloc] initWithCustomView:self.styleControl],
                          [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:Nil action:nil],
                          ];
}

- (IBAction)presentController:(id)sender
{
    [self performSegueWithIdentifier:@"modalSegue" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *target = segue.destinationViewController;
    target.transitioningDelegate = self;
    target.modalPresentationStyle = UIModalPresentationCustom;
}

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    KLBlurredBackgroundCoverTransition *transition = [[KLBlurredBackgroundCoverTransition alloc] init];
    transition.blurStyle = self.styleControl.selectedSegmentIndex;
    transition.tintColor = self.view.tintColor;
    return transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    KLBlurredBackgroundCoverTransition *transition = [[KLBlurredBackgroundCoverTransition alloc] initWithMode:KLTransitionModeReverse];
    return transition;
}

@end
