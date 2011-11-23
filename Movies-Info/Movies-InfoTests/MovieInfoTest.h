//
//  MovieInfoTests.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "MovieInfo.h"

@interface MovieInfoTest : GHTestCase
{
    NSArray* _movieList;
    MovieInfo* _movieInfo;
    BOOL _testFinished;
}

- (void) testGetMovieInfoListWithNilParam;
- (void) testGetMovieInfoListWithRealParams;

@end
