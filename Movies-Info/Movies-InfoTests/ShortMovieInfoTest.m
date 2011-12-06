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
    testObject = [[ShortMovieInfo alloc] init];
}

- (void) tearDown
{
    [testObject release];
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
    NSArray* posters   = [[NSArray alloc] init];
    testObject.posters = posters;
    GHAssertNil(testObject.poster, @"Result is not nil");
    [posters release];
}


- (void) testGetPosterMovieInfoWithPosters
{
    NSMutableArray* posters = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        Image*  i = [[Image alloc] init];
        Poster* p = [[Poster  alloc] init];
        i.url = [[NSString alloc] initWithFormat:@"url%d", 0];
        i.type = @"poster";
        i.size = @"cover";
        p.image = i;
        [posters addObject:p];
    }
    
    [posters writeToFile:@"/Users/apolub/Documents/file.plist" atomically:YES];
    
    testObject.posters = posters;
    GHAssertEqualStrings(@"url0", testObject.poster, @"Result is not nil");
    [posters release];
}

- (void) testGetPosterMovieInfoWithPostersWithoutCover
{
    NSMutableArray* posters = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        Image*  i = [[Image alloc] init];
        Poster* p = [[Poster  alloc] init];
        i.url = [[NSString alloc] initWithFormat:@"url%d", 0];
        i.type = @"posters";
        i.size = @"thumb";
        p.image = i;
        [posters addObject:p];
    }
    
    [posters writeToFile:@"/Users/apolub/Documents/file.plist" atomically:YES];
    
    testObject.posters = posters;
    GHAssertNil(testObject.poster, @"Result is not nil");
    [posters release];
}

- (void) dealloc
{
    [testObject release];
    [_movieInfo release];
    [super dealloc];
}

@end
