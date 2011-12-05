//
//  DetailedMovieInfoTest.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

#import "GHTestCase(ResultsFromFile).h"

#import "MovieInfo.h"
#import "DetailedMovieInfo.h"

@interface DetailedMovieInfoTest : GHTestCase
{
    MovieInfo* _movieInfo;
    BOOL       _testFinished;
    id         testObject;
}

//getTrailer Tests
- (void) testGetTrailerFromEmptyMovieInfo;
- (void) testGetTrailerWithEmptyTrailers;
- (void) testGetTrailerMovieInfo;

//fillHtmlPage Tests
- (void) testFillHtmlPageFromEmptyMovieInfo;
- (void) testFillHtmlPageFromRealMovieInfoWithEmptyBackdrops;
- (void) testFillHtmlPageFromRealMovieInfoWithBackdrops;

@end
