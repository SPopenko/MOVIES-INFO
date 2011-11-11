//
//  MovieInfoTableView.m
//  tv3
//
//  Created by user yser on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieInfoTableView.h"

@implementation MovieInfoTableView

//ShortMovieInfo cell height
#define TableCellHeight 100

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
    [MovieCache clearCache];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showLoadIndicatorWithText:@"Loading movie list"];
    self.tableView.rowHeight = TableCellHeight;
    self.title = @"Movies";    
    
    UIBarButtonItem* preferencesButton = [[UIBarButtonItem alloc]initWithTitle:@"" 
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(showSettings:)];
    preferencesButton.image = [UIImage imageNamed:@"preferences.png"];
    
    self.navigationItem.rightBarButtonItem = preferencesButton;    
    
    
    movieList = [[NSArray alloc]init];
    _movieInfo = [[MovieInfo alloc] init];
    
    NSDictionary* searchParameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      [NSString stringWithString:@"rating"], @"orderBy",
                                      [NSString stringWithString:@"desc"],   @"order",
                                      [NSString stringWithString:@"16"],     @"perPage",
                                      [NSString stringWithString:@"10"],     @"page",
                                      [NSString stringWithString:@"10"],     @"minVotes",
                                      nil];
    
    
    [_movieInfo getShortMovieInfoWithParameters:searchParameters doAfterLoadFinished:^(id obj)
    {
        movieList = obj;
        [self.tableView reloadData];
        [self showLoadFinishIndicator];
    }];
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
    
    detailViewController.shortMovieInfo = smi;
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];

    [detailViewController release];
     
}

#pragma mark display settings view
- (IBAction)showSettings:(UIBarButtonItem *)sender
{
    ApplicationPreferences* applicationPrefernces = [[ApplicationPreferences alloc] initWithNibName:@"ApplicationPreferences" bundle:nil];
    //[self presentModalViewController:applicationPrefernces animated:YES];
    [self.navigationController pushViewController:applicationPrefernces animated:YES];
    [applicationPrefernces  release];
}

- (void) dealloc
{
    [movieList  release];
    [_movieInfo release];
    [super dealloc];
}

@end
