//
//  MovieInfoTemplateFilling.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

#import "GHTestCase(ResultsFromFile).h"
#import "NSStirng(MovieInfoTemplateFiling).h"
#import "DetailedMovieInfo.h"

@interface MovieInfoTemplateFillingTest : GHTestCase

- (void) test0KeyFromTemplateString_Nil;
- (void) test0KeyFromTemplateString_Template;

- (void) test0RemoveUnnecessaryFromDictionary_Nil;
- (void) test0RemoveUnnecessaryFromDictionary_TemplateFields;

- (void) test0FillTemplateDictionary_Nil_WithMovieInfo_Nil;
- (void) test0FillTemplateDictionary_WTemplate_WithMovieInfo_RInfo;
- (void) test0FillTemplateDictionary_RTemplate_WithMovieInfo_RInfo;

- (void) test0ReplaceKeysInTemplate_Nil_WithDictionary_Nil;
- (void) test0ReplaceKeysInTemplate_Nil_WithDictionary_RFields;
- (void) test0ReplaceKeysInTemplate_RTemplate_WithDictionary_Nil;
- (void) test0ReplaceKeysInTemplate_RTemplate_WithDictionary_RFields;


@end
