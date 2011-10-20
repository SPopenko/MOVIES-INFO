//
//  TMDbConnection.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 10/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TMDbConnection.h"
#import "RestKit/RestKit.h"
#import "ShortMovieInfo.h"
@implementation TMDbConnection


+(NSMutableArray*) getTopTenMovies{
    NSMutableArray* result = [[NSMutableArray alloc]init];
    
    //Generating MovieList
    ShortMovieInfo *smi  = [[ShortMovieInfo alloc] init];
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //TMDbConnection* TMDbConnect = [[TMDbConnection alloc]init];
    
    
    //movieList = [NSMutableArray array];
    
    [dc setDay:01];
    [dc setMonth:05];
    [dc setYear:2008];
    
    smi.movieName = @"Iron man";
    smi.releaseDate = [calendar dateFromComponents:dc];
    
    [dc setDay:0];
    [dc setMonth:0];
    [dc setYear:0];
    [dc setMinute:6];
    [dc setHour:2];
    [dc setSecond:01];
    
    smi.runTime     = [calendar dateFromComponents:dc];
    smi.imagePath = @"ironman.jpg";
    smi.fanRating = [NSNumber numberWithUnsignedInteger:3];
    smi.movieLink = @"http://www.themoviedb.org/movie/75299";
    [result addObject:smi];
    
    [smi release];
    smi = nil;
    [dc release];
    dc = nil;
    
    
    [result autorelease];
    return result;
}

@end
