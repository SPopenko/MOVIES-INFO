//
//  NSStirng(MovieInfoTempolateFiling).m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSStirng(MovieInfoTemplateFiling).h"

@implementation NSString(MovieInfoTemplateFiling)

+ (NSString*) stringWithTemplateString:(NSString*)templateString filledDetailedMovieInfo:(DetailedMovieInfo*) movieInfo
{
    NSString* result = nil;
    
    return [result autorelease];
}

+ (NSDictionary*) keyFieldsFromTemplateString:(NSString*)templateString
{
    NSDictionary* result = nil;
    
    return [result autorelease];
}

+ (void) removeUnnecessaryFieldsFromDictionary:(NSMutableDictionary*)fieldsDictionary
                                    withClass:(Class) templateClass
{
    
}

+ (void) fillTemplateDictionary:(NSMutableDictionary*)fieldsDictionary 
          withDetailedMovieInfo:(DetailedMovieInfo*) movieInfo
{
    
}

+ (NSString*) replaceKeysInTemplateString:(NSString*)templateString
                     withFieldsDictionary:(NSMutableDictionary*) fieldsDictionary
{
    NSString* result = nil;
    
    return [result autorelease];
}


@end
