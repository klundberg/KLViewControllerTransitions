//
//  KLBlurredBackgroundTransitionTest.m
//  KLViewControllerTransitions
//
//  Created by Kevin Lundberg on 10/21/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KLViewControllerTransitions.h"

#define MOCKITO_SHORTHAND 1
#import <OCMockito/OCMockito.h>
#define HAMCREST_SHORTHAND 1
#import <OCHamcrest/OCHamcrest.h>

@interface KLBlurredBackgroundCoverTransitionTest : XCTestCase
{
    KLBlurredBackgroundCoverTransition *transition;
    UIView *container;
    UIViewController *originController;
    UIViewController *presentedController;
    id mockContext;
}
@end

@implementation KLBlurredBackgroundCoverTransitionTest

- (void)setUp
{
    [super setUp];
    transition = [[KLBlurredBackgroundCoverTransition alloc] init];
    container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    originController = [[UIViewController alloc] init];
    presentedController = [[UIViewController alloc] init];
    mockContext = mockProtocol(@protocol(UIViewControllerContextTransitioning));
}

- (void)tearDown
{
    transition = nil;
    container = nil;
    originController = nil;
    presentedController = nil;
    [super tearDown];
}

- (void)test_finalTransitionFramePositionedProperly
{
    
}

@end
