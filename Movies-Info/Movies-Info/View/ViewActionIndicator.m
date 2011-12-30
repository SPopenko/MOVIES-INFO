//
//  UIViewActioIndicator.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewActionIndicator.h"

@implementation UIViewController (UIViewActionIndicator)

MBProgressHUD* actionIndicator;

#pragma mark - MBProgressHUDDelegate methods
- (void) hudWasHidden
{
    if ([self isKindOfClass:[UITableViewController class]])
    {
        ((UITableViewController*) self).tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    [actionIndicator removeFromSuperview];
    [actionIndicator release];
    actionIndicator = nil;
}

#pragma mark - actionIndicator Activities
- (void) showLoadIndicator
{
    [self showLoadIndicatorWithText:@"Loading"];
}

- (void) prepareActionIndicator
{
    if (actionIndicator == nil)
    {
        actionIndicator = [[MBProgressHUD alloc] initWithView:self.view];
    }
    [self.view addSubview:actionIndicator];
    if ([self isKindOfClass:[UITableViewController class]])
    {
        ((UITableViewController*) self).tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    actionIndicator.delegate = self;
}
- (void) showLoadIndicatorWithText:(NSString*)indicatorText// forView:(UIViewController*) view
{
    [self prepareActionIndicator];

    actionIndicator.mode = MBProgressHUDModeIndeterminate;
    actionIndicator.labelText = indicatorText;
    actionIndicator.dimBackground = YES;
    [actionIndicator show:YES];
    
}

- (void) showLoadFinishIndicator//ForView:(UIViewController*) view
{
    [self prepareActionIndicator];

    actionIndicator.dimBackground = NO;
    actionIndicator.customView = [[[UIImageView alloc] initWithImage:
                                   [UIImage imageNamed:@"checkmark.png"]] autorelease];
    actionIndicator.mode = MBProgressHUDModeCustomView;
    actionIndicator.labelText = @"Load finished";
    [actionIndicator showWhileExecuting:@selector(waitForTwoSeconds) 
                               onTarget:self withObject:nil animated:YES];
}

-(void) hideIndicatorForView:(UIViewController*) view
{
    if (actionIndicator != nil)
    {
        [actionIndicator show:NO];
    }
}

- (void)waitForTwoSeconds {
    sleep(2);
}

- (void) dealloc
{
    [actionIndicator dealloc];
    [super dealloc];
}

@end
