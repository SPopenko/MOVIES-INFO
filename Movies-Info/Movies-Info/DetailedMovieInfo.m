//
//  DetailedMovieInfo.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 10/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailedMovieInfo.h"


@implementation DetailedMovieInfo

@synthesize cast = _cast;
@synthesize backdrops = _backdrops;
@synthesize description = _description;


- (NSMutableString*) fillHtmlPage:(NSMutableString *)htmlPage
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterLongStyle];
    
    
    [htmlPage replaceOccurrencesOfString:[NSString stringWithString:@"[description]"]
                              withString:_description 
                                 options:NSCaseInsensitiveSearch 
                                   range:NSMakeRange(0, htmlPage.length)];
    [htmlPage replaceOccurrencesOfString:[NSString stringWithString:@"[posterUrl]"]
                              withString:((Poster*)[self.posters  objectAtIndex:5]).image.url 
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

    return htmlPage;
}

- (NSString*) backdropsToHtmlString
{
    NSMutableString* imglist = [[[NSMutableString alloc] initWithString:@""] autorelease];
        
    for (int i =0; i < _backdrops.count; i++)
    {
        Poster* backdrop = [_backdrops objectAtIndex:i];
        if ([[backdrop.image.size lowercaseString] isEqualToString:@"thumb"])
        {
            NSLog(@"{%@}",[backdrop.image.size lowercaseString]);
            [imglist appendFormat:@"<img class=\"slide\" src=\"%@\">", backdrop.image.url];
        }
        NSLog([imglist substringFromIndex:0]);
    }
    return [imglist substringFromIndex:0];
}
- (void) dealloc
{
    [_cast release];
    [_backdrops release];
    [_description release];
    
    [super dealloc];
}
@end
