//
//  KLModalViewController.h
//  KLViewControllerTransitions
//
//  Created by Kevin Lundberg on 10/1/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLModalViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

- (IBAction)dismissController:(id)sender;

@end
