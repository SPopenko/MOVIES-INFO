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
    
    if (![_description isEqual:test.description] && result)
    {
        result = NO;
    }
    
    if (![_trailer isEqual:test.trailer] && result)
    {
        result = NO;
    }
    
    [test release];
    
    return result;
}

#pragma mark NSCoder 
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.backdrops   = [aDecoder decodeObjectForKey:@"backdrops"];
    self.cast        = [aDecoder decodeObjectForKey:@"cast"];
    self.description = [aDecoder decodeObjectForKey:@"description"];
    self.trailer     = [aDecoder decodeObjectForKey:@"trailer"];
    
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [super initWithCoder:aCoder];
    
    [aCoder encodeObject:self.backdrops forKey:@"backdrops"];
    [aCoder encodeObject:self.cast forKey:@"cast"];
    [aCoder encodeObject:self.description forKey:@"description"];
    [aCoder encodeObject:self.trailer forKey:@"trailer"];
    
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
