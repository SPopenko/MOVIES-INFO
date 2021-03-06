//
//  MovieInfoTemplateFilling.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

#import "GHTestCase(ResultsFromFile).h"
#import "GHTestCase(MovieInfoFilling).h"
#import "NSString(MovieInfoTemplateFilling).h"
#import "DetailedMovieInfo.h"

@interface NSString(testMovieInfoFillingPrivate)

+ (NSMutableDictionary*) keyFieldsFromTemplateString:(NSString*)templateString;
+ (void) removeUnnecessaryFieldsFromDictionary:(NSMutableDictionary*)fieldsDictionary
                                     withClass:(Class) templateClass;
+ (void) fillTemplateDictionary:(NSMutableDictionary*)fieldsDictionary 
          withDetailedMovieInfo:(DetailedMovieInfo*) movieInfo;
+ (NSString*) replaceKeysInTemplateString:(NSString*)templateString
                     withFieldsDictionary:(NSMutableDictionary*) fieldsDictionary;

@end


@interface MovieInfoTemplateFillingTest : GHTestCase

- (void) testKeyFromTemplateString_Nil;
- (void) testKeyFromTemplateString_Template;

- (void) testRemoveUnnecessaryFromDictionary_Nil;
- (void) testRemoveUnnecessaryFromDictionary_TemplateFields;

- (void) testFillTemplateDictionary_Nil_WithMovieInfo_Nil;
- (void) testFillTemplateDictionary_WTemplate_WithMovieInfo_RInfo;
- (void) testFillTemplateDictionary_RTemplate_WithMovieInfo_RInfo;

- (void) testReplaceKeysInTemplate_Nil_WithDictionary_Nil;
- (void) testReplaceKeysInTemplate_Nil_WithDictionary_RFields;
- (void) testReplaceKeysInTemplate_RTemplate_WithDictionary_Nil;
- (void) testReplaceKeysInTemplate_RTemplate_WithDictionary_RFields;


@end
