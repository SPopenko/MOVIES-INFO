//
//  MoviesInfoDetailed.m
//  Movies-Info
//
//  Created by user yser on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoviesInfoDetailed.h"

@implementation MoviesInfoDetailed

#define TMDbApiKey   @"ed2f89aa774281fcada8f17b73c8fa05"
#define MovieInfoUrl @"Movie.getInfo/en-US/json/"
//#define MovieBaseUrl @"http://api.themoviedb.org/2.1/Movie.getInfo/en-US/json/"

@synthesize webView;
@synthesize shortMovieInfo;
@synthesize movieInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[RKObjectManager objectManagerWithBaseURL:[NSString stringWithFormat:@"%@", MovieBaseUrl]];
    //[[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/json"];
    
    //Object mapping
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
    RKObjectMapping* imageMapping = [RKObjectMapping mappingForClass:[Image class] ];
    [imageMapping mapAttributes:@"url", @"type", @"size", nil];
    
    RKObjectMapping* posterMaping = [RKObjectMapping mappingForClass:[Poster class] ];
    [posterMaping mapRelationship:@"image" withMapping: imageMapping];
    
    [detailedMovieInfoMapping mapKeyPath:@"posters" toRelationship:@"posters" withMapping:posterMaping];
    [detailedMovieInfoMapping mapKeyPath:@"backdrops"toRelationship:@"backdrops" withMapping:posterMaping];    
    //end of delete
    
    [RKObjectMapping addDefaultDateFormatter:tmdbDateFormatter];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@%@/%@", MovieInfoUrl, TMDbApiKey, shortMovieInfo.movieId] objectMapping:detailedMovieInfoMapping delegate:self];
   
   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    DetailedMovieInfo* movie = [objects objectAtIndex:0];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"infoFilm" ofType:@"html"];
    NSMutableString *htmlData = [NSMutableString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    htmlData = [movie fillHtmlPage:htmlData];
    [webView loadHTMLString:htmlData baseURL:nil]; 
}    
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    
    NSLog([NSString stringWithFormat: @"%@", [error localizedDescription]] );
}


@end
