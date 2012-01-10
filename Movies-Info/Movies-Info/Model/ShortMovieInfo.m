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
    BOOL result = YES;
    Image* compareObject = nil;
    if (![object isKindOfClass:[Image class]] && result)
    {
        result = NO;
    }
    
    compareObject = [(Image*) object retain];
    
    if (![self.url isEqual:compareObject.url] && result) 
    {
        result = NO;
    }
    
    if (![self.type isEqual:compareObject.type] && result)
    {
        result = NO;
    }
    
    if (![self.size isEqual:compareObject.size] && result)
    {
        result = NO;
    }
    
    [compareObject release];
    
    return result;
}

@end

@implementation Poster

@synthesize image = _image;

- (BOOL) isEqual:(id)object
{
    BOOL result = YES;
    Poster* compareObject = nil;
    if (![object isKindOfClass:[Poster class]] && result)
    {
        result = NO;
    }
    
    compareObject = [(Poster*) object retain];
    
    if (![self.image isEqual:compareObject.image] && result)
    {
        result = NO;
    }
    
    [compareObject release];
    
    return result;
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
    BOOL result = YES;
    ShortMovieInfo* compareObject = nil;

    if (![object isKindOfClass:[ShortMovieInfo class]] && result)
    {
        result = NO;
    }
    else
    {
        compareObject = [(ShortMovieInfo*) object retain];
        
        if (![self.posters isEqualToArray:compareObject.posters] && result)
        {
            result = NO;
        }
        
        if (![self.movieId isEqual:compareObject.movieId] && result)
        {
            result = NO;
        }

        if (![self.fanRating isEqual:compareObject.fanRating] && result)
        {
            result = NO;
        }

        if (![self.movieName isEqual:compareObject.movieName] && result)
        {
            result = NO;
        }
        
        if (![self.duration isEqual:compareObject.duration] && result)
        {
            result = NO;
        }
        
        if (![self.releaseDate isEqual:compareObject.releaseDate] && result)
        {
            result = NO;
        }

        [compareObject release];
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
    [super        dealloc];
}

@end
