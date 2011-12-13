//
//  GHTestCase(ResultsFromFile).m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GHTestCase(ResultsFromFile).h"

@implementation GHTestCase(ResultsFromFile)

- (NSString*) loadStringForKey:(NSString *)key
{
    NSDictionary* testResults = [self dictionaryWithValues];
    NSString* result = nil;
    
    result  = [[NSString stringWithFormat:@"%@", [testResults objectForKey:key]] retain];

    return [result autorelease];
}

- (NSArray*) loadArrayForKey:(NSString *)key
{
    NSDictionary* testResults = [self dictionaryWithValues];
    NSArray*      result = nil;
    
    result = [testResults objectForKey:key];
        
    return [result autorelease];
}

- (NSDictionary*) loadDictionaryForKey:(NSString *)key
{
    NSDictionary* testResults = [self dictionaryWithValues];
    NSDictionary*      result = nil;
    
    result = [testResults objectForKey:key];
    
    return [result autorelease];
}

- (NSDictionary*) dictionaryWithValues
{
    NSDictionary* result = nil;
    //Creating path to file with results based on test class name
    NSString* className   = [[NSString alloc] initWithUTF8String:object_getClassName(self)];
    NSString* resultsPath = [[NSBundle mainBundle] pathForResource:className ofType:@"plist"];
    
    result = [[NSDictionary dictionaryWithContentsOfFile:resultsPath] retain];

    return [result autorelease];
}



@end
