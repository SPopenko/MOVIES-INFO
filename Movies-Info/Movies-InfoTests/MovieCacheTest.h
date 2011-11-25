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

//getImage must return movie.png if argument nil
- (void) testGetEmptyImageFromCache;
//GetImage must return right image if argument valid http link
- (void) testGetRealImageFromCache;
//Loading time for cached image must lower than loading for uncached image
- (void) testGetRealImageFromCacheTime;

@end
