//
//  KLModalViewController.m
//  KLViewControllerTransitions
//
//  Created by Kevin Lundberg on 10/1/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "KLModalViewController.h"

@interface KLModalViewController ()

@end

@implementation KLModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)dismissController:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
