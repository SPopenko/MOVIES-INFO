//
//  MovieInfoTemplateFilling.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieInfoTemplateFillingTest.h"
//test image link
#define testImageLink @"http://img.yandex.net/i/www/logo.png"

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
    DetailedMovieInfo* dmi=[[DetailedMovieInfo alloc] init];
    
    [NSString fillTemplateDictionary:fieldsDictionary withDetailedMovieInfo:dmi];
    
    GHAssertNil(fieldsDictionary, @"Check conditions");
    
    [fieldsDictionary release];
    [resultsDictionary release];
}

- (void) testFillTemplateDictionary_WTemplate_WithMovieInfo_RInfo
{
    NSMutableDictionary* fieldsDictionary  = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kWrongFieldsDictionaryInput] retain]];
    NSMutableDictionary* resultsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kWrongFieldsDictionaryResult] retain]];
    DetailedMovieInfo* dmi=[[DetailedMovieInfo alloc] init];
    
            
    GHAssertThrows([NSString fillTemplateDictionary:fieldsDictionary withDetailedMovieInfo:dmi], @"Check conditions");
    
    [fieldsDictionary release];
    [resultsDictionary release];
    [dmi release];
}

- (void) testFillTemplateDictionary_RTemplate_WithMovieInfo_RInfo
{
    NSMutableDictionary* fieldsDictionary  = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kRightFieldsDictionaryInput] retain]];
    NSMutableDictionary* resultsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[self loadDictionaryForKey:kRightFieldsDictionaryResult] retain]];
    DetailedMovieInfo* dmi=[[DetailedMovieInfo alloc] init];
    NSMutableArray* temp = [[NSMutableArray alloc] init];
    //Filling DetailedMovieInfo
    dmi.movieId     = [NSString stringWithString:@"1"];
    dmi.duration    = [NSNumber numberWithInt:128];
    dmi.imagePath   = [NSString stringWithString:@"imagePath"];
    dmi.description = [NSString stringWithString:@"description"];
    dmi.movieName   = [NSString stringWithString:@"movieName"];
    dmi.fanRating   = [NSNumber numberWithFloat:8.8f];
    dmi.releaseDate = [NSDate dateWithTimeIntervalSince1970:0.0f];
    //Creating Cast
    for (int i =1;i < 5; i++)
    {
        Person* pers = [[Person alloc] init];
        pers.name = [NSString stringWithFormat:@"%d", i];
        [temp addObject:pers];
        [pers release];
    }
    dmi.cast = [temp subarrayWithRange:NSMakeRange(0, temp.count)];
    [temp removeAllObjects];
    
    //Creating posters
    for (int i = 0; i < 13; i++) 
    {
        Poster* poster = [[Poster alloc] init];
        Image*  image  = [[Image alloc] init];
        if (i%2) 
        {
            image.size = [NSString stringWithString:@"thumb"];
        }
        else
        {
            image.size = [NSString stringWithString:@"cover"];
        }
        
        if (i < 7)
        {
            image.type = [NSString stringWithString:@"poster"];
        }
        else
        {
            image.type = [NSString stringWithString:@"backdrop"];
        }
        image.url = [NSString stringWithString:testImageLink];
        poster.image = image;
        [temp addObject:poster];
        [poster release];
        [image release];
    }
    dmi.posters = [temp subarrayWithRange:NSMakeRange(0, temp.count)];
    [temp removeAllObjects];
    
    //Creating backdrops
    for (int i = 0; i < 13; i++) 
    {
        Poster* poster = [[Poster alloc] init];
        Image*  image  = [[Image alloc] init];
        if (i%2) 
        {
            image.size = [NSString stringWithString:@"thumb"];
        }
        else
        {
            image.size = [NSString stringWithString:@"cover"];
        }
        
        if (i < 7)
        {
            image.type = [NSString stringWithString:@"poster"];
        }
        else
        {
            image.type = [NSString stringWithString:@"backdrop"];
        }
        image.url = [NSString stringWithString:testImageLink];
        poster.image = image;
        [temp addObject:poster];
        [poster release];
        [image release];
    }
    dmi.backdrops = [temp subarrayWithRange:NSMakeRange(0, temp.count)];
    [temp removeAllObjects];

    [NSString fillTemplateDictionary:fieldsDictionary withDetailedMovieInfo:dmi];

    GHAssertTrue([resultsDictionary isEqualToDictionary:fieldsDictionary], @"Check conditions");

    [temp release];
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
