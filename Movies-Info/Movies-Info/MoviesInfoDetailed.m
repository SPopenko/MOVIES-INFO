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
    
    _movieInfo = [[MovieInfo alloc] init];
    
    [_movieInfo getDetailedMovieInfoByMovieID:shortMovieInfo.movieId doAfterLoadFinished:^(id obj)
    {
        NSLog(@"It Works!");
        movieInfo = obj;
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"infoFilm" ofType:@"html"];
        NSMutableString *htmlData = [NSMutableString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
        
        htmlData = [movieInfo fillHtmlPage:htmlData];
        
        [webView loadHTMLString:htmlData baseURL:nil];
        
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

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {

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
    actionIndicator.delegate = self;
    
}

- (void) showLoadIndicator
{
    [self showLoadIndicatorWithText:@"Loading"];
}

- (void) showLoadIndicatorWithText:(NSString*)indicatorText 
{
    [self prepareActionIndicator];
    actionIndicator.mode = MBProgressHUDModeIndeterminate;
    actionIndicator.labelText = indicatorText;
    actionIndicator.dimBackground = YES;
    [actionIndicator show:YES];
    
}

- (void) showLoadFinishIndicator
{
    [self prepareActionIndicator];
    
    //actionIndicator.delegate = self;
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
