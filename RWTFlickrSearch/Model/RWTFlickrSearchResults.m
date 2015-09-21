//
//  RWTFlickrSearchResults.m
//  RWTFlickrSearch
//
//  Created by  plusub on 9/10/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchResults.h"


@implementation RWTFlickrSearchResults
-(NSString *)description
{
    return [NSString stringWithFormat:@"searchString=%@, totalresults=%lU, photos=%@", self.searchString, self.totalResults, self.photos];
}
@end
