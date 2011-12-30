//
//  DetailedMovieInfoTest.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

#import "GHTestCase(ResultsFromFile).h"
#import "GHTestCase(MovieInfoFilling).h"
#import "MovieInfo.h"
#import "DetailedMovieInfo.h"

@interface DetailedMovieInfoTest : GHTestCase

//getTrailer Tests
- (void) testGetTrailer_EmptyMovieInfo;
- (void) testGetTrailer_EmptyTrailer;
- (void) testGetTrailer_WithTrailer;

@end
