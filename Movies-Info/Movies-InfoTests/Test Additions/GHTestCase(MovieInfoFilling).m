//
//  GHTestCase(MovieInfoFilling).m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GHTestCase(MovieInfoFilling).h"

@implementation GHTestCase(MovieInfoFilling)

//test image link
#define testImageLink @"http://img.yandex.net/i/www/logo.png"
static const NSUInteger castCapacity    = 4;
static const NSUInteger postersCapacity = 13;

- (DetailedMovieInfo*) filledDetailedMovieInfo
{
    DetailedMovieInfo* result = [self emptyDetailedMovieInfo];
    
    [result retain];
    
    result.movieId     = [NSString stringWithString:@"1"];
    result.duration    = [NSNumber numberWithInt:128];
    result.imagePath   = [NSString stringWithString:@"imagePath"];
    result.description = [NSString stringWithString:@"description"];
    result.movieName   = [NSString stringWithString:@"movieName"];
    result.fanRating   = [NSNumber numberWithFloat:8.8f];
    result.releaseDate = [NSDate dateWithTimeIntervalSince1970:0.0f];
        
    result.cast = [self arrayWithCast];
    
    result.posters   = [self arrayWithPosters];
    result.backdrops = [self arrayWithPosters];
    
    [result release];
    
    return result;
}

- (DetailedMovieInfo*) filledDetailedMovieInfoWithTrailer
{
    DetailedMovieInfo* result = [self filledDetailedMovieInfo];
    
    [result retain];

    result.trailer     = [NSString stringWithString:@"http://www.youtube.com/watch?v=QYLLFpNn4lM"];
//    [t deswizzle];
    
    [result release];
    
    return result;
}

- (DetailedMovieInfo*) emptyDetailedMovieInfo
{
    DetailedMovieInfo* result = [[DetailedMovieInfo alloc] init];
    
    return [result autorelease];
}

- (ShortMovieInfo*) filledShortMovieInfo
{
    ShortMovieInfo* result = [self emptyShortMovieInfo];
    
    [result retain];
    
    result.movieId     = [NSString stringWithString:@"1"];
    result.duration    = [NSNumber numberWithInt:128];
    result.imagePath   = [NSString stringWithString:@"imagePath"];
    result.movieName   = [NSString stringWithString:@"movieName"];
    result.fanRating   = [NSNumber numberWithFloat:8.8f];
    result.releaseDate = [NSDate dateWithTimeIntervalSince1970:0.0f];
    
    result.posters   = [self arrayWithPosters];
    
    [result release];
    
    return result;
}

- (ShortMovieInfo*) emptyShortMovieInfo
{
    ShortMovieInfo* result = [[ShortMovieInfo alloc] init];
    
    return [result autorelease];
}

- (NSArray*) arrayWithCast
{
    NSMutableArray*   cast = [[NSMutableArray alloc] init];
    NSArray*        result = nil;
     
    for (int i = 0; i < castCapacity; i++)
    {
        Person* pers = [[Person alloc] init];
        pers.name = [NSString stringWithFormat:@"%d", (i+1)];
        [cast addObject:pers];
        [pers release];
    }
    
    result = [cast subarrayWithRange:NSMakeRange(0, cast.count)];
    [cast release];
    return result;
}


- (NSArray*) arrayWithPosters
{
    NSMutableArray* posters = [[NSMutableArray alloc] init];
    NSArray*         result = nil;
    
    //Creating posters
    for (int i = 0; i < postersCapacity; i++) 
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
        
        if (i < ((postersCapacity+1)/2))
        {
            image.type = [NSString stringWithString:@"poster"];
        }
        else
        {
            image.type = [NSString stringWithString:@"backdrop"];
        }
        image.url = [NSString stringWithString:testImageLink];
        poster.image = image;
        [posters addObject:poster];

        [poster release];
        [image release];
    }
    
    result = [posters subarrayWithRange:NSMakeRange(0, posters.count)];
    [posters release];
    
    return result;
}


+ (void) old
{
    DetailedMovieInfo* dmi = [[DetailedMovieInfo alloc] init];

    //Filling DetailedMovieInfo
    dmi.movieId     = [NSString stringWithString:@"1"];
    dmi.duration    = [NSNumber numberWithInt:128];
    dmi.imagePath   = [NSString stringWithString:@"imagePath"];
    dmi.description = [NSString stringWithString:@"description"];
    dmi.movieName   = [NSString stringWithString:@"movieName"];
    dmi.fanRating   = [NSNumber numberWithFloat:8.8f];
    dmi.releaseDate = [NSDate dateWithTimeIntervalSince1970:0.0f];
  }

@end
