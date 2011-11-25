//
//  MovieCacheTest.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieCacheTest.h"

@implementation MovieCacheTest

#define imageLink        @"http://cf2.imgobject.com/t/p/w185/bgSHbGEA1OM6qDs3Qba4VlSZsNG.jpg"
#define defaultImageName @"movie.png"
- (void) setUp
{
    [MovieCache clearCache];
}

- (void) testGetEmptyImageFromCache
{
    UIImage* test   = [UIImage imageNamed:defaultImageName];
    UIImage* cached = [MovieCache getImageFromCache:nil];
    
    GHAssertTrue([UIImagePNGRepresentation(test) isEqualToData:UIImagePNGRepresentation(cached)], @"Wrong image result");
}

- (void) testGetRealImageFromCache
{
    UIImage* test   = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageLink]]];
    UIImage* cached = [MovieCache getImageFromCache:imageLink];
    
    GHAssertTrue([UIImagePNGRepresentation(test) isEqualToData:UIImagePNGRepresentation(cached)], @"Wrong image result");
}

- (void)testGetRealImageFromCacheTime
{
    NSTimeInterval cached, uncached;
    NSDate* startTime = [NSDate date];
    
    UIImage* uncachedImage = [MovieCache getImageFromCache:imageLink];
    uncached = -[startTime timeIntervalSinceNow];
    
    UIImage* cachedImage = [MovieCache getImageFromCache:imageLink];
    startTime = [NSDate date];
    cached =  -[startTime timeIntervalSinceNow];
    
    GHAssertTrue([UIImagePNGRepresentation(cachedImage) isEqualToData:UIImagePNGRepresentation(uncachedImage)], @"Wrong image result");
    GHAssertTrue((cached < uncached), @"Image from cache loading faster then from Internet");
}


@end
