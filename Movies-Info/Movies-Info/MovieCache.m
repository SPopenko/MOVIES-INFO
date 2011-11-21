//
//  MovieCache.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieCache.h"

@implementation MovieCache

static NSMutableDictionary* _imageList;
//static NSString* movieWithoutPoster;
#define movieWithoutPoster @""
+ (void) initImageList
{
    /*if (movieWithoutPoster == nil) {
        movieWithoutPoster = [NSString stringWithString:@""];
    }*/
    
    if (_imageList == nil)
    {
        _imageList = [[NSMutableDictionary alloc] init];
    }
    
    UIImage* moviePoster = (UIImage*)[_imageList objectForKey:movieWithoutPoster];
    if (moviePoster == nil) {
        moviePoster = [ UIImage imageNamed:@"movie.png"];
        [_imageList setObject:moviePoster forKey:movieWithoutPoster];
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
        result = [self addImageToCacheFromUrl:imageUrl];
    }
    return  result;
}

+ (UIImage*) addImageToCacheFromUrl:(NSString *)imageUrl
{
    NSData* imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageUrl]];
    UIImage* result = [UIImage imageWithData: imageData];
    [_imageList  setObject:result forKey:imageUrl];
    [imageData release];
    return result;
}
+ (void) preloadImagesFromShortMovieInfoList:(NSArray *)movieList
{
    for (NSUInteger i = 0; i < movieList.count; i++) 
    {
        ShortMovieInfo* movieInfo = [movieList objectAtIndex:i];
        //load poster to cache
        [self addImageToCacheFromUrl:movieInfo.poster];
    }
}

- (void) dealloc
{
    [_imageList release];
    [movieWithoutPoster release];
    [super dealloc];
}
@end
