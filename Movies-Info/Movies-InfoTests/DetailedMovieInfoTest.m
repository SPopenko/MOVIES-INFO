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

- (DetailedMovieInfoTest*) init
{
    NSBundle* bundle = [NSBundle mainBundle];
	NSString* plistPath = [bundle pathForResource:@"DetailedMovieInfoTestResultStrings" ofType:@"plist"];
    _testResults        = [[NSDictionary dictionaryWithContentsOfFile:plistPath] retain];
    
    return self;
}

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
    testObject = [[ShortMovieInfo alloc] init];
    GHAssertNil([testObject getPoster], @"Result is not nil");    
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
         testObject = [dmi getTrailer];
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


- (void) testFillHtmlPageFromEmptyMovieInfo
{
    DetailedMovieInfo* dmi = [[DetailedMovieInfo alloc]init];
    NSMutableString* html = [NSMutableString stringWithString:htmlPageToFill];
    testObject = [dmi fillHtmlPage:html];
    GHAssertEqualStrings(testObject, [self loadStringForKey:kresultHtmlPageFromEmptyMovieInfo], nil);    
    [dmi release];
    [testObject release];
    testObject = nil;
}

//Nil result is right
- (void) testFillHtmlPageFromRealMovieInfoWithEmptyBackdrops
{
    testObject = nil;
    _testFinished = NO;
    [_movieInfo getDetailedMovieInfoByMovieID:@"2374" doAfterLoadFinished:^(id obj)
     {
         DetailedMovieInfo* dmi = [obj retain];
         NSMutableString* html = [NSMutableString stringWithString:htmlPageToFill];
         testObject = [dmi fillHtmlPage:html];
         [dmi release];
         _testFinished = YES;
     }];
    //TODO Write more right code
    //Waiting for query execution
    while (!_testFinished) {
        usleep(100000);
    }
    GHAssertEqualStrings(testObject, [self loadStringForKey:kresultHtmlPageFromRealMovieInfoWithEmptyBackdrops], nil);
    _testFinished = NO;
    [testObject release];
}


- (void) testFillHtmlPageFromRealMovieInfoWithBackdrops
{
    testObject = nil;
    _testFinished = NO;
    [_movieInfo getDetailedMovieInfoByMovieID:@"54293" doAfterLoadFinished:^(id obj)
     {
         DetailedMovieInfo* dmi = [obj retain];
         NSMutableString* html = [NSMutableString stringWithString:htmlPageToFill];
         testObject = [dmi fillHtmlPage:html];
         _testFinished = YES;
         [dmi release];
     }];
    //TODO Write more right code
    //Waiting for query execution
    while (!_testFinished) {
        usleep(100000);
    }
    GHAssertEqualStrings(testObject, [self loadStringForKey:kresultHtmlPageFromRealMovieInfoWithBackdrops], nil);
    _testFinished = NO;
    [testObject release];
}

- (NSString*) loadStringForKey:(NSString *)key
{
    NSString* result = nil;
    result  = [NSString stringWithFormat:@"%@", [_testResults objectForKey:key]];
    return result;
}

- (void) dealloc
{
    [_testResults release];
    [_movieInfo release];
    [super dealloc];
}

@end
