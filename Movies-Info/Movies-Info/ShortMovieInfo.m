//
//  ShortMovieInfo.m
//  Movies-Info
//
//  Created by apol.dp on 9/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShortMovieInfo.h"

@implementation Image
@synthesize url = _url;
@end

@implementation Poster
@synthesize image = _image;
@end



@implementation ShortMovieInfo

@synthesize imagePath = _imagePath;
@synthesize movieName = _movieName;
@synthesize duration = _duration;
@synthesize releaseDate = _releaseDate;
@synthesize fanRating = _fanRating;
@synthesize movieId = _movieId;
@synthesize posters = _posters;
@synthesize backdrops = _backdrops;
@synthesize description = _description;

- (void) dealloc
{
    	
    [_imagePath   release];
    [_movieName   release];
    [_duration    release];
    [_releaseDate release];
    [_fanRating   release];
    [_movieId     release];
    [_backdrops   release];
    [_description release];
}

- (NSMutableString*) fillHtmlPage:(NSMutableString *)htmlPage
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterLongStyle];
    
    [htmlPage replaceOccurrencesOfString:[NSString stringWithString:@"[description]"]
                              withString:_description 
                                 options:NSCaseInsensitiveSearch 
                                   range:NSMakeRange(0, htmlPage.length)];
    [htmlPage replaceOccurrencesOfString:[NSString stringWithString:@"[posterUrl]"]
                              withString:((Poster*)[_posters objectAtIndex:5]).image.url 
                                 options:NSCaseInsensitiveSearch 
                                   range:NSMakeRange(0, htmlPage.length)];
    [htmlPage replaceOccurrencesOfString:[NSString stringWithString:@"[release]"]
                              withString:[df stringFromDate:_releaseDate]
                                 options:NSCaseInsensitiveSearch 
                                   range:NSMakeRange(0, htmlPage.length)];
    [htmlPage replaceOccurrencesOfString:[NSString stringWithString:@"[name]"]
                              withString:_movieName 
                                 options:NSCaseInsensitiveSearch 
                                   range:NSMakeRange(0, htmlPage.length)];
    [htmlPage replaceOccurrencesOfString:[NSString stringWithString:@"[description]"]
                              withString:_description 
                                 options:NSCaseInsensitiveSearch 
                                   range:NSMakeRange(0, htmlPage.length)];
    
    
    return htmlPage;
}

@end
