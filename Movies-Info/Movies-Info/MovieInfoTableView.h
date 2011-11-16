//
//  MovieInfoTableView.h
//  tv3
//
//  Created by user yser on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewActionIndicator.h"

#import "MoviesInfoDetailed.h"
#import "MovieShortInfoCell.h"
#import "ShortMovieInfo.h"
#import "MovieCache.h"
#import "MovieInfo.h"

#import "IASKAppSettingsViewController.h"

#import "IASKSpecifier.h"
#import "IASKSettingsReader.h"


@interface MovieInfoTableView : UITableViewController<IASKSettingsDelegate>{
    NSArray* movieList;
    MovieInfo* _movieInfo;
    IASKAppSettingsViewController* _appSettingsViewController;
    //var for storing movies per page
    NSNumber* _moviesPerPage;
}

- (IBAction)showSettings:(UIBarButtonItem*)sender;
- (void) loadMovieList;

@end
