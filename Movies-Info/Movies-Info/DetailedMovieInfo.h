//
//  DetailedMovieInfo.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 10/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDataAdditions.h"
#import "ShortMovieInfo.h"
#import "MovieCache.h"
#import "YouTubeVideo.h"

@interface Person : NSObject
@property (nonatomic, retain) NSString* name;
@end

@interface DetailedMovieInfo : ShortMovieInfo

@property (nonatomic, retain) NSArray*  cast;
@property (nonatomic, retain) NSArray*  backdrops;
@property (nonatomic, retain) NSString* description;
@property (nonatomic, retain, getter = getTrailer, setter = setTrailer:) NSString* trailer;

- (NSString*) getTrailer;
- (void) setTrailer:(NSString *)trailerLink;

- (NSMutableString*) fillHtmlPage:(NSMutableString*)htmlPage;

- (NSString*) backdropsToHtmlString;
- (NSString*) castToHtmlString;
- (NSString*) htmlStringFromImageAtKey:(NSString*) imagekey;

@end
