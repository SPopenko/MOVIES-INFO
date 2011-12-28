//
//  MovieInfo.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieInfo.h"

@implementation MovieInfo

#define TMDbApiKey          @"ed2f89aa774281fcada8f17b73c8fa05"
#define TopTenMovieBaseUrl  @"http://api.themoviedb.org/2.1/"
#define MovieInfoRequest    @"Movie.getInfo/en-US/json/"
#define SearchMoviesRequest @"Movie.browse/en-US/json/"



- (void) getShortMovieInfoWithParameters:(NSDictionary *)parameters doAfterLoadFinished:(finishAction)doBlock
{
    if (parameters == nil)
    {
        doBlock(nil);
        return;
    }
    
    NSMutableDictionary* requestParameters = [self prepareParametersFromDictionary:parameters];
    
    [self initRestKit];
    _type = @"movieList";
    _finishAction = [doBlock copy];
   
    //Creating request string
    NSString* requestString = [self requestStringFromMutableDictionary:requestParameters];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:requestString objectMapping:[self shortMovieInfoMapping] delegate:self];
    
}

- (void) getDetailedMovieInfoByMovieID:(NSString *)movieID doAfterLoadFinished:(finishAction)doBlock
{
    [self initRestKit];
    _type = @"movieInfo";
    _finishAction = [doBlock copy];
    NSString* requestString = [[NSString alloc] initWithFormat:@"%@/%@/%@", MovieInfoRequest,TMDbApiKey,movieID];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:requestString objectMapping:[self detailedMovieInfoMapping] delegate:self];
    [requestString release];
}

#pragma mark - RKObjectLoaderDelegate implementation
- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    id obj = nil;
    if ([_type isEqualToString:@"movieList"])
    {
        _movieList = [objects retain];
        obj = _movieList;
    }
    else if([_type isEqualToString:@"movieInfo"])
    {
        obj = [objects objectAtIndex:0];
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
    [parameters retain];
    
    NSMutableDictionary* result;
    if (parameters != nil)
    {
        result = [[NSMutableDictionary alloc] initWithDictionary:parameters copyItems:YES];
    }
    else
    {
        result = [[NSMutableDictionary alloc] init];
    }
    NSMutableDictionary* defaultValues = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                          [NSString stringWithString:@"rating"], @"orderBy",
                                          [NSString stringWithString:@"desc"],   @"order",
                                          [NSString stringWithString:@"16"],     @"perPage",
                                          [NSString stringWithString:@"1"],      @"page",
                                          [NSString stringWithString:@"10"],     @"minVotes",
                                          nil];
    for (id key in [defaultValues allKeys])
    {
        id obj = [result objectForKey: key];
        id defaultValue = [defaultValues objectForKey: key];
        if ( obj == nil && defaultValue != nil)
        {
            [result setValue:defaultValue forKey:key];
        }
    }
    
    [parameters release];
    [defaultValues release];
    return [result autorelease];
}

- (NSString*) requestStringFromMutableDictionary:(NSMutableDictionary *)parameters
{
    
    searchFields  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                            [NSString stringWithString:@"order_by"],  @"orderBy",
                                            [NSString stringWithString:@"order"],     @"order",
                                            [NSString stringWithString:@"per_page"],  @"perPage",
                                            [NSString stringWithString:@"page"],      @"page",
                                            [NSString stringWithString:@"min_votes"], @"minVotes",
                                             nil];
    NSMutableString* resultString = [[NSMutableString alloc] initWithString:@""];
    for (id key in [searchFields allKeys])
    {
        id param = [parameters objectForKey:key];
        NSLog(@"%@:%@", key, param);
        if (param != nil)
        {
            if (![resultString isEqualToString:@""]) [resultString appendString:@"&"];
            [resultString appendFormat:@"%@=%@", [searchFields objectForKey:key], param];
        }
    }
    
    [searchFields release];
    [resultString autorelease];
    return [NSString stringWithFormat:@"%@%@?%@", SearchMoviesRequest,TMDbApiKey, resultString];
}

#pragma mark - Mapping Functions
- (RKObjectMapping*) shortMovieInfoMapping
{
    RKObjectMapping* shortMovieInfoMapping = [[RKObjectMapping mappingForClass:[ShortMovieInfo class]]retain];
    
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
    RKObjectMapping* imageMapping = [RKObjectMapping mappingForClass:[Image class] ];
    [imageMapping mapAttributes:@"url", @"type", @"size", nil];
    
    RKObjectMapping* posterMaping = [RKObjectMapping mappingForClass:[Poster class] ];
    [posterMaping mapRelationship:@"image" withMapping: imageMapping];
    
    [shortMovieInfoMapping mapKeyPath:@"posters" toRelationship:@"posters" withMapping:posterMaping];
    //end of delete
    
    [RKObjectMapping addDefaultDateFormatter:tmdbDateFormatter];
    
    [tmdbDateFormatter autorelease]; 
    
    return [shortMovieInfoMapping autorelease];
}

- (RKObjectMapping*) detailedMovieInfoMapping
{
    RKObjectMapping* detailedMovieInfoMapping = [[RKObjectMapping mappingForClass:[DetailedMovieInfo class]] retain];
    
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
     @"trailer",  @"trailer",
     nil];
    
    //Delete after creating normal dynamic mapping
    //Long long very long and strange mapping
    RKObjectMapping* personMapping = [RKObjectMapping mappingForClass:[Person class] ];
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
    
    return [detailedMovieInfoMapping autorelease];
}

- (void) initRestKit
{
    static BOOL isInitialized = NO;
    if (!isInitialized)
    {
        //Registering base mapping Url
        [RKObjectManager objectManagerWithBaseURL:[NSString stringWithFormat:@"%@", TopTenMovieBaseUrl]];
    
        //Registering parser for respons MIMEType
        [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/json"];    
        
        isInitialized = YES;
    }
}

-(void)dealloc
{
    [_finishAction release];
    [searchFields release];
    [_type release];
    [_movieList release];
    [super dealloc];
}
@end
