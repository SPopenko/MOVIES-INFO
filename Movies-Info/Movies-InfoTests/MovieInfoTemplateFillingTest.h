//
//  MovieInfoTemplateFilling.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

#import "NSStirng(MovieInfoTemplateFiling).h"
#import "DetailedMovieInfo.h"

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
