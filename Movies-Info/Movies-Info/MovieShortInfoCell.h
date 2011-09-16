//
//  MovieShortInfoCell.h
//  Movies-Info
//
//  Created by apol.dp on 9/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MovieShortInfoCell : UITableViewCell {
    IBOutlet MovieShortInfoCell *movieShortInfoCell;
}

@property(nonatomic, retain) IBOutlet MovieShortInfoCell *movieShortInfoCell; 

@property(nonatomic, retain) IBOutlet UILabel *name;
@property(nonatomic, retain) IBOutlet UILabel *runTime;
@property(nonatomic, retain) IBOutlet UILabel *releaseDate;
@property(nonatomic, retain) IBOutlet UILabel *fanRating;

@property(nonatomic, retain) IBOutlet UIImageView *poster;

@end
