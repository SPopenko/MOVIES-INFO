//
//  MovieInfoTableView.m
//  tv3
//
//  Created by user yser on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieInfoTableView.h"


//Defiyng HUD
@interface UIProgressHUD : NSObject 
- (UIProgressHUD *) initWithWindow: (UIView*)aWindow; 
- (void) show: (BOOL)aShow; 
- (void) setText: (NSString*)aText; 
@end


@implementation MovieInfoTableView

//ShortMovieInfo cell height
#define TableCellHeight 100

//themoviedb.rog work constants
#define TMDbApiKey      @"ed2f89aa774281fcada8f17b73c8fa05"
#define TopTenMoviesPath @"?order_by=rating&order=desc&min_votes=5&page=1&per_page=10"
#define TopTenMovieBaseUrl @"http://api.themoviedb.org/2.1/Movie.browse/en-US/json"
#define TopTenMovie @"http://api.themoviedb.org/2.1/Movie.browse/en-US/json/ed2f89aa774281fcada8f17b73c8fa05?order_by=rating&order=desc&min_votes=5&page=1&per_page=10"

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
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

    [RKObjectManager objectManagerWithBaseURL:[NSString stringWithFormat:@"%@", TopTenMovieBaseUrl]];
    [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/json"];
    
    self.tableView.rowHeight = TableCellHeight;
    self.title = @"Movies";
    RKObjectMapping* shortMovieInfoMapping = [RKObjectMapping mappingForClass:[ShortMovieInfo class]];
    
    //Base property mappings
    //Prepring Date formatter for releseDate and Time
    NSDateFormatter* tmdbDateFormatter = [NSDateFormatter new];
    [tmdbDateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    [shortMovieInfoMapping mapKeyPathsToAttributes:
     @"id",       @"movieId",
     @"name",     @"movieName",
     @"url",      @"movieLink",
     @"runtime",  @"runTime",
     @"released", @"releaseDate",
     @"rating",   @"fanRating",
     nil];
    
    //Delete after creating norma dynamic mapping
    //Long long very long and strange mapping
    RKObjectMapping* imageMapping = [RKObjectMapping mappingForClass:[Image class] ];
    [imageMapping mapAttributes:@"url", nil];
    
    RKObjectMapping* posterMaping = [RKObjectMapping mappingForClass:[Poster class] ];
    [posterMaping mapRelationship:@"image" withMapping: imageMapping];

    [shortMovieInfoMapping mapKeyPath:@"posters" toRelationship:@"posters" withMapping:posterMaping];
    //end of delete
    
    //[shortMovieInfoMapping mapKeyPath:@"posters[1].@image.@type" toAttribute:@"imagePath"];
    
    [RKObjectMapping addDefaultDateFormatter:tmdbDateFormatter];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@%@", TMDbApiKey, TopTenMoviesPath] objectMapping:shortMovieInfoMapping delegate:self];
    
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    movieList = [objects retain];
    [self.tableView reloadData];
}    
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {

    NSLog([NSString stringWithFormat: @"%@", [error localizedDescription]] );
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [movieList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MovieShortInfoCell *cell = (MovieShortInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MovieShortInfoCellView" owner:self options:nil] objectAtIndex:0];
    }
    cell.shortMovieInfo =  (ShortMovieInfo*)[movieList objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    MoviesInfoDetailed *detailViewController = [[MoviesInfoDetailed alloc] initWithNibName:@"MoviesInfoDetailed" bundle:nil];
    MovieShortInfoCell* smic = (MovieShortInfoCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    ShortMovieInfo*     smi  = smic.shortMovieInfo;
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:smi.movieLink]]];
        
    [detailViewController release];
     
}

@end
