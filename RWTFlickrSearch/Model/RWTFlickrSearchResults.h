//
//  RWTFlickrSearchResults.h
//  RWTFlickrSearch
//
//  Created by  plusub on 9/10/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTFlickrSearchResults : NSObject
@property (nonatomic, strong) NSString *searchString;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic) NSUInteger totalResults;

@end
