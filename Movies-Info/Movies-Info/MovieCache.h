//
//  MovieCache.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShortMovieInfo.h"

static NSMutableDictionary* _imageList;

@interface MovieCache : NSObject

+ (void) clearCache;
+ (void) initImageList;
+ (void) preloadImagesFromShortMovieInfoList:(NSArray*) movieList;
+ (UIImage*) addImageToCacheFromUrl:(NSString*) imageUrl;
+ (UIImage*) getImageFromCache:(NSString*) imageUrl;

@end
