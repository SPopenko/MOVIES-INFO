//
//  GHTestCase(ResultsFromFile).h
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

@interface GHTestCase(ResultsAndConditionsFromFile)

- (NSString*) loadStringForKey:(NSString*)key;
- (NSArray*)  loadArrayForKey:(NSString*)key;

- (NSDictionary*) dictionaryWithValues;
@end
