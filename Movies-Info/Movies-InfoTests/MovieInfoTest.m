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
    NSDictionary* searchParameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      [NSString stringWithString:@"rating"],    @"orderBy",
                                      [NSString stringWithString:@"desc"],      @"order",
                                      [NSString stringWithFormat:@"%d", count], @"perPage",
                                      [NSString stringWithString:@"1"],         @"page",
                                      [NSString stringWithString:@"5"],         @"minVotes",
                                      nil];
    [_movieInfo getShortMovieInfoWithParameters:searchParameters doAfterLoadFinished:^(id obj)
     {
         _movieList = [obj retain];
         NSString* path = [[NSBundle mainBundle] pathForResource:@"testGetMovieInfoListWithRealParamsResult" ofType:@"plist"];  
         if (![NSKeyedArchiver archiveRootObject:_movieList toFile:path])
               //toFile:@"/Users/apolub/Documents/testGetMovieInfoListWithRealParamsResult.plist"])
         {
             NSLog(@"Write to file fails");
         }
         
         NSArray* arr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
         NSLog(@"asdfghjkl");
         //NSArray* result = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
         //NSLog(@"%@",[result isEqualToArray:_movieList]);
         _testFinished = YES;
     }];
    //TODO Write more right code
    //Waiting for query execution
    while (!_testFinished) {
        usleep(100000);
    }
    GHAssertTrue(_movieList.count == count, @"Wrong number of elements in result array");
    _testFinished = NO;
//    [searchParameters release];
}
     
- (void) dealloc
{
    [_movieInfo release];
    [super dealloc];
}
     

@end
