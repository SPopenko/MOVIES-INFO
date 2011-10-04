//
//  ShortMovieInfo.h
//  Movies-Info
//
//  Created by apol.dp on 9/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ShortMovieInfo : NSObject {
    NSDate* releaseDate;
    NSDate* runTime;
    NSString* imagePath;
    NSString* movieName;
    NSNumber* fanRating;
    
    NSString* movieLink;
}

@property (nonatomic, retain) NSDate *releaseDate;
@property (nonatomic, retain) NSDate *runTime;
@property (nonatomic, retain) NSString *imagePath;
@property (nonatomic, retain) NSString *movieName;
@property (nonatomic, retain) NSNumber *fanRating;

@property (nonatomic, retain) NSString *movieLink;

@end
