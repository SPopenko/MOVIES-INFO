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

@synthesize cast = _cast;
@synthesize backdrops = _backdrops;
@synthesize description = _description;


- (NSMutableString*) fillHtmlPage:(NSMutableString *)htmlPage
{
    NSString* imagekey = nil;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterLongStyle];
    
    if([self.posters count]>5)
    {
        imagekey = ((Poster*) [self.posters objectAtIndex:4]).image.url;
    }
    
    [htmlPage replaceOccurrencesOfString:[NSString stringWithString:@"[description]"]
                              withString:_description 
                                 options:NSCaseInsensitiveSearch 
                                   range:NSMakeRange(0, htmlPage.length)];
    [htmlPage replaceOccurrencesOfString:[NSString stringWithString:@"[posterUrl]"]
                              withString:[self htmlStringFromImageAtKey:imagekey]
                                 options:NSCaseInsensitiveSearch 
                                   range:NSMakeRange(0, htmlPage.length)];
    [htmlPage replaceOccurrencesOfString:[NSString stringWithString:@"[release]"]
                              withString:[df stringFromDate:self.releaseDate]
                                 options:NSCaseInsensitiveSearch 
                                   range:NSMakeRange(0, htmlPage.length)];
    [htmlPage replaceOccurrencesOfString:[NSString stringWithString:@"[name]"]
                              withString:self.movieName 
                                 options:NSCaseInsensitiveSearch 
                                   range:NSMakeRange(0, htmlPage.length)];
    [htmlPage replaceOccurrencesOfString:[NSString stringWithString:@"[backdrops]"]
                              withString:[self backdropsToHtmlString]
                                 options:NSCaseInsensitiveSearch 
                                   range:NSMakeRange(0, htmlPage.length)];
    [htmlPage replaceOccurrencesOfString:[NSString stringWithString:@"[cast]"]
                              withString:[self castToHtmlString]
                                 options:NSCaseInsensitiveSearch 
                                   range:NSMakeRange(0, htmlPage.length)];
    [htmlPage replaceOccurrencesOfString:[NSString stringWithString:@"[rating]"]
                              withString:[NSString stringWithFormat:@"%2.1f", [self.fanRating doubleValue]]
                                 options:NSCaseInsensitiveSearch 
                                   range:NSMakeRange(0, htmlPage.length)];
    
    
    [df release];
    return htmlPage;
}

- (NSString*) backdropsToHtmlString
{
    NSMutableString* imgList = [[[NSMutableString alloc] initWithString:@""] autorelease];
    
    if (_backdrops.count == 0) [imgList appendString:@"no backdrops found"];
    for (int i =0; i < _backdrops.count; i++)
    {
        Poster* backdrop = [_backdrops objectAtIndex:i];
        if ([[backdrop.image.size lowercaseString] isEqualToString:@"thumb"])
        {
            [imgList appendFormat:@"<img class=\"slide\" src=\"%@\">", [self htmlStringFromImageAtKey:backdrop.image.url]];
        }
    }
    return [imgList substringFromIndex:0];
}

- (NSString*) castToHtmlString
{
    NSMutableString* castList = [[[NSMutableString alloc] initWithString:@""] autorelease];
    
    for (int i = 0; i < _cast.count; i++) 
    {
        if (i > 0)
        {
            [castList appendString:@", "];
        }
        [castList appendString:((Person*)[_cast objectAtIndex:i]).name];
    }
    
    return [castList substringFromIndex:0];
}

- (NSString*) htmlStringFromImageAtKey:(NSString *)imagekey
{
    UIImage* image = [MovieCache getImageFromCache:imagekey];
    NSData*  imageData = UIImagePNGRepresentation(image);
    return [NSString stringWithFormat:@"data:image/png;base64,%@",[imageData base64Encoding]];
}

- (void) dealloc
{
    [_cast release];
    [_backdrops release];
    [_description release];
    
    [super dealloc];
}
@end
