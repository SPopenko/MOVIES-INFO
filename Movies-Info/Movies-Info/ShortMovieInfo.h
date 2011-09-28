//
//  ShortMovieInfo.h
//  Movies-Info
//
//  Created by apol.dp on 9/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ShortMovieInfo : NSObject {
}

@property (nonatomic, retain) IBOutlet NSDate *releaseDate;
@property (nonatomic, retain) IBOutlet NSDate *runTime;
@property (nonatomic, retain) IBOutlet NSString *imagePath;
@property (nonatomic, retain) IBOutlet NSString *movieName;
@property (nonatomic, retain) IBOutlet NSNumber *fanRating;

@property (nonatomic, retain) IBOutlet NSString *movieLink;

@end
