//
//  ShortMovieInfoTest.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ShortMovieInfoTest.h"

@implementation ShortMovieInfoTest

#define rightURL @"http://www.youtube.com/watch?v=Hhgfz0zPmH4"

- (void) setUp
{
    _movieInfo = [[MovieInfo  alloc] init];
    testObject = nil;
}

//getPoster Tests
//Nil is right result
- (void) testGetPosterFromEmptyMovieInfo
{
    testObject = [[ShortMovieInfo alloc] init];
    GHAssertNil([testObject getPoster], @"Result is not nil");    
    [testObject release];
    testObject = nil;
}

//Nil result is right
- (void) testGetPosterWithEmptyPosters
{
    [_movieInfo getDetailedMovieInfoByMovieID:@"2374" doAfterLoadFinished:^(id obj)
     {
         testObject = [[((DetailedMovieInfo*)obj) getShortMovieInfo] getPoster];
         GHAssertNil(testObject, @"Result is not nil");
     }];
    //TODO Write more right code
    //Waiting for query execution
    sleep(8);
    [testObject release];
}


- (void) testGetRealPosterMovieInfo
{
    [_movieInfo getDetailedMovieInfoByMovieID:@"38356" doAfterLoadFinished:^(id obj)
     {
         testObject = [[((DetailedMovieInfo*)obj) getShortMovieInfo] getPoster];
         GHAssertNotNil(testObject, @"Result is nil");
     }];
    //TODO Write more right code
    //Waiting for query execution
    sleep(8);
    [testObject release];
}

- (void) dealloc
{
    [testObject release];
    [_movieInfo release];
    [super dealloc];
}

@end
