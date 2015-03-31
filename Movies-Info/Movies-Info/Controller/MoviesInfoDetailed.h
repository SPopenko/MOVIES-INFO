//
//  MoviesInfoDetailed.h
//  Movies-Info
//
//  Created by user yser on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DetailedMovieInfo.h"
#import "ShortMovieInfo.h"
#import "MBProgressHUD.h"
#import "ViewActionIndicator.h"
#import "MovieInfo.h"
#import "YouTubeVideo.h"
#import "NSString(MovieInfoTemplateFilling).h"

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
@property (retain, nonatomic) IBOutlet UIBarButtonItem* playTrailerButton;

- (IBAction) playTrailer:(UIBarButtonItem*)sender;

@end
