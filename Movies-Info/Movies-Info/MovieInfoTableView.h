//
//  MovieInfoTableView.h
//  tv3
//
//  Created by user yser on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <RestKit/RestKit.h>
#import <RestKit/Support/JSON/JSONKit/JSONKit.h>
#import <RestKit/Support/JSON/JSONKit/RKJSONParserJSONKit.h>
#import "MBProgressHUD.h"
#import "MoviesInfoDetailed.h"
#import "MovieShortInfoCell.h"
#import "ShortMovieInfo.h"
#import "MovieCache.h"
#import "MovieInfo.h"

@interface MovieInfoTableView : UITableViewController <MBProgressHUDDelegate>{
    NSArray* movieList;
    MBProgressHUD* actionIndicator;
    MovieInfo* _movieInfo;
}

- (void) prepareActionIndicator;
- (void) showLoadFinishIndicator;
- (void) showLoadIndicator;
- (void) showLoadIndicatorWithText:(NSString*)indicatorTest;
- (void) hideIndicator;
- (void) waitForTwoSeconds;


@end
