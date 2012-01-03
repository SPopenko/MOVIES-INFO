//
//  MovieCacheTest.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieCacheTest.h"

@implementation MovieCache(testCategory)
#define internetImageName @"logo.png"

+ (UIImage*) addImageToCacheFromUrl:(NSString *)imageUrl
{
    UIImage* result = [UIImage imageNamed:internetImageName];
    return result;
}

@end

@implementation MovieCacheTest

#define imageLink         @"http://cf2.imgobject.com/t/p/w185/bgSHbGEA1OM6qDs3Qba4VlSZsNG.jpg"
#define defaultImageName  @"movie.png"

- (void) setUp
{
    [MovieCache clearCache];
}

- (void) testGetImageFromCache_Empty
{
    UIImage* test   = [UIImage imageNamed:defaultImageName];
    UIImage* cached = [MovieCache getImageFromCache:nil];
    
    GHAssertTrue([UIImagePNGRepresentation(test) isEqualToData:UIImagePNGRepresentation(cached)], @"Wrong image result");
}

- (void) testGetImageFromCache_Real
{
    UIImage* test   = [UIImage imageNamed:internetImageName];
    UIImage* cached = [MovieCache getImageFromCache:imageLink];
    GHAssertTrue([UIImagePNGRepresentation(test) isEqualToData:UIImagePNGRepresentation(cached)], @"Wrong image result");
}



@end
