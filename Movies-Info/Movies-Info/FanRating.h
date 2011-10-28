//
//  FanRating.h
//  FanRating
//
//  Created by Anton Poluboiarynov on 10/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FanRating : UIView

@property (nonatomic, retain, setter = setRating:, getter = getRating) NSNumber* rating;
@property (nonatomic, retain) UIImage*   starFull;
@property (nonatomic, retain) UIImage*   starEmpty;
@property (nonatomic)         NSUInteger numberOfStars;


- (void) drawStars;
- (void) drawStar:(UIImage*) star inRectangle:(CGRect) drawRectangle;
@end
