//
//  MovieShortInfoCell.h
//  Movies-Info
//
//  Created by apol.dp on 9/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShortMovieInfo.h"

@interface MovieShortInfoCell : UITableViewCell {
    IBOutlet MovieShortInfoCell *movieShortInfoCell;
    IBOutlet UILabel *_name;
    IBOutlet UILabel *_release;
    IBOutlet UILabel *_runtime;
    IBOutlet UILabel *_fanRating;
    IBOutlet UIImageView *_poster;
}

@property(nonatomic, retain) IBOutlet MovieShortInfoCell *movieShortInfoCell; 

@property(nonatomic, retain, setter = setShortMovieInfo:) IBOutlet ShortMovieInfo *shortMovieInfo;

@end
