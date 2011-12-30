//
//  ShortMovieInfo+NSCoder.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ShortMovieInfo+NSCoder.h"

//Delete after creating normal mapping
@implementation Image(NSCoder)

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self.url  = [aDecoder decodeObjectForKey:@"url"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.size = [aDecoder decodeObjectForKey:@"size"];
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.url  forKey:@"url"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.size forKey:@"size"];
}

@end

//Delete after creating normal mapping
@implementation Poster(NSCoder)

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self.image = [aDecoder decodeObjectForKey:@"image"];
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.image forKey:@"image"];
}

@end

@implementation ShortMovieInfo(NSCoder)

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self.posters     = [aDecoder decodeObjectForKey:@"posters"];
    self.movieId     = [aDecoder decodeObjectForKey:@"movieID"];
    self.fanRating   = [aDecoder decodeObjectForKey:@"fanRating"];
    self.movieName   = [aDecoder decodeObjectForKey:@"movieName"];
    self.duration    = [aDecoder decodeObjectForKey:@"duration"]; 
    self.releaseDate = [aDecoder decodeObjectForKey:@"releaseDate"];
    
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.posters     forKey:@"posters"];
    [aCoder encodeObject:self.movieId     forKey:@"movieID"];
    [aCoder encodeObject:self.fanRating   forKey:@"fanRating"];
    [aCoder encodeObject:self.movieName   forKey:@"movieName"];
    [aCoder encodeObject:self.duration    forKey:@"duration"]; 
    [aCoder encodeObject:self.releaseDate forKey:@"releaseDate"];
    
}

@end
