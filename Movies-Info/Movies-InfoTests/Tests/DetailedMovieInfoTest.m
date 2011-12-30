//
//  DetailedMovieInfoTest.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailedMovieInfoTest.h"

@implementation DetailedMovieInfoTest
#define kgetTrailer_WithTrailerInput  @"GetTrailer_WithTrailerInput"
#define kgetTrailer_WithTrailerResult @"GetTrailer_WithTrailerResult"
//getTrailer Tests
//Nil is right result
- (void) testGetTrailer_EmptyMovieInfo
{
    DetailedMovieInfo* dmi = [self emptyDetailedMovieInfo];
    GHAssertNil(dmi.trailer, @"Result is not nil");    
}

//Nil result is right
- (void) testGetTrailer_EmptyTrailer
{
    DetailedMovieInfo* dmi = [self filledDetailedMovieInfo];
    
    GHAssertNil(dmi.trailer, @"Result is not nil");   
}

//Nil result is not right
- (void) testGetTrailer_WithTrailer
{
    DetailedMovieInfo* dmi    = [self filledDetailedMovieInfo];
    dmi.trailer = [NSString stringWithString:krightURL];
    NSString* result = [self loadStringForKey:kgetTrailer_WithTrailerResult];
    GHAssertEqualStrings(dmi.trailer, result, @"Result is not nil");   
}

- (void) dealloc
{
    [super dealloc];
}

@end
