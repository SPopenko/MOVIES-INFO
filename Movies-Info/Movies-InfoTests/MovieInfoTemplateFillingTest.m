//
//  MovieInfoTemplateFilling.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieInfoTemplateFillingTest.h"

// input keys
#define kTemplateStringInput                   @"TemplateStringInput"                   //NSString
#define kRemoveUnnecessaryFromDictionaryInput  @"RemoveUnnecessaryFromDictionaryInput"  //NSDictionary
#define kWrongFieldsDictionaryInput            @"WrongFieldsDictionaryInput"            //NSDictionary
#define kRightFieldsDictionaryInput            @"RightFieldsDictionaryInput"            //NSDictionary
#define kReplaceKeysRightFieldsDictionaryInput @"ReplaceKeysRightFieldsDictionaryInput" //NSDictionary
#define kReplaceKeysRightTemplateInput         @"ReplaceKeysRightTemplateInput"         //NSString
// result keys
#define kTemplateStringResult                  @"TemplateStringResult"                  //NSDictionary
#define kRemoveUnnecessaryFromDictionaryResult @"RemoveUnnecessaryFromDictionaryResult" //NSDictionary
#define kWrongFieldsDictionaryResult           @"WrongFieldsDictionaryResult"           //NSDictionary
#define kRightFieldsDictionaryResult           @"RightFieldsDictionaryResult"           //NSDictionary
#define kReplaceKeysRightTemplateResult        @"ReplaceKeysRightTemplateResult"        //NSString

@implementation MovieInfoTemplateFillingTest

// tests for getting key fields from template string to dictionary
- (void) test0KeyFromTemplateString_Nil
{
    GHAssertNil([NSString keyFieldsFromTemplateString:nil], @"Check conditions");
}

- (void) test0KeyFromTemplateString_Template
{
    NSString*     template = [self loadStringForKey:kTemplateStringInput];
    NSDictionary* result   = [[self loadDictionaryForKey:kTemplateStringResult] retain];
    
    [NSString keyFieldsFromTemplateString:template];
    
    GHAssertTrue([result isEqualToDictionary:[NSString keyFieldsFromTemplateString:template]], @"Check conditions");
}


// test for removing unnecessary fileds from fields dictionary
- (void) test0RemoveUnnecessaryFromDictionary_Nil
{
    NSMutableDictionary* fieldsDictionary  = nil;
    
    [NSString removeUnnecessaryFieldsFromDictionary:fieldsDictionary withClass:[DetailedMovieInfo class]];
    
    GHAssertNil(fieldsDictionary, @"Check conditions");
    
}

- (void) test0RemoveUnnecessaryFromDictionary_TemplateFields
{
    NSMutableDictionary* fieldsDictionary  = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kRemoveUnnecessaryFromDictionaryInput] retain]];
    NSMutableDictionary* resultsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kRemoveUnnecessaryFromDictionaryResult]retain]];

    [NSString removeUnnecessaryFieldsFromDictionary:fieldsDictionary withClass:[DetailedMovieInfo class]];
    
    GHAssertTrue([resultsDictionary isEqualToDictionary:fieldsDictionary], @"Check conditions");
    
    [fieldsDictionary release];
    [resultsDictionary release];
}

//tests for filling fields data with DetailedMovieInfo instance date
- (void) test0FillTemplateDictionary_Nil_WithMovieInfo_Nil
{
    NSMutableDictionary* fieldsDictionary  = nil;
    [NSString fillTemplateDictionary:nil withDetailedMovieInfo:nil];
    GHAssertNil(fieldsDictionary, @"Returned result is not nil");
}

- (void) test0FillTemplateDictionary_WTemplate_WithMovieInfo_RInfo
{
    NSMutableDictionary* fieldsDictionary  = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kWrongFieldsDictionaryInput] retain]];
    NSMutableDictionary* resultsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kWrongFieldsDictionaryResult] retain]];
    
    [NSString removeUnnecessaryFieldsFromDictionary:fieldsDictionary withClass:[DetailedMovieInfo class]];
    
    GHAssertTrue([resultsDictionary isEqualToDictionary:fieldsDictionary], @"Check conditions");
    
    [fieldsDictionary release];
    [resultsDictionary release];
    
}

- (void) test0FillTemplateDictionary_RTemplate_WithMovieInfo_RInfo
{
    NSMutableDictionary* fieldsDictionary  = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kRightFieldsDictionaryInput] retain]];
    NSMutableDictionary* resultsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kRightFieldsDictionaryResult] retain]];
    
    [NSString removeUnnecessaryFieldsFromDictionary:fieldsDictionary withClass:[DetailedMovieInfo class]];
    
    GHAssertTrue([resultsDictionary isEqualToDictionary:fieldsDictionary], @"Check conditions");
    
    [fieldsDictionary release];
    [resultsDictionary release];
}


- (void) test0ReplaceKeysInTemplate_Nil_WithDictionary_Nil
{
    NSString*     result = [NSString replaceKeysInTemplateString:nil withFieldsDictionary:nil];
    
    GHAssertNil(result, @"Result s not nil");
}

- (void) test0ReplaceKeysInTemplate_Nil_WithDictionary_RFields
{
    NSMutableDictionary* fieldsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kReplaceKeysRightFieldsDictionaryInput] retain]];
    NSString*     result = [NSString replaceKeysInTemplateString:nil withFieldsDictionary:fieldsDictionary];
    
    GHAssertNil(result, @"Result s not nil");
    
    [fieldsDictionary release];
}

- (void) test0ReplaceKeysInTemplate_RTemplate_WithDictionary_Nil
{
    NSMutableDictionary* fieldsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kReplaceKeysRightFieldsDictionaryInput] retain]];
    NSString*   template = [self loadStringForKey:kReplaceKeysRightTemplateInput];
    NSString*     result = [NSString replaceKeysInTemplateString:template withFieldsDictionary:nil];
    
    GHAssertEqualStrings(template, result, @"Check test conditions");
    
    [fieldsDictionary release];

}

- (void) test0ReplaceKeysInTemplate_RTemplate_WithDictionary_RFields
{
    NSMutableDictionary* fieldsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kReplaceKeysRightFieldsDictionaryInput] retain]];
    NSString*       template = [self loadStringForKey:kReplaceKeysRightTemplateInput];
    NSString* filledTemplate = [self loadStringForKey:kReplaceKeysRightTemplateResult];
    
    NSString*        result = [NSString replaceKeysInTemplateString:template withFieldsDictionary:fieldsDictionary];
    
    GHAssertEqualStrings(filledTemplate, result, @"Check test conditions");
    
    [fieldsDictionary release];
    
}

@end
