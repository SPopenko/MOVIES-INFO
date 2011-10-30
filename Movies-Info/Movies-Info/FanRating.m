//
//  FanRating.m
//  FanRating
//
//  Created by Anton Poluboiarynov on 10/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FanRating.h"

@implementation FanRating

@synthesize starFull  = _starFull;
@synthesize starEmpty =_starEmpty;
@synthesize rating    =_rating;
@synthesize numberOfStars = _numberOfStars;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    _numberOfStars = 5;
    if (_starFull == nil)  _starFull = [UIImage imageNamed:@"star_full"];
    if (_starEmpty == nil) _starEmpty= [UIImage imageNamed:@"star_empty"];
    
    if (_rating != nil)
    {
        [self setRating:_rating];        
    }
    else
    {
        [self setRating:[NSNumber numberWithDouble:3.6]];    
    }
    
}

- (void) setRating:(NSNumber *)newRating
{
    _rating = newRating;
    [_rating retain];
    [self drawStars ];
    
}

- (NSNumber*) getRating
{
    return _rating;
}


- (void) drawStars
{
    NSUInteger i, rate;
    CGContextRef canvas = UIGraphicsGetCurrentContext();
    
    UIImage* star = _starFull;
    
    CGRect clipRectangle = CGRectMake(star.size.width*([_rating doubleValue]), 0, _numberOfStars * star.size.width, star.size.height);
    CGRect drawRectangle;
    rate = [_rating  unsignedIntegerValue];
    
    for(i = 0; i < _numberOfStars; i++)
    {
        drawRectangle = CGRectMake(i*star.size.width, 0, star.size.width, star.size.height);        
        [self drawStar:star inRectangle:drawRectangle];
        if (i == rate)
        {
            CGContextSaveGState(canvas); 
            CGContextClipToRect(canvas, clipRectangle); 
            star = _starEmpty;
            [self drawStar:star inRectangle:drawRectangle];
            CGContextRestoreGState(canvas);
        }
    }

}

- (void) drawStar:(UIImage *)star inRectangle:(CGRect)drawRectangle
{
    [star drawInRect:drawRectangle];
}
@end
