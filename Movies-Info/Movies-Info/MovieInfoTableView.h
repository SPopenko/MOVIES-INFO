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
#import <RestKit/Support/JSON/YAJL/RKJSONParserYAJL.h>
#import "MoviesInfoDetailed.h"
#import "MovieShortInfoCell.h"
#import "ShortMovieInfo.h"
#import "TMDbConnection.h"

@interface MovieInfoTableView : UITableViewController<RKObjectLoaderDelegate>{
    NSMutableArray *movieList;
}

@end
