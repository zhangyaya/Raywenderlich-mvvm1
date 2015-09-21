//
//  RWTViewModelServicesImpl.m
//  RWTFlickrSearch
//
//  Created by  plusub on 9/10/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import "RWTViewModelServicesImpl.h"
#import "RWTFlickrSearchImpl.h"

@interface RWTViewModelServicesImpl ()

@property (nonatomic, strong) RWTFlickrSearchImpl *searchService;

@end

@implementation RWTViewModelServicesImpl
- (instancetype)init
{
    self = [super init];
    if (self) {
        _searchService = [RWTFlickrSearchImpl new];
    }
    return self;
}

-(id<RWTFlickrSearch>)getFlickrSearchService
{
    return self.searchService;
}
@end
