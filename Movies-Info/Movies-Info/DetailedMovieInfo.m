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
                              withString:_description 
                                 options:NSCaseInsensitiveSearch 
                                   range:NSMakeRange(0, htmlPage.length)];
    
    NSLog(((Poster*)[_backdrops objectAtIndex:5]).image.url);
    return htmlPage;
}

- (NSString*) htmlFromBackdrops
{
    
}

- (void) dealloc
{
    [_cast release];
    [_backdrops release];
    [_description release];
    
    [super dealloc];
}
@end
