//
//  GHTestCase(MovieInfoFilling).h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "DetailedMovieInfo.h"

@interface GHTestCase(MovieInfoFilling)


- (DetailedMovieInfo*) filledDetailedMovieInfo;
- (DetailedMovieInfo*) filledDetailedMovieInfoWithTrailer;
- (DetailedMovieInfo*) emptyDetailedMovieInfo;

- (ShortMovieInfo*) filledShortMovieInfo;
- (ShortMovieInfo*) emptyShortMovieInfo;

- (NSArray*) arrayWithCast;
- (NSArray*) arrayWithPosters;

@end
