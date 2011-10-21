//
//  MovieInfoTableView.m
//  tv3
//
//  Created by user yser on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieInfoTableView.h"

@implementation MovieInfoTableView

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
        //[[RKParserRegistry sharedRegistry]setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/json"];
        [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserYAJL class] forMIMEType:@"text/json"];
        //[RKObjectManager objectManagerWithBaseURL:TopTenMoviePath];
        [RKObjectManager objectManagerWithBaseURL:[NSString stringWithFormat:@"%@", TopTenMovieBaseUrl]];
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
    self.tableView.rowHeight = TableCellHeight;
    //movieList = [NSMutableArray array];
    
    RKObjectMapping* shortMovieInfoMapping = [RKObjectMapping mappingForClass:[ShortMovieInfo class]];
    
    
    [shortMovieInfoMapping mapKeyPathsToAttributes:
     @"id", @"movieId",
     @"name", @"movieName"
     , nil];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@%@", TMDbApiKey, TopTenMoviesPath] objectMapping:shortMovieInfoMapping delegate:self];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    int i = 0;
    //[movieList addObjectsFromArray:objects];
    movieList = [NSMutableArray array];
    ShortMovieInfo* shortMovieInfo;
    
    for(i=0; i<10 || i < [objects count]; i++)
    {
        shortMovieInfo = [objects objectAtIndex:i];
        NSString* info = [NSString stringWithFormat:
                          @"Movie ID is %@\n"
                          @"Movie name is %@\n", 
                          shortMovieInfo.movieId,
                          shortMovieInfo.movieName];
        [movieList addObject:shortMovieInfo];
        [shortMovieInfo retain];
        NSLog(info);
    }

}    
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {

    NSLog([NSString stringWithFormat: @"%@", [error localizedDescription]] );
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"%d", [movieList count]);
    return [movieList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
        
    MovieShortInfoCell *cell = (MovieShortInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[MovieShortInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MovieShortInfoCellView" owner:self options:nil] objectAtIndex:0];
        
        cell.frame = CGRectMake(0, 0, 320, 100);
    }
    
    
    cell.shortMovieInfo =  (ShortMovieInfo*)[movieList objectAtIndex:indexPath.row];;
    
    // Configure the cell...
    //cell.text = @"new Cell";
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
