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
    [shortMovieInfo release];
    [super dealloc];
}

- (void) setShortMovieInfo:(ShortMovieInfo *)input
{
    static NSDateFormatter *date = nil;
    static NSDateFormatter *time = nil;
    
    _shortMovieInfo = input;
    
    if (date == nil)
    {
        date = [[NSDateFormatter alloc] init];
        [date setDateStyle:NSDateFormatterLongStyle];
    }
    
    if (time == nil)
    {
        time = [[NSDateFormatter alloc] init];
        [time setDateFormat:@"HH:mm:ss"];
    }
    
    _name.text     = input.movieName;
    _duration.text = [NSString stringWithFormat:@"%@", input.duration];
    _release.text  = [date stringFromDate:input.releaseDate];
    [_fanRating setRating:[NSNumber numberWithDouble:[input.fanRating doubleValue]/2 ]];
    
    //_poster.image = [MovieCache getImageFromCache:input.poster];
}

- (ShortMovieInfo*) getShortMovieInfo
{
    return _shortMovieInfo;    
}
@end
