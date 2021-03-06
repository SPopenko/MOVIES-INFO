//
//  MovieInfoTemplateFilling.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieInfoTemplateFillingTest.h"

@implementation NSString(testMovieInfoFillingPrivate)

+ (NSMutableDictionary*) keyFieldsFromTemplateString:(NSString*)templateString{ return nil;}
+ (void) removeUnnecessaryFieldsFromDictionary:(NSMutableDictionary*)fieldsDictionary
                                     withClass:(Class) templateClass{}
+ (void) fillTemplateDictionary:(NSMutableDictionary*)fieldsDictionary 
          withDetailedMovieInfo:(DetailedMovieInfo*) movieInfo{}
+ (NSString*) replaceKeysInTemplateString:(NSString*)templateString
                     withFieldsDictionary:(NSMutableDictionary*) fieldsDictionary{return nil;}

@end

@implementation MovieInfoTemplateFillingTest

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

//private method testing



// tests for getting key fields from template string to dictionary
- (void) testKeyFromTemplateString_Nil
{
    GHAssertNil([NSString keyFieldsFromTemplateString:nil], @"Check conditions");
}

- (void) testKeyFromTemplateString_Template
{
    NSString*     template = [[self loadStringForKey:kTemplateStringInput] retain];
    NSMutableDictionary* result   = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kTemplateStringResult] retain]];
    NSMutableDictionary* fields = nil;
    
    
    
    fields = [NSString keyFieldsFromTemplateString:template];
    GHAssertTrue([result isEqualToDictionary:fields], @"Check conditions");
}


// test for removing unnecessary fileds from fields dictionary
- (void) testRemoveUnnecessaryFromDictionary_Nil
{
    NSMutableDictionary* fieldsDictionary  = nil;
    
    [NSString removeUnnecessaryFieldsFromDictionary:fieldsDictionary withClass:[DetailedMovieInfo class]];
    
    GHAssertNil(fieldsDictionary, @"Check conditions");
    
}

- (void) testRemoveUnnecessaryFromDictionary_TemplateFields
{
    NSMutableDictionary* fieldsDictionary  = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kRemoveUnnecessaryFromDictionaryInput] retain]];
    NSMutableDictionary* resultsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kRemoveUnnecessaryFromDictionaryResult]retain]];

    [NSString removeUnnecessaryFieldsFromDictionary:fieldsDictionary withClass:[DetailedMovieInfo class]];
    
    GHAssertTrue([resultsDictionary isEqualToDictionary:fieldsDictionary], @"Check conditions");
    
    [fieldsDictionary release];
    [resultsDictionary release];
}

//tests for filling fields data with DetailedMovieInfo instance date
- (void) testFillTemplateDictionary_Nil_WithMovieInfo_Nil
{
    NSMutableDictionary* fieldsDictionary  = nil;
    NSMutableDictionary* resultsDictionary = nil;
    DetailedMovieInfo* dmi = nil;
    
    [NSString fillTemplateDictionary:fieldsDictionary withDetailedMovieInfo:dmi];
    
    GHAssertNil(fieldsDictionary, @"Check conditions");
    
    [fieldsDictionary release];
    [resultsDictionary release];
}

- (void) testFillTemplateDictionary_WTemplate_WithMovieInfo_RInfo
{
    NSMutableDictionary* fieldsDictionary  = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kWrongFieldsDictionaryInput] retain]];
    NSMutableDictionary* resultsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kWrongFieldsDictionaryResult] retain]];
    DetailedMovieInfo* dmi = [self filledDetailedMovieInfo];
                
    GHAssertThrows([NSString fillTemplateDictionary:fieldsDictionary withDetailedMovieInfo:dmi], @"Check conditions");
    
    [fieldsDictionary release];
    [resultsDictionary release];
}

- (void) testFillTemplateDictionary_RTemplate_WithMovieInfo_RInfo
{
    NSMutableDictionary* fieldsDictionary  = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kRightFieldsDictionaryInput] retain]];
    NSMutableDictionary* resultsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kRightFieldsDictionaryResult] retain]];
    DetailedMovieInfo* dmi = [self filledDetailedMovieInfo];

    [NSString fillTemplateDictionary:fieldsDictionary withDetailedMovieInfo:dmi];

    GHAssertTrue([resultsDictionary isEqualToDictionary:fieldsDictionary], @"Check conditions");

    [fieldsDictionary release];
    [resultsDictionary release];
}

- (void) testReplaceKeysInTemplate_Nil_WithDictionary_Nil
{
    NSString*     result = [NSString replaceKeysInTemplateString:nil withFieldsDictionary:nil];
    
    GHAssertNil(result, @"Result s not nil");
}

- (void) testReplaceKeysInTemplate_Nil_WithDictionary_RFields
{
    NSMutableDictionary* fieldsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kReplaceKeysRightFieldsDictionaryInput] retain]];
    NSString*     result = [NSString replaceKeysInTemplateString:nil withFieldsDictionary:fieldsDictionary];
    
    GHAssertNil(result, @"Result s not nil");
    
    [fieldsDictionary release];
}

- (void) testReplaceKeysInTemplate_RTemplate_WithDictionary_Nil
{
    NSMutableDictionary* fieldsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kReplaceKeysRightFieldsDictionaryInput] retain]];
    NSString*   template = [self loadStringForKey:kReplaceKeysRightTemplateInput];
    NSString*     result = [NSString replaceKeysInTemplateString:template withFieldsDictionary:nil];
    
    GHAssertEqualStrings(template, result, @"Check test conditions");
    
    [fieldsDictionary release];

}

- (void) testReplaceKeysInTemplate_RTemplate_WithDictionary_RFields
{
    NSMutableDictionary* fieldsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kReplaceKeysRightFieldsDictionaryInput] retain]];
    NSString*       template = [self loadStringForKey:kReplaceKeysRightTemplateInput];
    NSString* filledTemplate = [self loadStringForKey:kReplaceKeysRightTemplateResult];
    
    NSString*        result = [NSString replaceKeysInTemplateString:template withFieldsDictionary:fieldsDictionary];
    
    GHAssertEqualStrings(filledTemplate, result, @"Check test conditions");
    
    [fieldsDictionary release];
    
}

@end
