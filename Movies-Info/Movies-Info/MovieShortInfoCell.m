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
    
    NSString *pic;
    
    _shortMovieInfo = input;
    
    pic = @"movie.png";
    
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
    
    NSLog(@"%f", [input.fanRating doubleValue]);
    input.fanRating = [NSNumber numberWithDouble:[input.fanRating doubleValue]/2 ];
    NSLog(@"%f", [input.fanRating doubleValue]);
    
    [_fanRating setRating:input.fanRating];

    
    pic = @"movie.png";
    
    Poster* poster = (Poster*)[input.posters objectAtIndex:5];

    if (poster.image.url != nil )
    {
        pic = input.imagePath;
    }
    //Loading image from internet :)
    NSData* imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: poster.image.url]];
    _poster.image = [UIImage imageWithData: imageData];
    
    [imageData release];

}

- (ShortMovieInfo*) getShortMovieInfo
{
    return _shortMovieInfo;    
}
@end
