//
//  ShortMovieInfoTest.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ShortMovieInfoTest.h"

@implementation ShortMovieInfoTest

//result keys
#define kgetPoster_EmptyPosterResult @"GetPoster_EmptyPosterResult"
#define kgetPoster_WithPosterResult  @"GetPoster_WithPosterResult"

- (void) testGetPoster_EmptyMovieInfo
{
    ShortMovieInfo* smi = [self emptyShortMovieInfo];
    
    GHAssertNil(smi.poster, @"Resul is not nil");

}

- (void) testGetPoster_EmptyPoster
{    
    ShortMovieInfo* smi = [self filledShortMovieInfo];
    smi.posters = [[NSArray alloc] init];
    
    GHAssertNil(smi.poster, @"Result is not nil");
}

- (void) testGetPoster_WithPoster
{
    ShortMovieInfo* smi    = [self filledShortMovieInfo];
    NSString*       result = [self loadStringForKey:kgetPoster_WithPosterResult];
    
    GHAssertEqualStrings(smi.poster, result, @"Check test conditions");
}

//- (void) testGetPosterWithEmptyPosters
//{
//    NSArray* posters   = [[NSArray alloc] init];
//    testObject.posters = posters;
//    GHAssertNil(testObject.poster, @"Result is not nil");
//    [posters release];
//}
//
//
//- (void) testGetPosterMovieInfoWithPosters
//{
//    NSMutableArray* posters = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i < 5; i++) {
//        Image*  i = [[Image alloc] init];
//        Poster* p = [[Poster  alloc] init];
//        i.url = [[NSString alloc] initWithFormat:@"url%d", 0];
//        i.type = @"poster";
//        i.size = @"cover";
//        p.image = i;
//        [posters addObject:p];
//    }
//    
//    [posters writeToFile:@"/Users/apolub/Documents/file.plist" atomically:YES];
//    
//    testObject.posters = posters;
//    GHAssertEqualStrings(@"url0", testObject.poster, @"Result is not nil");
//    [posters release];
//}
//
//- (void) testGetPosterMovieInfoWithPostersWithoutCover
//{
//    NSMutableArray* posters = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i < 5; i++) {
//        Image*  i = [[Image alloc] init];
//        Poster* p = [[Poster  alloc] init];
//        i.url = [[NSString alloc] initWithFormat:@"url%d", 0];
//        i.type = @"posters";
//        i.size = @"thumb";
//        p.image = i;
//        [posters addObject:p];
//    }
//    
//    [posters writeToFile:@"/Users/apolub/Documents/file.plist" atomically:YES];
//    
//    testObject.posters = posters;
//    GHAssertNil(testObject.poster, @"Result is not nil");
//    [posters release];
//}

- (void) dealloc
{
    [testObject release];
    [_movieInfo release];
    [super dealloc];
}

@end
