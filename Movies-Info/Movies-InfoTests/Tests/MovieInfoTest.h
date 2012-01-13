//
//  MovieInfoTests.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

#import "GHTestCase(ResultsFromFile).h"
#import "MovieInfo.h"

@interface MovieInfo(testCategory)

- (NSString*) requestStringFromMutableDictionary:(NSMutableDictionary *)parameters;
- (NSMutableDictionary*) prepareParametersFromDictionary:(NSDictionary *)parameters;
- (NSString*) requestStringFromSearchString:(NSString*) searchString;

@end


@interface MovieInfoTest : GHTestCase
{
    MovieInfo* _movieInfo;
}

- (void) testPrepareParametersFromDictionary_Nil;
- (void) testPrepareParametersFromDictionary_NotFullDictionary;
- (void) testPrepareParametersFromDictionary_FullDictionary;

- (void) testRequestStringFromMutableDictionary_Nil;
- (void) testRequestStringFromMutableDictionary_NotFullDictionary;
- (void) testRequestStringFromMutableDictionary_FullDictionary;
- (void) testRequestStringFromMutableDictionary_OverFullDictionary;

- (void) testRequestStringFromSearchString_Nil;
- (void) testRequestStringFromSearchString_OnlyLetters;
- (void) testRequestStringFromSearchString_SpecialSymbol;

@end
