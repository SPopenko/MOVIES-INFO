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
    NSDictionary* testResults = nil;
    NSString*     resultsPath = nil;
    
    //Creating path to file with results based on test class name
    NSString* className = [[NSString alloc] initWithUTF8String:object_getClassName(self)];
    NSString* fileName  = [[NSString alloc] initWithFormat:@"%@Results", className];
    resultsPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];

    testResults = [[NSDictionary dictionaryWithContentsOfFile:resultsPath] retain];
    NSString* result = nil;
    result  = [[NSString stringWithFormat:@"%@", [testResults objectForKey:key]] retain];
    
    [fileName    release];
    [className   release];
    //[resultsPath release];
    [testResults release];
    
    fileName    = nil;
    className   = nil;
    resultsPath = nil;
    testResults = nil;
    
    [result autorelease];
    return result;
}

@end
