//
//  YouTubeTest.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import <OCMock/OCMock.h>
#import <OCMock/OCMockObject.h>

#import "GHTestCase(ResultsFromFile).h"

#import "YouTubeVideo.h"
#import "YouTubeVideo+GetMovieLinkStub.h"

@interface YouTubeTest : GHTestCase
{
    id mock;
    YouTubeVideo* youTubeVideo;
}

- (void) testGetMovieLinkPath_NilURL;
- (void) testGetMovieLinkPath_RightURL;
- (void) testGetMovieLinkPath_WrongURL;

- (void) testGetBlockWithMoviePathes_Nil;
- (void) testGetBlockWithMoviePathes_WithPathes;
- (void) testGetBlockWithMoviePathes_WithoutPathes;

- (void) testReplaceEscapedCharacters_Nil;
- (void) testReplaceEscapedCharacters_WithChars;
- (void) testReplaceEscapedCharacters_WithoutChars;

- (void) testGetMoviePathFromPageBlock_Nil;
- (void) testGetMoviePathFromPageBlock_WithPathes;
- (void) testGetMoviePathFromPageBlock_WithoutPathes;

@end
