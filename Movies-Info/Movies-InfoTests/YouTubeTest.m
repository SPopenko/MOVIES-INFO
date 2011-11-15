//
//  YouTubeTest.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


#import "YouTubeTest.h"


@implementation YouTubeTest
#define wrongURL @"www.ya.ru"
#define rightURL @"http://www.youtube.com/watch?v=Hhgfz0zPmH4"

- (void) testGetMovieLinkPathFromNilURL
{
    GHAssertNil([YouTubeVideo getMoviePathFromLink:nil] , @"Movie path is not null" );
}

- (void) testGetMovieLinkPathFromRightURL
{
    NSString* result = [YouTubeVideo getMoviePathFromLink:rightURL];
    
}

- (void) testGetMovieLinkPathFromWrongURL
{
    GHAssertNil([YouTubeVideo getMoviePathFromLink:wrongURL] , @"Movie path is not null" );
}


@end
