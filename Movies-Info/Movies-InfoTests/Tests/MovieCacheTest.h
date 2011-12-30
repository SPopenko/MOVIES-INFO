//
//  MovieCacheTest.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import <UIKit/UIKit.h>
#import "MovieCache.h"

@interface MovieCacheTest : GHTestCase

- (void) testGetImageFromCache_Empty;
- (void) testGetImageFromCache_Real;

@end
