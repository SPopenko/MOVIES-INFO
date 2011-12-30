//
//  DetailedMovieInfo+NSCoder.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailedMovieInfo+NSCoder.h"

@implementation DetailedMovieInfo (NSCoderCategory)

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.backdrops   = [aDecoder decodeObjectForKey:@"backdrops"];
    self.cast        = [aDecoder decodeObjectForKey:@"cast"];
    self.description = [aDecoder decodeObjectForKey:@"description"];
    self.trailer     = [aDecoder decodeObjectForKey:@"trailer"];
    
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [super initWithCoder:aCoder];
    
    [aCoder encodeObject:self.backdrops forKey:@"backdrops"];
    [aCoder encodeObject:self.cast forKey:@"cast"];
    [aCoder encodeObject:self.description forKey:@"description"];
    [aCoder encodeObject:self.trailer forKey:@"trailer"];
    
}

@end
