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

- (BOOL) isEqual:(id)object
{
    Image* compareObject = nil;
    
    if (![object isKindOfClass:[Image class]]) return NO;
    
    compareObject = [(Image*) object retain];
    
    if (![self.url isEqual:compareObject.url]) return NO;
    
    if (![self.type isEqual:compareObject.type]) return NO;    
    if (![self.size isEqual:compareObject.size]) return NO;    
    [compareObject release];
    
    return YES;
}

@end

@implementation Poster

@synthesize image = _image;

- (BOOL) isEqual:(id)object
{
    Poster* compareObject = nil;
    if (![object isKindOfClass:[Poster class]]) return NO;   
    
    compareObject = [[(Poster*) object retain] autorelease];
    
    if (![self.image isEqual:compareObject.image]) return NO;    
    
    return YES;
}

@end

@implementation ShortMovieInfo

@synthesize imagePath = _imagePath;
@synthesize movieName = _movieName;
@synthesize duration = _duration;
@synthesize releaseDate = _releaseDate;
@synthesize fanRating = _fanRating;
@synthesize movieId = _movieId;
@synthesize posters = _posters;

- (NSString*) getPoster
{
    NSString* result = nil;

    for (int i = 0; i < _posters.count; i++)
    {
        Poster* p = [_posters objectAtIndex:i];
        if (p != nil && [[p.image.size lowercaseString] isEqualToString:@"cover"])
        {
            result = [NSString stringWithString:p.image.url];
            break;
        }
    }
    return result;
}

- (BOOL) isEqual:(id)object
{
    ShortMovieInfo* compareObject = nil;

    if (![object isKindOfClass:[ShortMovieInfo class]]) return NO;    
    
    compareObject = [(ShortMovieInfo*) object retain];
    
    if (![self.posters isEqualToArray:compareObject.posters]) return NO;    
    if (![self.movieId isEqual:compareObject.movieId]) return NO;
    if (![self.fanRating isEqual:compareObject.fanRating]) return NO;
    if (![self.movieName isEqual:compareObject.movieName]) return NO;    
    if (![self.duration isEqual:compareObject.duration]) return NO;    
    if (![self.releaseDate isEqual:compareObject.releaseDate]) return NO;    
    
    return YES;
}

- (void) dealloc
{
    	
    [_imagePath   release];
    [_movieName   release];
    [_duration    release];
    [_releaseDate release];
    [_fanRating   release];
    [_movieId     release];
    [super        dealloc];
}

@end
