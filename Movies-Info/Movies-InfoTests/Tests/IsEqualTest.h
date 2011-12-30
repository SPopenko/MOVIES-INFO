//
//  IsEqualTest.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "GHTestCase(MovieInfoFilling).h"

#import "ShortMovieInfo.h"
#import "DetailedMovieInfo.h"


@interface IsEqualTest : GHTestCase

- (void) testIsEqualShortMovieInfo_WrongObject;
- (void) testIsEqualShortMovieInfo_RightObject;

- (void) testIsEqualDetailedMovieInfo_WrongObject;
- (void) testIsEqualDetailedMovieInfo_RightObject;


@end
