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
    Image* test = nil;
    if (![object isKindOfClass:[Image class]] && result)
    {
        result = NO;
    }
    
    test = [(Image*) object retain];
    
    if (![_url isEqual:test.url] && result) 
    {
        result = NO;
    }
    
    if (![_type isEqual:test.type] && result)
    {
        result = NO;
    }
    
    if (![_size isEqual:test.size] && result)
    {
        result = NO;
    }
    
    [test release];
    
    return result;
}

#pragma mark NSCoder 
- (id) initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"It not works");
    
    return nil;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    NSLog(@"It not works");
}

@end

@implementation Poster
@synthesize image = _image;
- (BOOL) isEqual:(id)object
{
    BOOL result = YES;
    Poster* test = nil;
    if (![object isKindOfClass:[Poster class]] && result)
    {
        result = NO;
    }
    
    test = [(Poster*) object retain];
    
    if (![_image isEqual:test.image] && result)
    {
        result = NO;
    }
    
    [test release];
    
    return result;
}

#pragma mark NSCoder 
- (id) initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"It not works");
    
    return nil;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    NSLog(@"It not works");
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

- (BOOL) isEqual:(id)object
{
    BOOL result = YES;
    ShortMovieInfo* test = nil;

    if (![object isKindOfClass:[ShortMovieInfo class]] && result)
    {
        result = NO;
    }
    
    test = [(ShortMovieInfo*) object retain];
    
    if (![_posters isEqualToArray:test.posters] && result)
    {
        result = NO;
    }
    
    if (![_movieId isEqual:test.movieId] && result)
    {
        result = NO;
    }
    
    if (![_fanRating isEqual:test.fanRating] && result)
    {
        result = NO;
    }

    if (![_movieName isEqual:test.movieName] && result)
    {
        result = NO;
    }
    
    if (![_duration isEqual:test.duration] && result)
    {
        result = NO;
    }
    
    if (![_releaseDate isEqual:test.releaseDate] && result)
    {
        result = NO;
    }

    [test release];
    
    return result;
}

#pragma mark NSCoder 
- (id) initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"It not works");
    
    return nil;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    NSLog(@"It not works");
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
