//
//  YouTubeVideo.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YouTubeVideo : NSObject

//main class function
- (NSString*) getMoviePathFromLink:(NSString*)youTubeLink;

- (NSString*) getPageContentsOfURL:(NSString*) pageURL;
- (NSString*) getBlockWithMoviePathesFromPage:(NSString*) htmlPage;
- (NSString*) replaceEscapedSymbols:(NSString*) pageURL;
- (NSString*) getMoviePathFromPageBlock:(NSString *)youTubeLink;

@end

