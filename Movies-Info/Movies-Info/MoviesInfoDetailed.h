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
#import "MovieInfo.h"
#import <RestKit/RestKit.h>
#import <RestKit/Support/JSON/JSONKit/JSONKit.h>
#import <RestKit/Support/JSON/JSONKit/RKJSONParserJSONKit.h>

@interface MoviesInfoDetailed : UIViewController<RKObjectLoaderDelegate, MBProgressHUDDelegate>
{
    IBOutlet UIWebView *webView;
    ShortMovieInfo* shortMovieInfo;
    DetailedMovieInfo* movieInfo;
    MBProgressHUD* actionIndicator;
    MovieInfo* _movieInfo;
}

@property (retain, nonatomic) UIWebView*      webView;
@property (retain, nonatomic) ShortMovieInfo* shortMovieInfo;
@property (retain, nonatomic) DetailedMovieInfo* movieInfo;

- (void) prepareActionIndicator;
- (void) showLoadFinishIndicator;
- (void) showLoadIndicator;
- (void) showLoadIndicatorWithText:(NSString*)indicatorTest;
- (void) hideIndicator;
- (void) waitForTwoSeconds;

@end
