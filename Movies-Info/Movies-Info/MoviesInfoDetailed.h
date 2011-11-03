//
//  MoviesInfoDetailed.h
//  Movies-Info
//
//  Created by user yser on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailedMovieInfo.h"
#import "ShortMovieInfo.h"
#import "MBProgressHUD.h"

#import "ViewActionIndicator.h"

#import "MovieInfo.h"
@interface MoviesInfoDetailed : UIViewController
{
    IBOutlet UIWebView *webView;
    ShortMovieInfo* shortMovieInfo;
    DetailedMovieInfo* movieInfo;
    MovieInfo* _movieInfo;
}

@property (retain, nonatomic) UIWebView*      webView;
@property (retain, nonatomic) ShortMovieInfo* shortMovieInfo;
@property (retain, nonatomic) DetailedMovieInfo* movieInfo;

- (IBAction) playTrailer:(UIBarButtonItem*)sender;

@end
