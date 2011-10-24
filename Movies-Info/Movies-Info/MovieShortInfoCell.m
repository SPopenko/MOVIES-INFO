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
    
    _name.text = input.movieName;
    _runtime.text = [NSString stringWithFormat:@"%@", input.runTime];
    _release.text = [date stringFromDate:input.releaseDate];
    _fanRating.rating = [input.fanRating unsignedIntegerValue]/2;
    pic = @"movie.png";
    
    NSLog(@"\"%@\"", input.imagePath);
    if (input.imagePath != nil )
    {
        pic = input.imagePath;
        NSLog(@"%@", pic);
    }
    
    Poster* poster = (Poster*)[input.posters objectAtIndex:5];
    

    NSLog(@"%@", poster.image.url);
    
    //Loading image from internet :)
    NSData* imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: poster.image.url]];
    _poster.image = [UIImage imageWithData: imageData];
    
    [imageData release];

}

- (ShortMovieInfo*) getShortMovieInfo
{
    _shortMovieInfo.fanRating = [NSNumber numberWithUnsignedInteger:_fanRating.rating];
    return _shortMovieInfo;    
}
@end
