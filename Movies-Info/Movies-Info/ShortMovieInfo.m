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
    
    if (![self.url isEqual:test.url] && result) 
    {
        result = NO;
    }
    
    if (![self.type isEqual:test.type] && result)
    {
        result = NO;
    }
    
    if (![self.size isEqual:test.size] && result)
    {
        result = NO;
    }
    
    [test release];
    
    return result;
}

#pragma mark NSCoder 
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self.url  = [aDecoder decodeObjectForKey:@"url"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.size = [aDecoder decodeObjectForKey:@"size"];
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.url  forKey:@"url"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.size forKey:@"size"];
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
    
    if (![self.image isEqual:test.image] && result)
    {
        result = NO;
    }
    
    [test release];
    
    return result;
}

#pragma mark NSCoder 
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self.image = [aDecoder decodeObjectForKey:@"image"];
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.image forKey:@"image"];
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
    
    if (![self.posters isEqualToArray:test.posters])
    {
        result = NO;
    }
    
    if (![self.movieId isEqual:test.movieId] && result)
    {
        result = NO;
    }

    if (![self.fanRating isEqual:test.fanRating] && result)
    {
        result = NO;
    }

    if (![self.movieName isEqual:test.movieName] && result)
    {
        result = NO;
    }
    
    if (![self.duration isEqual:test.duration] && result)
    {
        result = NO;
    }
    
    if (![self.releaseDate isEqual:test.releaseDate] && result)
    {
        result = NO;
    }

    [test release];
    
    return result;
}

#pragma mark NSCoder 
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self.posters     = [aDecoder decodeObjectForKey:@"posters"];
    self.movieId     = [aDecoder decodeObjectForKey:@"movieID"];
    self.fanRating   = [aDecoder decodeObjectForKey:@"fanRating"];
    self.movieName   = [aDecoder decodeObjectForKey:@"movieName"];
    self.duration    = [aDecoder decodeObjectForKey:@"duration"]; 
    self.releaseDate = [aDecoder decodeObjectForKey:@"releaseDate"];
    
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.posters     forKey:@"posters"];
    [aCoder encodeObject:self.movieId     forKey:@"movieID"];
    [aCoder encodeObject:self.fanRating   forKey:@"fanRating"];
    [aCoder encodeObject:self.movieName   forKey:@"movieName"];
    [aCoder encodeObject:self.duration    forKey:@"duration"]; 
    [aCoder encodeObject:self.releaseDate forKey:@"releaseDate"];
    
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
