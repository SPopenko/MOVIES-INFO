//
//  ShortMovieInfo.m
//  Movies-Info
//
//  Created by apol.dp on 9/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShortMovieInfo.h"


@implementation ShortMovieInfo

@synthesize imagePath;
@synthesize movieName;
@synthesize runTime;
@synthesize releaseDate;
@synthesize fanRating;
@synthesize movieId;

@synthesize movieLink;

- (void) dealloc
{
    	
    [imagePath   release];
    [movieName   release];
    [runTime     release];
    [releaseDate release];
    [fanRating   release];
    [movieId     release];
    
    [movieLink   release];
}

@end
