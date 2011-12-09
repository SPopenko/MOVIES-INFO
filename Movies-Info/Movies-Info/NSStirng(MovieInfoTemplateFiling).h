//
//  NSStirng(MovieInfoTempolateFiling).h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DetailedMovieInfo.h"

@interface NSString(MovieInfoTemplateFiling)

+ (NSString*) stringWithTemplateString:(NSString*)templateString filledDetailedMovieInfo:(DetailedMovieInfo*) movieInfo;

+ (NSDictionary*) keyFieldsFromTemplateString:(NSString*)templateString;
+ (void) removeUnnecessaryFieldsFromDictionary:(NSMutableDictionary*)fieldsDictionary
                                    withClass:(Class) templateClass;
+ (void) fillTemplateDictionary:(NSMutableDictionary*)fieldsDictionary 
          withDetailedMovieInfo:(DetailedMovieInfo*) movieInfo;
+ (NSString*) replaceKeysInTemplateString:(NSString*)templateString
                     withFieldsDictionary:(NSMutableDictionary*) fieldsDictionary;

@end
