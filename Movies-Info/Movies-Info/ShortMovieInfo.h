//
//  ShortMovieInfo.h
//  Movies-Info
//
//  Created by apol.dp on 9/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface ShortMovieInfo : NSObject {
    NSDate* releaseDate;
    NSDate* runTime;
    NSString* imagePath;
    NSString* movieName;
    NSNumber* fanRating;
    NSNumber* movieId;
    
    NSString* movieLink;
}

@property (nonatomic, retain) NSDate   *releaseDate;
@property (nonatomic, retain) NSDate   *runTime;
@property (nonatomic, retain) NSString *imagePath;
@property (nonatomic, retain) NSString *movieName;
@property (nonatomic, retain) NSNumber *fanRating;
@property (nonatomic, retain) NSNumber *movieId;

@property (nonatomic, retain) NSString *movieLink;



@end