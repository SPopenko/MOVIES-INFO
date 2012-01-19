//
//  SearchBarAdditionsDelegate.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchBarAdditionsDelegate <NSObject>

@optional
- (void) searchBarDelegateBeginSearch;
- (void) searchBarDelegateEndSearch:(NSArray*) resultsArray;
- (void) searchBarDelegateSearchError:(NSError*)error;
- (void) searchBarDelegateHideSearchResults;

@end
