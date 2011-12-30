//
//  MovieInfoTests.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieInfoTest.h"

@implementation MovieInfoTest
//input keys
#define kprepareParametersFromDictionary_NilInput               @"PrepareParametersFromDictionary_NilInput"               //NSDictionary no dict in test.plist
#define kprepareParametersFromDictionary_NotFullDictionaryInput @"PrepareParametersFromDictionary_NotFullDictionaryInput" //NSDictionary
#define kprepareParametersFromDictionary_FullDictionaryInput    @"PrepareParametersFromDictionary_FullDictionaryInput"    //NSDictionary

#define krequestStringFromMutableDictionary_NilInput                @"RequestStringFromMutableDictionary_NilInput"                //NSDictionary no dict in test.plist
#define krequestStringFromMutableDictionary_NotFullDictionaryInput  @"RequestStringFromMutableDictionary_NotFullDictionaryInput"  //NSDictionary
#define krequestStringFromMutableDictionary_FullDictionaryInput     @"RequestStringFromMutableDictionary_FullDictionaryInput"     //NSDictionary
#define krequestStringFromMutableDictionary_OverFullDictionaryInput @"RequestStringFromMutableDictionary_OverFullDictionaryInput" //NSDictionary

//result keys  
#define kprepareParametersFromDictionary_NilResult               @"PrepareParametersFromDictionary_NilResult"               //NSDictionary 
#define kprepareParametersFromDictionary_NotFullDictionaryResult @"PrepareParametersFromDictionary_NotFullDictionaryResult" //NSDictionary
#define kprepareParametersFromDictionary_FullDictionaryResult    @"PrepareParametersFromDictionary_FullDictionaryResult"    //NSDictionary

#define krequestStringFromMutableDictionary_NilResult                @"RequestStringFromMutableDictionary_NilResult"                //NSDictionary
#define krequestStringFromMutableDictionary_NotFullDictionaryResult  @"RequestStringFromMutableDictionary_NotFullDictionaryResult"  //NSDictionary
#define krequestStringFromMutableDictionary_FullDictionaryResult     @"RequestStringFromMutableDictionary_FullDictionaryResult"     //NSDictionary
#define krequestStringFromMutableDictionary_OverFullDictionaryResult @"RequestStringFromMutableDictionary_OverFullDictionaryResult" //NSDictionary

- (void) setUp
{
    _movieInfo = nil;
    
    _movieInfo = [[MovieInfo alloc] init];
}

- (void) tearDown
{
    //[_movieInfo release];
    _movieInfo = nil;
}
- (void) testPrepareParametersFromDictionaryWithInput:(NSString*)input andResult:(NSString*)result
{
    NSDictionary* paramDict = [[self loadDictionaryForKey:input] retain];
    NSMutableDictionary* preparedMDict = [[_movieInfo prepareParametersFromDictionary:paramDict] retain];
    NSDictionary* resultDict = [[self loadDictionaryForKey:result] retain];
    NSMutableDictionary* resultMDict   = [[NSMutableDictionary alloc] initWithDictionary:resultDict];

    GHAssertTrue([preparedMDict isEqualToDictionary:resultMDict], @"Check test conditions");

}

- (void) testRequestStringFromMutableDictionaryWithInput:(NSString*)input andResult:(NSString*)result
{
    NSDictionary*        paramsDict    = [[self loadDictionaryForKey:input] retain];
    NSMutableDictionary* paramsMDict   = [[[NSMutableDictionary alloc] initWithDictionary:paramsDict] retain];
    NSString*            requestString = [[_movieInfo requestStringFromMutableDictionary:paramsMDict] retain];
    NSString*            resultString  = [[self loadStringForKey:result] retain];
    
    GHAssertEqualStrings(requestString, resultString, @"Check test conditions");
    
}

- (void) testPrepareParametersFromDictionary_Nil
{
    [self testPrepareParametersFromDictionaryWithInput:kprepareParametersFromDictionary_NilInput andResult:kprepareParametersFromDictionary_NilResult];
}

- (void) testPrepareParametersFromDictionary_NotFullDictionary
{
    [self testPrepareParametersFromDictionaryWithInput:kprepareParametersFromDictionary_NotFullDictionaryInput
                                             andResult:kprepareParametersFromDictionary_NotFullDictionaryResult];   
}
                 
- (void) testPrepareParametersFromDictionary_FullDictionary
{
    [self testPrepareParametersFromDictionaryWithInput:kprepareParametersFromDictionary_NotFullDictionaryInput
                                             andResult:kprepareParametersFromDictionary_NotFullDictionaryResult];   
}

- (void) testRequestStringFromMutableDictionary_Nil
{
     [self testRequestStringFromMutableDictionaryWithInput:krequestStringFromMutableDictionary_NilInput
                                                 andResult:krequestStringFromMutableDictionary_NilResult];
}

- (void) testRequestStringFromMutableDictionary_NotFullDictionary
{
    [self testRequestStringFromMutableDictionaryWithInput:krequestStringFromMutableDictionary_NotFullDictionaryInput
                                                andResult:krequestStringFromMutableDictionary_NotFullDictionaryResult];
}

- (void) testRequestStringFromMutableDictionary_FullDictionary;
{
    [self testRequestStringFromMutableDictionaryWithInput:krequestStringFromMutableDictionary_FullDictionaryInput
                                                andResult:krequestStringFromMutableDictionary_FullDictionaryResult];
}

- (void) testRequestStringFromMutableDictionary_OverFullDictionary;
{
    [self testRequestStringFromMutableDictionaryWithInput:krequestStringFromMutableDictionary_OverFullDictionaryInput
                                                andResult:krequestStringFromMutableDictionary_OverFullDictionaryResult];
}
     
- (void) dealloc
{
    [_movieInfo release];
    [super dealloc];
}
     

@end
