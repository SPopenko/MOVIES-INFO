//
//  MoviesInfoDetailed.h
//  Movies-Info
//
//  Created by user yser on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShortMovieInfo.h"
@interface MoviesInfoDetailed : UIViewController
{
    IBOutlet UIWebView *webView;
    ShortMovieInfo* movieInfo;
}

@property (retain, nonatomic) UIWebView*      webView;
@property (retain, nonatomic) ShortMovieInfo* movieInfo;
@end
