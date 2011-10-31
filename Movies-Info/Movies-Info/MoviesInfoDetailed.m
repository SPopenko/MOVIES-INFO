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
    
    [self showLoadIndicatorWithText:@"Loading detailed movie info"];
    
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
    
    [RKObjectMapping addDefaultDateFormatter:tmdbDateFormatter];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@%@/%@", MovieInfoUrl, TMDbApiKey, shortMovieInfo.movieId] objectMapping:detailedMovieInfoMapping delegate:self];
   
    [tmdbDateFormatter autorelease];
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
    
    float progress = 0.0f;
    while (progress < 1.0f)
    {
        progress += 0.01f;
        [self showDeterminateLoadIndicator:progress];
        usleep(50000);
    }

    
    [self showLoadFinishIndicator];
    
}    
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    
    NSLog(@"%@", [error localizedDescription] );
}

#pragma mark - actionIndicator Activities


- (void) prepareActionIndicator
{
    if (actionIndicator == nil)
    {
        actionIndicator = [[MBProgressHUD alloc] initWithView:self.view];
    }
    [self.view addSubview:actionIndicator];
}

- (void) showLoadIndicator
{
    [self showLoadIndicatorWithText:@"Loading"];
}

- (void) showLoadIndicatorWithText:(NSString*)indicatorText 
{
    [self prepareActionIndicator];
    actionIndicator.delegate = self;
    actionIndicator.mode = MBProgressHUDModeIndeterminate;
    actionIndicator.labelText = indicatorText;
    actionIndicator.dimBackground = YES;
    [actionIndicator show:YES];
    
}

-(void) showDeterminateLoadIndicator:(float)rate
{
    actionIndicator.progress = rate;
}

- (void) showLoadFinishIndicator
{
    [self prepareActionIndicator];
    
    actionIndicator.delegate = self;
    actionIndicator.dimBackground = NO;
    actionIndicator.customView = [[[UIImageView alloc] initWithImage:
                                   [UIImage imageNamed:@"checkmark.png"]] autorelease];
    actionIndicator.mode = MBProgressHUDModeCustomView;
    actionIndicator.labelText = @"Load finished";
    [actionIndicator showWhileExecuting:@selector(waitForTwoSeconds) 
                               onTarget:self withObject:nil animated:YES];
}

-(void) hideIndicator
{
    if (actionIndicator != nil)
    {
        [actionIndicator show:NO];
    }
}

- (void)waitForTwoSeconds {
    sleep(2);
}


@end
