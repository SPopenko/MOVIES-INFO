//
//  YouTubeTest.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


#import "YouTubeTest.h"

@implementation YouTubeTest
#define kwrongURL @"http://www.ya.ru"
#define krightURL @"http://www.youtube.com/watch?v=QYLLFpNn4lM"

//test results keys
#define kgetMovieLinkPathFromURL_right @""
#define kgetBlockWithMoviePathes @"testGetBlockWithMoviePathes_withPathesResult"
#define kreplaceEscapedCharacters_rightResult  @"testReplaceEscapedCharacters_rightResult"
#define kreplaceEscapedCharacters_wrongResult  @"testReplaceEscapedCharacters_wrongResult"
#define kgetMoviePathFromPageBlock_rightResult @"testGetMoviePathFromPageBlock_rightResult"

//Keys for input values
#define krightPageBlock @"rightPageBlock"
#define kwrongPageBlock @"wrongPageBlock"
#define kreplaceEscapedCharacters_rightInput  @"testReplaceEscapedCharacters_rightInput"
#define kreplaceEscapedCharacters_wrongInput  @"testReplaceEscapedCharacters_wrongInput"
#define kgetMoviePathFromPageBlock_rightInput @"testGetMoviePathFromPageBlock_rightInput"
//Setting up 
- (void) setUp
{
    mock = [OCMockObject mockForClass:[YouTubeVideo class]];
    youTubeVideo = [[[YouTubeVideo alloc] init] retain];
}

- (void) tearDown
{
    [youTubeVideo release];
}

#pragma mark - Integration tests
//Integration test methods
- (void) testGetMovieLinkPath_NilURL
{
    NSString* result = nil;
    result = [youTubeVideo getMoviePathFromLink:nil];
    GHAssertNil(result, @"Movie path is not nil" );
}

- (void) testGetMovieLinkPath_RightURL
{
    [[[mock stub] andReturn:[self loadStringForKey:kgetMovieLinkPathFromURL_right]] getPageContentsOfURL:krightURL];
    NSString* result = [youTubeVideo getMoviePathFromLink:krightURL];
    GHAssertNotNil(result, @"Movie path is nil");
}

- (void) testGetMovieLinkPath_WrongURL
{
    [[[mock stub] andReturn:nil] getPageContentsOfURL:kwrongURL];
    GHAssertNil([youTubeVideo getMoviePathFromLink:kwrongURL] , @"Movie path is not nil" );
}

#pragma mark - testGetBlockWithMoviePathes
- (void) testGetBlockWithMoviePathes_Nil
{
    GHAssertNil([youTubeVideo getBlockWithMoviePathesFromPage:nil], @"Returned result is not nil");
}

- (void) testGetBlockWithMoviePathes_WithPathes
{
    GHAssertEqualStrings([youTubeVideo getBlockWithMoviePathesFromPage:[self loadStringForKey:krightPageBlock]],
                         [self loadStringForKey:kgetBlockWithMoviePathes],
                         nil);
}

- (void) testGetBlockWithMoviePathes_WithoutPathes
{
    GHAssertNil([youTubeVideo getBlockWithMoviePathesFromPage:[self loadStringForKey:kwrongPageBlock]],
                @"Returned result is not nil");
}

#pragma mark - testReplaceEscapedSymbols
- (void) testReplaceEscapedCharacters_Nil
{
    GHAssertNil([youTubeVideo replaceEscapedSymbols:nil], @"Result is not nil" );
}

- (void) testReplaceEscapedCharacters_WithChars
{
    GHAssertEqualStrings([self loadStringForKey:kreplaceEscapedCharacters_rightResult],
                         [youTubeVideo replaceEscapedSymbols:[self loadStringForKey:kreplaceEscapedCharacters_rightInput]], 
                         @"Check test conditions");
}

- (void) testReplaceEscapedCharacters_WithoutChars;
{
    GHAssertEqualStrings([self loadStringForKey:kreplaceEscapedCharacters_wrongResult],
                         [youTubeVideo replaceEscapedSymbols:[self loadStringForKey:kreplaceEscapedCharacters_wrongInput]], 
                          @"Check test conditions");
}

#pragma mark - testGetMoviePathFromPageBlock
- (void) testGetMoviePathFromPageBlock_Nil
{
    GHAssertNil([youTubeVideo getMoviePathFromPageBlock:nil], @"Result is not nil");
}

- (void) testGetMoviePathFromPageBlock_WithPathes
{
    GHAssertEqualStrings([self loadStringForKey:kgetMoviePathFromPageBlock_rightResult],
                         [youTubeVideo getMoviePathFromPageBlock:[self loadStringForKey:kgetMoviePathFromPageBlock_rightInput]], 
                         @"Check test conditions");
}

- (void) testGetMoviePathFromPageBlock_WithoutPathes
{
    GHAssertNil([youTubeVideo getMoviePathFromPageBlock:nil], @"Result is not nil");
}


@end
