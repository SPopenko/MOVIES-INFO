//
//  ShortMovieInfo.h
//  Movies-Info
//
//  Created by apol.dp on 9/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <Foundation/NSObjCRuntime.h>

//Delete after creating normal mapping
@interface Image :NSObject <NSCoding>
@property (nonatomic, retain) NSString* url;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSString* size;
@end

//Delete after creating normal mapping
@interface Poster : NSObject <NSCoding> {
}
@property (nonatomic, retain) Image* image;
@end

@interface ShortMovieInfo : NSObject <NSCoding> {
}

@property (nonatomic, retain) NSDate   *releaseDate;
@property (nonatomic, retain) NSNumber *duration;
@property (nonatomic, retain) NSString *imagePath;
@property (nonatomic, retain) NSString *movieName;
@property (nonatomic, retain) NSNumber *fanRating;
@property (nonatomic, retain) NSString *movieId;
@property (nonatomic, retain) NSArray  *posters;
@property (nonatomic, retain, getter = getPoster) NSString *poster;


@end