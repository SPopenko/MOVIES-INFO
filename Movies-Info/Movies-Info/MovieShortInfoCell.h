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
    IBOutlet UILabel *_duration;
    IBOutlet DLStarRatingControl *_fanRating;
    IBOutlet UIImageView *_poster;
    
    IBOutlet ShortMovieInfo *_shortMovieInfo;
}

@property(nonatomic, retain) IBOutlet MovieShortInfoCell *movieShortInfoCell; 

@property(nonatomic, retain, setter = setShortMovieInfo:, getter = getShortMovieInfo) IBOutlet ShortMovieInfo *shortMovieInfo;

@end
