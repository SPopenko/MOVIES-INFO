//
//  UIViewController+SearchBarAdditions.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchBarAdditionsDelegate.h"

@interface UIViewController (SearchBarAdditions) <UISearchBarDelegate, SearchBarAdditionsDelegate>

- (void) addSearchBar;
- (void) displaySearchBar;
- (void) displaySearchBarIfActive;
- (void) hideSearchBar;

- (void) searchString:(NSString*)searchString;

@end
