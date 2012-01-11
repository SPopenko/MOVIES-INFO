 //
//  MovieInfoTableView.m
//  tv3
//
//  Created by user yser on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieInfoTableView.h"

@implementation MovieInfoTableView

@synthesize searchBar   = _searchBar;
@synthesize bSearchIsOn;
//ShortMovieInfo cell height
#define TableCellHeight 100

//key in settings bundle for movies per page
#define kMoviesPerPage @"moviesPerPage"

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
    movieList = nil;
    
    self.tableView.rowHeight = TableCellHeight;
    self.title = @"Movies";    
    
    //Preparing button for settings
    UIBarButtonItem* preferencesButton = [[UIBarButtonItem alloc]initWithTitle:@"" 
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(showSettings:)];
    preferencesButton.image = [UIImage imageNamed:@"preferences.png"];
    self.navigationItem.rightBarButtonItem = preferencesButton;    
    
    //Preparing cache
    _movieInfo = [[MovieInfo alloc] init];

    
    //Preparing Search bar
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.placeholder = @"Type a search term";
    _searchBar.tintColor = [UIColor blackColor];
    
    _searchBar.delegate = self;
    
    [_searchBar sizeToFit];
    self.bSearchIsOn = NO;
    
    [_searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_searchBar sizeToFit];
    
    UIBarButtonItem* bi = [[UIBarButtonItem alloc]
                           initWithBarButtonSystemItem: UIBarButtonSystemItemSearch target:self action:@selector(searchBar:)];
    bi.style = UIBarButtonItemStyleBordered;
    
    self.navigationItem.rightBarButtonItem = bi;
    
    [bi release];
}


#pragma mark - search bar display action
- (void) searchBar: (id) object
{
    bSearchIsOn = ! bSearchIsOn;
    
    if (bSearchIsOn)
    {
        self.tableView.tableHeaderView = _searchBar; // show the search bar on top of table
    }
    else
    {
        self.tableView.tableHeaderView = nil;
        [_searchBar resignFirstResponder ]; 
    }
    
    [self.tableView scrollRectToVisible:[[self.tableView tableHeaderView] bounds] animated:NO]; // scroll to top so we see the search bar
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadMovieList];
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
    if (!_appSettingsViewController) {
		_appSettingsViewController = [[IASKAppSettingsViewController alloc] initWithNibName:@"IASKAppSettingsView" bundle:nil];
		_appSettingsViewController.delegate = self;
	}
    
    [_appSettingsViewController setShowCreditsFooter:NO];
    _appSettingsViewController.showDoneButton = NO;
    [self.navigationController pushViewController:_appSettingsViewController animated:YES];
}

#pragma mark inAppSettingsKit delegate functions
- (void) settingsViewControllerDidEnd:(IASKAppSettingsViewController *)sender
{
    //in this section we can do some settings appliyng code
}

#pragma mark - search bar code
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // only show the status bar's cancel button while in edit mode
    _searchBar.showsCancelButton = YES;    
}

- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    _searchBar.showsCancelButton = NO;
}

#pragma mark - movie list loading
- (void) loadMovieList
{
    NSNumber* perPage = nil;
    if([[NSUserDefaults  standardUserDefaults] boolForKey:kMoviesPerPage])
    {
        perPage = [[NSUserDefaults standardUserDefaults] valueForKey:kMoviesPerPage];
    }
    
    if (![_moviesPerPage isEqualToNumber:perPage])
    {    
        _moviesPerPage = perPage;
        //starting loading data from server;
        [self showLoadIndicatorWithText:@"Loading movie list"];
        if (!perPage)
        {
            perPage = [NSNumber numberWithInt:5];
        }
    
        NSDictionary* searchParameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          [NSString stringWithString:@"rating"],      @"orderBy",
                                          [NSString stringWithString:@"desc"],        @"order",
                                          [NSString stringWithFormat:@"%@", perPage], @"perPage",
                                          [NSString stringWithString:@"1"],           @"page",
                                          [NSString stringWithString:@"5"],          @"minVotes",
                                          nil];
    
    
        [_movieInfo getShortMovieInfoWithParameters:searchParameters doAfterLoadFinished:^(id obj)
        {
            movieList = obj;
            [self.tableView reloadData];
            [self showLoadFinishIndicator];
        }];
    }
}

- (void) dealloc
{
    [_searchBar release];
    [movieList  release];
    [_movieInfo release];
    [_moviesPerPage release];
    [_appSettingsViewController release];
    [super dealloc];
}

@end
