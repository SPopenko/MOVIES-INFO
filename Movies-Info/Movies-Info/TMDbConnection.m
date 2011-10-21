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

#define TMDbApiKey      @"ed2f89aa774281fcada8f17b73c8fa05"
#define TopTenMoviePath @"order_by=rating&order=desc&min_votes=5&page=1&per_page=10"
#define TopTenMovieBaseUrl @"http://api.themoviedb.org/2.1/Movie.browse/en-US/json/"

+(NSMutableArray*) getTopTenMovies{
    NSMutableArray* result = [[NSMutableArray alloc]init];
    
    //Generating MovieList
    
    //Remove code below after mapping
    /*remove begin*/
    ShortMovieInfo *smi  = [[ShortMovieInfo alloc] init];
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /*remove end*/
    
    //Begin of object mapping
    
    RKClient* client = [RKClient clientWithBaseURL:[NSString stringWithFormat:@"%@%@", TopTenMovieBaseUrl, TMDbApiKey]];
    //Creating ShortMovieInfo mapping
    RKObjectMapping *shortMovieInfoMapping = [RKObjectMapping mappingForClass:[ShortMovieInfo class]];
    //Mapping class properties to json attributes
    [shortMovieInfoMapping mapKeyPath:@"name" toAttribute:@"movieName"];
    /*
    [shortMovieInfoMapping mapKeyPath:@"runTime"     toAttribute:@"runtime"];
    [shortMovieInfoMapping mapKeyPath:@"releaseDate" toAttribute:@"released"];
    [shortMovieInfoMapping mapKeyPath:@"fanRating"   toAttribute:@"rating"];
    [shortMovieInfoMapping mapKeyPath:@"movieId"     toAttribute:@"id"];
    [shortMovieInfoMapping mapKeyPath:@"movieLink"   toAttribute:@"url"];
    */
        
    //Preparing send request to get top ten movies in all genres
    //[client get:@"order_by=rating&order=desc&min_votes=5&page=1&per_page=10" delegate:];
    NSLog([NSString stringWithFormat:@"%@", client.baseURL]);
    //TMDbConnection* TMDbConnect = [[TMDbConnection alloc]init];
    //[client get:TopTenMoviePath delegate:self];
    
    
    //Remove code below after mapping
    /*remove begin*/
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
    /*remove end*/    
    
    [result autorelease];
    return result;
}

-(void) loadData
{
    RKObjectManager* loadManager = [RKObjectManager objectManagerWithBaseURL:[NSString stringWithFormat:@"%@%@", TopTenMovieBaseUrl, TMDbApiKey]];
    [loadManager loadObjectsAtResourcePath:TopTenMoviePath delegate:self];
}

-(void) objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    
}

@end
