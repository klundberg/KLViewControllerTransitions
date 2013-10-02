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

    self.transitionOptions = @[@(KLTransitionTypeCoverVertical)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.window.tintColor = [UIColor greenColor];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.transitionOptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSString *text = @"";
    KLTransitionType type = [self.transitionOptions[indexPath.row] integerValue];
    switch (type) {
        case KLTransitionTypeCoverVertical:
            text = @"Cover Vertical With Blur";
            break;
    }

    cell.textLabel.text = text;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

        KLTransitionType type = [self.transitionOptions[indexPath.row] integerValue];
        [segue.destinationViewController setTransitionType:type];
    }
}

@end
