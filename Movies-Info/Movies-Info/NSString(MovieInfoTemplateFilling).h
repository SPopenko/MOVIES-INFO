//
//  NSString(MovieInfoTempolateFilling).h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <objc/runtime.h>
#import <Foundation/Foundation.h>

#import "NSDataAdditions.h"

#import "DetailedMovieInfo.h"
#import "MovieInfo.h"

@interface NSString(MovieInfoTemplateFilling)

+ (NSString*) stringWithTemplateString:(NSString*)templateString filledDetailedMovieInfo:(DetailedMovieInfo*) movieInfo;

@end
