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
    Person* compareObject = nil;
    
    if (![object isMemberOfClass:[Person class]]) return NO;
    
    compareObject = [(Person*) object retain];
    
    if (![self.name isEqualToString:compareObject.name]) return NO;    

    return YES;
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
    DetailedMovieInfo* compareObject = nil;
    
    if (![object isMemberOfClass:[DetailedMovieInfo class]]) return NO;

    compareObject = [[(DetailedMovieInfo*) object retain] autorelease];
    
    if (![super isEqual:(ShortMovieInfo*)object]) return NO;
    
    
    if (![_backdrops isEqualToArray:compareObject.backdrops]) return NO;
    
    if (![_cast isEqualToArray:compareObject.cast]) return NO;
    
    if (![_description isEqualToString:compareObject.description]) return NO;
    
    if (![[[_trailer copy] autorelease] isEqualToString:[[compareObject.trailer copy] autorelease]]) return NO;
    
    return YES;
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
