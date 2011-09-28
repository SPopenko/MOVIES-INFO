//
//  MovieShortInfoCell.m
//  Movies-Info
//
//  Created by apol.dp on 9/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieShortInfoCell.h"

@implementation MovieShortInfoCell

@synthesize movieShortInfoCell;

@synthesize shortMovieInfo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

- (void) setShortMovieInfo:(ShortMovieInfo *)input
{
    static NSDateFormatter *date = nil;
    static NSDateFormatter *time = nil;
    
    NSString *pic;
    
    pic = @"movie.png";
    
    if (date == nil)
    {
        date = [[NSDateFormatter alloc] init];
        [date setDateStyle:NSDateFormatterShortStyle];
    }
    
    if (time == nil)
    {
        time = [[NSDateFormatter alloc] init];
        [time setDateFormat:@"HH:mm:ss"];
    }
    
    _name.text = input.movieName;
    _runtime.text = [time stringFromDate:input.runTime];
    _release.text = [date stringFromDate:input.releaseDate];
    _fanRating.text = [input.fanRating description];
    
    if (input.imagePath != nil)
    {
        pic = input.imagePath;
    }
    
    _poster.image = [UIImage imageNamed:pic];

}
@end
