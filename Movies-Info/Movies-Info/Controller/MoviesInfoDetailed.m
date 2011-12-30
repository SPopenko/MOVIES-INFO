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
    _movieInfo = [[MovieInfo alloc] init];
    
    _playTrailerButton.enabled = NO;

    [_movieInfo getDetailedMovieInfoByMovieID:shortMovieInfo.movieId doAfterLoadFinished:^(id obj)
    {
        movieInfo = [obj retain];
        NSString *htmlPath     = [[NSBundle mainBundle] pathForResource:@"infoFilm" ofType:@"html"];
        NSString *htmlTemplate = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
        NSString *htmlFilled   = [NSString stringWithTemplateString:htmlTemplate filledDetailedMovieInfo:movieInfo];

        [webView loadHTMLString:htmlFilled baseURL:nil];
        
        if (movieInfo.trailer) {
            _playTrailerButton.enabled = YES;
        }
        [self showLoadFinishIndicator];
    }];
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
        MPMoviePlayerViewController* playerController = [[[MPMoviePlayerViewController alloc] initWithContentURL:movieURL] retain]
        ; 
        if (playerController) 
        {
            [self presentMoviePlayerViewControllerAnimated:playerController];
        }
        [movieURL release];
        [playerController release];
    }
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