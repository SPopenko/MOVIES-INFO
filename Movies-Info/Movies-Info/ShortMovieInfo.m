//
//  ShortMovieInfo.m
//  Movies-Info
//
//  Created by apol.dp on 9/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShortMovieInfo.h"

@implementation Image
@synthesize url  = _url;
@synthesize type = _type;
@synthesize size = _size;
@end

@implementation Poster
@synthesize image = _image;
@end



@implementation ShortMovieInfo

@synthesize imagePath = _imagePath;
@synthesize movieName = _movieName;
@synthesize duration = _duration;
@synthesize releaseDate = _releaseDate;
@synthesize fanRating = _fanRating;
@synthesize movieId = _movieId;
@synthesize posters = _posters;
@synthesize poster;

- (NSString*) getPoster
{
    NSString* result = nil;
    
    for (int i = 0; i < _posters.count; i++)
    {
        Poster* p = [_posters objectAtIndex:i];
        if (p != nil && [[p.image.size lowercaseString] isEqualToString:@"cover"])
        {
            result = p.image.url;
            break;
        }
    }
    return result;
}

- (void) dealloc
{
    	
    [_imagePath   release];
    [_movieName   release];
    [_duration    release];
    [_releaseDate release];
    [_fanRating   release];
    [_movieId     release];
}

@end
