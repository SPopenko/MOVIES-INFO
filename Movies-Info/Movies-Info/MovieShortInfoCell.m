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
    
    NSLog(@"%@,%d", input.movieId, [input.posters count]);


    //Loading image from internet :)
    NSString* posterKey = nil;
    
    if ([input.posters count] > 5)
    {
        Poster* poster = (Poster*)[input.posters objectAtIndex:5];
        posterKey = poster.image.url;
    }
    _poster.image = [MovieCache getImageFromCache:posterKey];
}

- (ShortMovieInfo*) getShortMovieInfo
{
    return _shortMovieInfo;    
}
@end
