//
//  IsEqualTest.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "IsEqualTest.h"

@implementation IsEqualTest

- (void) testIsEqualForObject:(id) first withObject:(id) second withResult:(BOOL) result
{
    [first  retain];
    [second retain];
    if (result)
    {
        GHAssertTrue([first isEqual: second], nil);
    }
    else
    {
        GHAssertFalse([first isEqual: second], nil);        
    }
    
    [first  release];
    [second release];
}

- (void) testIsEqualShortMovieInfo_WrongObject
{
    [self testIsEqualForObject:[self filledShortMovieInfo]
                    withObject:[NSString string]
                    withResult:NO];
}
- (void) testIsEqualShortMovieInfo_RightObject
{
    [self testIsEqualForObject:[self filledShortMovieInfo]
                    withObject:[self filledShortMovieInfo]
                    withResult:YES];
}

- (void) testIsEqualDetailedMovieInfo_WrongObject
{
    [self testIsEqualForObject:[self filledDetailedMovieInfoWithTrailer]
                    withObject:[NSString string]
                    withResult:NO];
}

- (void) testIsEqualDetailedMovieInfo_RightObject
{
    [self testIsEqualForObject:[self filledDetailedMovieInfoWithTrailer]
                    withObject:[self filledDetailedMovieInfoWithTrailer]
                    withResult:YES];
}

@end
