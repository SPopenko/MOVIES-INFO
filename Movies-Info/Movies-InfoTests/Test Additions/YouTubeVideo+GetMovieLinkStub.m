//
//  YouTubeVideo+GetMovieLinkStub.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "YouTubeVideo+GetMovieLinkStub.h"

@implementation YouTubeVideo (GetMovieLinkStub)

- (NSString*) getMoviePathFromLink:(NSString *)youTubeLink
{
    if ([youTubeLink isEqualToString:krightURL])
    {
        return [NSString stringWithString:@"stub"];
    }
    else
    {
        return nil;
    }
}
@end
