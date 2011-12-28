//
//  ShortMovieInfoTest.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "GHTestCase(ResultsFromFile).h"
#import "GHTestCase(MovieInfoFilling).h"
#import "ShortMovieInfo.h"
#import "MovieInfo.h"

@interface ShortMovieInfoTest : GHTestCase
{
    MovieInfo*      _movieInfo;
    ShortMovieInfo* testObject;
}

//getPoster Tests
- (void) testGetPoster_EmptyMovieInfo;
- (void) testGetPoster_EmptyPoster;
- (void) testGetPoster_WithPoster;

@end
