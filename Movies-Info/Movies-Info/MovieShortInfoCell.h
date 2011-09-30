//
//  MovieShortInfoCell.h
//  Movies-Info
//
//  Created by apol.dp on 9/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLStarRatingControl.h"
#import "ShortMovieInfo.h"

@interface MovieShortInfoCell : UITableViewCell {
    IBOutlet MovieShortInfoCell *movieShortInfoCell;
    IBOutlet UILabel *_name;
    IBOutlet UILabel *_release;
    IBOutlet UILabel *_runtime;
    IBOutlet DLStarRatingControl *_fanRating;
    IBOutlet UIImageView *_poster;
    
    IBOutlet ShortMovieInfo *shortMovieInfo;
}

@property(nonatomic, retain) IBOutlet MovieShortInfoCell *movieShortInfoCell; 

@property(nonatomic, retain, setter = setShortMovieInfo:) IBOutlet ShortMovieInfo *shortMovieInfo;

@end
