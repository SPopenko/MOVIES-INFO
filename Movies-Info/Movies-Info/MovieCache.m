//
//  MovieCache.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieCache.h"

@implementation MovieCache

#define movieWithoutPoster @""

+ (void) initImageList
{
    if (_imageList == nil)
    {
        _imageList = [[NSMutableDictionary alloc] init];
        [_imageList setObject:[UIImage imageNamed:@"movie"] forKey:movieWithoutPoster];
    }
}


+(void) clearCache
{
    [self initImageList];
    [_imageList removeAllObjects];
}

+(UIImage*) getImageFromCache:(NSString*)imageUrl
{
    UIImage* result;
    [self initImageList];
    if (imageUrl == nil )
    {
        imageUrl = movieWithoutPoster;
    }
    result = (UIImage*) [_imageList objectForKey:imageUrl];
    if (result == nil)
    {
        NSData* imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageUrl]];
        result = [UIImage imageWithData: imageData];
        [_imageList  setObject:result forKey:imageUrl];
        [imageData release];
    }
    return  result;
}


- (void) dealloc
{
    [_imageList release];
    [super dealloc];
}
@end
