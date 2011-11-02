//
//  UIViewActioIndicator.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (ViewActionIndicator)<MBProgressHUDDelegate>

- (void) prepareActionIndicator;//ForView:(UIViewController*) view;
- (void) showLoadFinishIndicator;//ForView:(UIViewController*) view;
- (void) showLoadIndicator;//ForView:(UIViewController*) view;
- (void) showLoadIndicatorWithText:(NSString*)indicatorTest;// forView:(UIViewController*) view;
- (void) hideIndicator;//ForView:(UIViewController*) view;
- (void) waitForTwoSeconds;
@end
