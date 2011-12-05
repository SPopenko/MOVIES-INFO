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
    YouTubeVideo* ytv = [[[YouTubeVideo alloc] init] retain];
    _trailer = [[ytv getMoviePathFromLink:trailerLink] retain];
    [ytv release];
}

- (NSMutableString*) fillHtmlPage:(NSMutableString *)htmlPage
{
    [htmlPage retain];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterLongStyle];
    
    //Adding description
    [self replaceString:@"[description]"
             withString:_description
               inString:htmlPage];
    //Adding poster
    [self replaceString:@"[posterUrl]"
             withString:[self htmlStringFromImageAtKey:self.poster]
               inString:htmlPage];
    //Adding releaseDate
    [self replaceString:@"[release]"
             withString:[df stringFromDate:self.releaseDate]
               inString:htmlPage];
    //Adding movie name
    [self replaceString:@"[name]"
             withString:self.movieName
               inString:htmlPage];
    //Adding backdrops
    [self replaceString:@"[backdrops]"
             withString:[self backdropsToHtmlString]
               inString:htmlPage];
    //Adding cast
    [self replaceString:@"[cast]"
             withString:[self castToHtmlString]
               inString:htmlPage];
    //Adding fan rating
    [self replaceString:[NSMutableString stringWithString:@"[rating]"]
             withString:[NSMutableString stringWithFormat:@"%2.1f", [self.fanRating doubleValue]]
               inString:htmlPage];

    [df release];
    return htmlPage;
}

- (void) replaceString:(NSMutableString*) replaceString withString:(NSMutableString*) withString inString:(NSMutableString*) inString
{
    //Checking internal Value
    if (replaceString == nil || inString == nil) return;
    
    NSMutableString* insertString = [NSMutableString stringWithString:@""];

    if (withString != nil)
    {
        [insertString appendFormat:@"%@", withString];
    }
    
    [inString replaceOccurrencesOfString:replaceString
                              withString:insertString
                                 options:NSCaseInsensitiveSearch
                                   range:NSMakeRange(0, inString.length)];
}

- (NSMutableString*) backdropsToHtmlString
{
    NSMutableString* imgList = [[[NSMutableString alloc] initWithString:@""] autorelease];
    
    if (_backdrops != nil)
    {
        for (int i =0; i < _backdrops.count; i++)
        {
            Poster* backdrop = [_backdrops objectAtIndex:i];
            if ([[backdrop.image.size lowercaseString] isEqualToString:@"thumb"])
            {
                [imgList appendFormat:@"<img class=\"slide\" src=\"%@\">", [self htmlStringFromImageAtKey:backdrop.image.url]];
            }
        }
    }
    if ([imgList isEqualToString:@""]) [imgList appendString:@"no backdrops found"];
    return imgList;
}

- (NSMutableString*) castToHtmlString
{
    NSMutableString* castList = [[[NSMutableString alloc] initWithString:@""] autorelease];
    if (_cast!=nil)
    {
        for (int i = 0; i < _cast.count; i++) 
        {
            if (i > 0)
            {
                [castList appendString:@", "];
            }
            [castList appendString:((Person*)[_cast objectAtIndex:i]).name];
        }
    }
    
    return castList;
}

- (NSString*) htmlStringFromImageAtKey:(NSString *)imagekey
{
    UIImage* image = [MovieCache getImageFromCache:imagekey];
    NSData*  imageData = UIImagePNGRepresentation(image);
    return [NSString stringWithFormat:@"data:image/png;base64,%@",[imageData base64Encoding]];
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
