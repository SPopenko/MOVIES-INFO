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
//#import "MovieInfoTableView.h"
#import <RestKit/RestKit.h>
#import <RestKit/Support/JSON/JSONKit/JSONKit.h>
#import <RestKit/Support/JSON/JSONKit/RKJSONParserJSONKit.h>

@interface MoviesInfoDetailed : UIViewController<RKObjectLoaderDelegate>
{
    IBOutlet UIWebView *webView;
    ShortMovieInfo* shortMovieInfo;
    DetailedMovieInfo* movieInfo;
}

@property (retain, nonatomic) UIWebView*      webView;
@property (retain, nonatomic) ShortMovieInfo* shortMovieInfo;
@property (retain, nonatomic) DetailedMovieInfo* movieInfo;

@end
