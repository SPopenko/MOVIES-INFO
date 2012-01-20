//
//  MoviesInfoDetailed.m
//  Movies-Info
//
//  Created by user yser on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoviesInfoDetailed.h"

@implementation MoviesInfoDetailed

@synthesize webView;
@synthesize shortMovieInfo;
@synthesize movieInfo;
@synthesize playTrailerButton  = _playTrailerButton;

#pragma mark - method for loading movie info and displaying it in webview
- (void) loadMovieToWebViewById:(NSString*) movieId withLoadString:(NSString*) loadString
{
    [self showLoadIndicatorWithText:loadString];
    [_movieInfo getDetailedMovieInfoByMovieID:movieId doAfterLoadFinished:^(id obj)
     {
         self.movieInfo = obj;
         NSString *htmlPath     = [[NSBundle mainBundle] pathForResource:@"infoFilm" ofType:@"html"];
         NSString *htmlTemplate = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
         NSString *htmlFilled   = [NSString stringWithTemplateString:htmlTemplate filledDetailedMovieInfo:self.movieInfo];
         
         [webView loadHTMLString:htmlFilled baseURL:nil];
         
         if (movieInfo.trailer) {
             _playTrailerButton.enabled = YES;
         }
         [self showLoadFinishIndicator];
     }];    
    
}

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
    
    _searchResultDisplay = NO;
    
    _movieInfo = [[MovieInfo alloc] init];
    
    _playTrailerButton.enabled = NO;
    
    [self loadMovieToWebViewById:self.shortMovieInfo.movieId withLoadString:@"Loading detailed movie info"];
    
    [self addSearchBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self displaySearchBarIfActive];
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

- (IBAction)playTrailer:(UIBarButtonItem*)sender
{
    
    if (movieInfo.trailer)
    {
        NSURL* movieURL = [NSURL URLWithString:movieInfo.trailer];
        MPMoviePlayerViewController* playerController = [[[MPMoviePlayerViewController alloc] initWithContentURL:movieURL] autorelease];
        
        if (playerController) 
        {
            [self presentMoviePlayerViewControllerAnimated:playerController];
        }
    }
}

- (void) searchBarDelegateEndSearch:(NSArray *)resultsArray
{
    _searchResultDisplay = YES;
    
    if (resultsArray.count > 0)
    {
        ShortMovieInfo* smi = [(ShortMovieInfo*)[resultsArray objectAtIndex:0] retain];
        [self loadMovieToWebViewById:smi.movieId withLoadString:@"Search result loading"];
        [smi release];
    }
}

- (void) searchBarDelegateHideSearchResults
{
    [self loadMovieToWebViewById:self.shortMovieInfo.movieId withLoadString:@"Loading detailed movie info"];
}

- (void) dealloc
{
    [webView    release];
    [_movieInfo release];
    [movieInfo  release];
    [shortMovieInfo release];
    [_playTrailerButton release];
    
    [super dealloc];
}
@end
