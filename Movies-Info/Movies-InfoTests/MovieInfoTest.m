//
//  MovieInfoTests.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieInfoTest.h"

@implementation MovieInfoTest

- (void) setUp
{
    if (_movieList != nil) {
        [_movieList release];
    }
    _movieList = nil;
    
    if (_movieInfo == nil)
    {
        _movieInfo = [[MovieInfo alloc] init];
    }
}

- (void) testGetMovieInfoListWithNilParam
{
    _testFinished = NO;
    [_movieInfo getShortMovieInfoWithParameters:nil doAfterLoadFinished:^(id obj)
     {
         _movieList = obj; 
         GHAssertTrue(_movieList == nil, @"Something wrong");
         _testFinished = YES;
     }];
    //TODO Write more right code
    //Waiting for query execution
    while (!_testFinished) {
        usleep(100000);
    }
    _testFinished = NO;
}

- (void) testGetMovieInfoListWithRealParams
{
    _testFinished = NO;
    NSUInteger count = 3;
    NSDictionary* searchParameters = [[[NSDictionary alloc] initWithObjectsAndKeys:
                                       [NSString stringWithString:@"rating"],    @"orderBy",
                                       [NSString stringWithString:@"desc"],      @"order",
                                       [NSString stringWithFormat:@"%d", count], @"perPage",
                                       [NSString stringWithString:@"1"],         @"page",
                                       [NSString stringWithString:@"6"],         @"minVotes",
                                      nil] retain];
    [_movieInfo getShortMovieInfoWithParameters:searchParameters doAfterLoadFinished:^(id obj)
     {
         _movieList = [obj retain];
         _testFinished = YES;
     }];
    //TODO Write more right code
    //Waiting for query execution
    while (!_testFinished) {
        usleep(100000);
    }
    NSString* path = [[NSBundle mainBundle] pathForResource:@"testGetMovieInfoListWithRealParamsResult" ofType:@"plist"];  
    NSArray* result = [[NSKeyedUnarchiver unarchiveObjectWithFile:path] retain];
    GHAssertTrue([_movieList isEqualToArray:result], @"Check server response or test results");
    _testFinished = NO;
    [result retain];
    [searchParameters release];
}
     
- (void) dealloc
{
    [_movieInfo release];
    [super dealloc];
}
     

@end
