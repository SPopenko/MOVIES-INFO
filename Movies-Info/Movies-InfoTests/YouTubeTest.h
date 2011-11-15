//
//  YouTubeTest.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "YouTubeVideo.h"

@interface YouTubeTest : GHTestCase

- (void) testGetMovieLinkPathFromNilURL;
- (void) testGetMovieLinkPathFromRightURL;
- (void) testGetMovieLinkPathFromWrongURL;

@end
