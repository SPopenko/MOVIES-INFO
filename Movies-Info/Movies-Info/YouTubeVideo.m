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

+ (NSString*) getMoviePathFromLink:(NSString *)youTubeLink
{
    NSString* result = nil;
    if (youTubeLink)
    {
        //preparing yout ube page ro parse
        NSString* youTubePage = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:youTubeLink] encoding:NSUTF8StringEncoding error:NULL];
        //Getting flashvars
        NSRegularExpression* videoInformationBlock = [[NSRegularExpression alloc] initWithPattern:@"url=.*mp4.*\""
                                                                                          options:NSRegularExpressionSearch
                                                                                            error:NULL];
        
        NSRange videoInformationBlockRange = [videoInformationBlock rangeOfFirstMatchInString: youTubePage options:0 range:NSMakeRange(0, youTubePage.length)];
        NSString* videoInformations = [[youTubePage substringWithRange:videoInformationBlockRange] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableArray* videoLinks = [NSMutableArray arrayWithArray:[videoInformations componentsSeparatedByString:@"url="]];
        
        for (int i = 0; i < videoLinks.count; i++)
        {
            NSRange range;
            NSString* temp = [[((NSString*) [videoLinks objectAtIndex:i])
                               stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                              stringByReplacingOccurrencesOfString:@"\\u0026" withString:@"&"];
            
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
        [videoInformationBlock release];
        [youTubePage release];
    }
    [result autorelease];
    return result ;
}

@end
