//
//  YouTubeVideo.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "YouTubeVideo.h"

@implementation YouTubeVideo

#define linkCutter @"&fallback_host"
#define quality    @"quality=medium"
#define videoType  @"video/mp4"

- (NSString*) getMoviePathFromLink:(NSString *)youTubeLink
{
    NSString* result = nil;
    
    //getting youtube page
    NSString* youTubePage = [self getPageContentsOfURL:youTubeLink];

    //Checking loaded youTube page and fininishing if it is not loaded
    if (youTubePage == nil) return result;
    //Getting movie pathes
    NSString* uncleared = [self getBlockWithMoviePathesFromPage:youTubePage];
    //Unescaping moviePathes in video informarion
    NSString* videoInformations = [self replaceEscapedSymbols:uncleared];
    //getting movie path to trailer file
    result = [self getMoviePathFromPageBlock:videoInformations];
    return result ;
}

- (NSString*) getPageContentsOfURL:(NSString*) pageURL
{
    NSString* result = nil;
    
    //Create link to web page
    NSURL* urlToPage = [[NSURL URLWithString:pageURL] retain];
    
    if (urlToPage)
    {
        NSError*          loadError = nil;
        NSStringEncoding* encoding  = nil;
        result = [[[NSString alloc] initWithContentsOfURL:urlToPage usedEncoding:encoding error:&loadError] retain];

        if (loadError && result == nil)
        {
            NSLog(@"Page load failed with error:%d, %@", loadError.code, [loadError description]);
        }
    }
    else
    {
        NSLog(@"Not valid URL string");
    }
     
    [urlToPage release];
    [result autorelease];
    return  result;
}

- (NSString*) getBlockWithMoviePathesFromPage:(NSString*) htmlPage
{
    NSString* result = nil;
    if (htmlPage)
    {
        NSRegularExpression* videoInformationBlock = [[NSRegularExpression alloc] initWithPattern:@"url=.*mp4.*\""
                                                                                          options:NSRegularExpressionSearch
                                                                                            error:NULL];
        
        NSRange videoInformationBlockRange = [videoInformationBlock rangeOfFirstMatchInString: htmlPage options:0 range:NSMakeRange(0, htmlPage.length)];
        if (videoInformationBlockRange.location != NSNotFound)
        {
            result = [[htmlPage substringWithRange:videoInformationBlockRange] retain];
        }
        [videoInformationBlock release];
    }
    [result autorelease];
    return  result;
}

- (NSString*) replaceEscapedSymbols:(NSString*) replaceString
{
    NSString* result = nil;
    
    if (replaceString)
    {
        //Unescaping percented symbols
        result = [replaceString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //Unescaping percented symbols after unescaping
        result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //Replace unicode escaped symbol
        result = [result stringByReplacingOccurrencesOfString:@"\\u0026" withString:@"&"];
        [result retain];
    }
    
    [result autorelease];
    return  result;
}

- (NSString*) getMoviePathFromPageBlock:(NSString *)pageBlock
{
    NSString* result =nil;
    if (pageBlock) 
    {
        NSMutableArray* videoLinks = [NSMutableArray arrayWithArray:[pageBlock componentsSeparatedByString:@"url="]];
        
        //Getting flashvars
        for (int i = 0; i < videoLinks.count; i++)
        {
            NSRange range;
            NSString* temp = ((NSString*) [videoLinks objectAtIndex:i]);
            
            range = [temp rangeOfString:quality];
            if ([temp rangeOfString:quality].location == NSNotFound)
            {
                continue;
            }
            //Checking video quality
            if([temp rangeOfString:videoType].location != NSNotFound)
            {
                NSString* t = nil;
                if ([temp rangeOfString:linkCutter].location != NSNotFound)
                {
                    t = [temp substringToIndex:range.location];
                    result = [t retain];
                }
                else
                {
                    result = [temp retain];
                }
                break;
            }
        }
    }
    [result autorelease];
    return result;
}



@end
