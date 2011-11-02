//
//  MovieInfo.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieInfo.h"

@implementation MovieInfo

#define TMDbApiKey           @"ed2f89aa774281fcada8f17b73c8fa05"
#define TopTenMovieBaseUrl   @"http://api.themoviedb.org/2.1/"
#define MovieInfoUrl         @"Movie.getInfo/en-US/json/"
#define TopTenMoviesRequest  @"Movie.browse/en-US/json/"



- (void) getShortMovieInfoWithParameters:(NSDictionary *)parameters doAfterLoadFinished:(finishAction)doBlock
{
    _movieList = [[NSArray alloc] init];
    
    NSMutableDictionary* requestParameters = [self prepareParametersFromDictionary:parameters];
    
    [self initRestKit];
    _type = @"movieList";
    _finishAction = doBlock;
   
    //Creating request string
    NSString* requestString = [[NSString alloc] initWithFormat:@"%@", [self requestStringFromMutableDictionary:requestParameters]];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:requestString objectMapping:[self shortMovieInfoMapping] delegate:self];
    //return _movieList;
}

- (void) getDetailedMovieInfoByMovieID:(NSString *)movieID doAfterLoadFinished:(finishAction)doBlock
{
    [self initRestKit];
    _type = @"movieInfo";
    _finishAction = doBlock;
    NSString* requestString = [[NSString alloc] initWithFormat:@"%@/%@/%@", MovieInfoUrl,TMDbApiKey,movieID];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:requestString objectMapping:[self detailedMovieInfoMapping] delegate:self];
}

#pragma mark - RKObjectLoaderDelegate implementation
- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    NSLog(@"everything looks good");
    id obj = nil;
    if ([_type isEqualToString:@"movieList"])
    {
        _movieList = [objects retain];
        obj = _movieList;
        for (NSUInteger i = 0; i < [_movieList count]; i++)
        {
            NSLog(@"everything looks good");
            NSLog(@"%@", ((ShortMovieInfo*)[_movieList objectAtIndex:i]).movieName );
        }
        NSLog(@"everything looks good");
    }
    else if([_type isEqualToString:@"movieInfo"])
    {
        
    }
    else return;
    
    _finishAction(obj);
}    
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    
    NSLog(@"%@", [error localizedDescription] );
}

#pragma mark - preparing Search Parameters for short movie information
-(NSMutableDictionary*) prepareParametersFromDictionary:(NSDictionary *)parameters
{
    NSMutableDictionary* result = [[NSMutableDictionary alloc]initWithDictionary:parameters copyItems:YES];
    NSMutableDictionary* searchFields = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                         [NSString stringWithString:@"order_by"], @"orderBy",
                                         [NSString stringWithString:@"order"],    @"order",
                                         [NSString stringWithString:@"per_page"], @"perPage",
                                         [NSString stringWithString:@"page"],     @"page",
                                         nil];
    for (id key in searchFields) {
        NSLog(@"key: %@, value: %@", key, [searchFields objectForKey:key]);
    }
            
    return result;
}

- (NSString*) requestStringFromMutableDictionary:(NSMutableDictionary *)parameters
{
    
    return [NSString stringWithFormat:@"%@%@%@", @"Movie.browse/en-US/json/",TMDbApiKey, @"?order_by=rating&order=desc&min_votes=5&page=16&per_page=10"];
}

#pragma mark - Mapping Functions
- (RKObjectMapping*) shortMovieInfoMapping
{
    RKObjectMapping* shortMovieInfoMapping = [RKObjectMapping mappingForClass:[ShortMovieInfo class]];
    
    [shortMovieInfoMapping mapKeyOfNestedDictionaryToAttribute:@"image"];
    
    //Base property mappings
    //Prepring Date formatter for releseDate and Time
    NSDateFormatter* tmdbDateFormatter = [NSDateFormatter new];
    [tmdbDateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //Base fields mapping
    [shortMovieInfoMapping mapKeyPathsToAttributes:
     @"id",       @"movieId",
     @"name",     @"movieName",
     @"runtime",  @"duration",
     @"released", @"releaseDate",
     @"rating",   @"fanRating",
     nil];
    
    //Delete after creating normal dynamic mapping
    //Long long very long and strange mapping
//    RKObjectMapping* imageMapping = [RKObjectMapping mappingForClass:[Image class] ];
//    [imageMapping mapAttributes:@"url", nil];
//    
    RKObjectMapping* imageMapping = [RKObjectMapping mappingForClass:[Image class] ];
    [imageMapping mapAttributes:@"url", @"type", @"size", nil];
    
    RKObjectMapping* posterMaping = [RKObjectMapping mappingForClass:[Poster class] ];
    [posterMaping mapRelationship:@"image" withMapping: imageMapping];
    
    [shortMovieInfoMapping mapKeyPath:@"posters" toRelationship:@"posters" withMapping:posterMaping];
    //end of delete
    
    [RKObjectMapping addDefaultDateFormatter:tmdbDateFormatter];
    
    [tmdbDateFormatter autorelease]; 
    
    [shortMovieInfoMapping autorelease];
    return shortMovieInfoMapping;
}

- (RKObjectMapping*) detailedMovieInfoMapping
{
    RKObjectMapping* detailedMovieInfoMapping = [RKObjectMapping mappingForClass:[DetailedMovieInfo class]];
    
    //Base property mappings
    //Prepring Date formatter for releseDate and Time
    NSDateFormatter* tmdbDateFormatter = [NSDateFormatter new];
    [tmdbDateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    [detailedMovieInfoMapping mapKeyPathsToAttributes:
     @"id",       @"movieId",
     @"name",     @"movieName",
     @"runtime",  @"duration",
     @"released", @"releaseDate",
     @"rating",   @"fanRating",
     @"overview", @"description",
     nil];
    
    //Delete after creating normal dynamic mapping
    //Long long very long and strange mapping
    RKObjectMapping* personMapping = [RKObjectMapping mappingForClass:[Person class]];
    [personMapping mapAttributes:@"name", nil];
    [detailedMovieInfoMapping mapKeyPath:@"cast" toRelationship:@"cast" withMapping:personMapping];
    
    RKObjectMapping* imageMapping = [RKObjectMapping mappingForClass:[Image class] ];
    [imageMapping mapAttributes:@"url", @"type", @"size", nil];
    
    RKObjectMapping* posterMaping = [RKObjectMapping mappingForClass:[Poster class] ];
    [posterMaping mapRelationship:@"image" withMapping: imageMapping];
    
    [detailedMovieInfoMapping mapKeyPath:@"posters" toRelationship:@"posters" withMapping:posterMaping];
    [detailedMovieInfoMapping mapKeyPath:@"backdrops"toRelationship:@"backdrops" withMapping:posterMaping];    
    //end of delete
        
    [tmdbDateFormatter autorelease];
    
    return detailedMovieInfoMapping;
}

- (void) initRestKit
{
    //Registering base mapping Url
    [RKObjectManager objectManagerWithBaseURL:[NSString stringWithFormat:@"%@", TopTenMovieBaseUrl]];
    
    //Registering parser for respons MIMEType
    [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/json"];    
}
@end
