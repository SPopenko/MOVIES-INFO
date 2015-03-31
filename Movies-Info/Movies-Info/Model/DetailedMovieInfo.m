//
//  DetailedMovieInfo.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 10/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailedMovieInfo.h"

@implementation Person
@synthesize name = _name;

- (BOOL) isEqual:(id)object
{
    Person* test = nil;
    BOOL  result = YES;
    
    if (![object isMemberOfClass:[Person class]] && result)
    {
        result = NO;
    }
    
    test = [(Person*) object retain];
    
    if (![self.name isEqualToString:test.name] && result)
    {
        result = NO;
    }
    
    [test release];
    return result;
}

@end

@implementation DetailedMovieInfo

@synthesize cast        = _cast;
@synthesize backdrops   = _backdrops;
@synthesize description = _description;
@synthesize trailer     = _trailer;

- (DetailedMovieInfo*) init
{  
    return self;
}

- (NSString*) getTrailer
{
    return _trailer;
}

- (void) setTrailer:(NSString *)trailerLink
{
    YouTubeVideo* ytv = [[YouTubeVideo alloc] init];
    _trailer = [[ytv getMoviePathFromLink:trailerLink] retain];
    [ytv release];
}

- (ShortMovieInfo*) getShortMovieInfo
{
    return [super self];
}

- (BOOL) isEqual:(id)object
{
    BOOL result = YES;
    DetailedMovieInfo* test = nil;
    
    if (![object isMemberOfClass:[DetailedMovieInfo class]] && result)
    {
        result = NO;
    }
    else
    {
        test = [(DetailedMovieInfo*) object retain];
        
        if (![super isEqual:(ShortMovieInfo*)object] && result)
        {
            result = NO;
        }
        
        
        if (![_backdrops isEqualToArray:test.backdrops] && result)
        {
            result = NO;
        }
        
        if (![_cast isEqualToArray:test.cast] && result)
        {
            result = NO;
        }
        
        if (![_description isEqualToString:test.description] && result)
        {
            result = NO;
        }
        
        if (![[_trailer copy] isEqualToString:[test.trailer copy]] && result)
        {
            result = NO;
        }
        
        [test release];
    }
    
    return result;
}

- (void) dealloc
{
    [_cast release];
    [_backdrops release];
    [_description release];
    [_trailer release];
    
    [super dealloc];
}
@end
