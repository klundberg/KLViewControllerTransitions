//
//  KLMasterViewController.m
//  KLModalTransitionsDemo
//
//  Created by Kevin Lundberg on 9/26/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "KLMasterViewController.h"

#import "KLBlurDetailController.h"
#import "KLBlurredBackgroundCoverTransition.h"

@interface KLMasterViewController ()

@property (nonatomic, copy) NSArray *transitionOptions;

@end

@implementation KLMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.transitionOptions = @[@(KLTransitionTypeCoverVertical),
                               @(KLTransitionTypeSpinFromCenter)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.window.tintColor = [UIColor greenColor];
}

#pragma mark - Table View

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

        KLTransitionType type = [self.transitionOptions[indexPath.row] integerValue];
        [segue.destinationViewController setTransitionType:type];
    }
}

@end
