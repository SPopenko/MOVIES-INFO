//
//  ShortMovieInfoTest.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "ShortMovieInfo.h"
#import "MovieInfo.h"

@interface ShortMovieInfoTest : GHTestCase
{
    MovieInfo*      _movieInfo;
    ShortMovieInfo* testObject;
}

//getPoster Tests
//ShortMovieInfo is nil
- (void) testGetPosterFromEmptyMovieInfo;
//ShortMovieInfo loaded from api.themoviedb.org
- (void) testGetPosterWithEmptyPosters;
//ShortMovieInfo loaded from api.themoviedb.org
- (void) testGetPosterMovieInfoWithPosters;

@end
