//
//  MovieInfo.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Block.h>

#import <RestKit/RestKit.h>
#import <RestKit/Support/JSON/JSONKit/JSONKit.h>
#import <RestKit/Support/JSON/JSONKit/RKJSONParserJSONKit.h>

#import "ShortMovieInfo.h"
#import "DetailedMovieInfo.h"

typedef void(^finishAction)(id obj);

@interface MovieInfo : NSObject<RKObjectLoaderDelegate>
{
    NSArray*  _movieList;
    BOOL      _goNext;
    NSString* _type;
    finishAction _finishAction;
}

- (void) getShortMovieInfoWithParameters:(NSDictionary*) parameters doAfterLoadFinished:(finishAction) doBlock;
- (void) getDetailedMovieInfoByMovieID:(NSString*)movieID doAfterLoadFinished:(finishAction) doBlock;

//
- (NSString*)            requestStringFromMutableDictionary:(NSMutableDictionary*) parameters;
- (NSMutableDictionary*) prepareParametersFromDictionary:(NSDictionary*) parameters;

- (RKObjectMapping*) shortMovieInfoMapping;
- (RKObjectMapping*) detailedMovieInfoMapping;
- (void) initRestKit;
@end