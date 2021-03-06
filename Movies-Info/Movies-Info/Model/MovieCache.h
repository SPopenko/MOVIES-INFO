//
//  MovieCache.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShortMovieInfo.h"

@interface MovieCache : NSObject

+ (void) clearCache;
+ (UIImage*) getImageFromCache:(NSString*) imageUrl;

@end
