//
//  DetailedMovieInfoTest.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailedMovieInfoTest.h"

@implementation DetailedMovieInfoTest

#define htmlPageToFill @"[posterUrl][rating][release][cast][description][backdrops]"
#define kresultHtmlPageFromEmptyMovieInfo @"resultHtmlPageFromEmptyMovieInfo"
#define kresultHtmlPageFromRealMovieInfoWithBackdrops @"resultHtmlPageFromRealMovieInfoWithBackdrops"
#define kresultHtmlPageFromRealMovieInfoWithEmptyBackdrops @"resultHtmlPageFromRealMovieInfoWithEmptyBackdrops"

- (void) setUp
{
    _movieInfo = [[MovieInfo  alloc] init];
    testObject = nil;
    _testFinished = NO;
}

//getTrailer Tests
//Nil is right result
- (void) testGetTrailerFromEmptyMovieInfo
{
    testObject = [[DetailedMovieInfo alloc] init];
    GHAssertNil([testObject getTrailer], @"Result is not nil");    
    [testObject release];
    testObject = nil;
}

//Nil result is right
- (void) testGetTrailerWithEmptyTrailers
{
    _testFinished = NO;
    [_movieInfo getDetailedMovieInfoByMovieID:@"2374" doAfterLoadFinished:^(id obj)
     {
         testObject = [((DetailedMovieInfo*)obj) getTrailer];
         _testFinished = YES;
     }];
    //TODO Write more right code
    //Waiting for query execution
    while (!_testFinished) {
        usleep(100000);
    }
    GHAssertNil(testObject, @"Result is not nil");
    [testObject release];
    testObject = nil;
}

//Nil result is not right
- (void) testGetTrailerMovieInfo
{
    testObject = nil;
    _testFinished = NO;
    [_movieInfo getDetailedMovieInfoByMovieID:@"38356" doAfterLoadFinished:^(id obj)
     {
         DetailedMovieInfo* dmi = [obj retain];
         testObject = dmi.trailer;
         _testFinished = YES;
         //[dmi release];
     }];
    //TODO Write more right code
    //Waiting for query execution

    while (!_testFinished) {
        usleep(100000);
    }
    GHAssertNotNil(testObject, @"Result is nil");
    
    [testObject release];
    testObject = nil;
}

- (void) dealloc
{
    [_movieInfo release];
    [super dealloc];
}

@end
