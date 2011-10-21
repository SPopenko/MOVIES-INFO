//
//  TMDbConnection.h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 10/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestKit/RestKit.h"

@interface TMDbConnection : NSObject<RKRequestDelegate>

+(NSMutableArray*) getTopTenMovies;


-(void) loadData;
-(void) objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects;

@end
