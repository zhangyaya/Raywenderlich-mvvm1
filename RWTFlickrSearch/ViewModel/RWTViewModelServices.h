//
//  RWTViewModelServices.h
//  RWTFlickrSearch
//
//  Created by  plusub on 9/10/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTFlickrSearch.h"

@protocol RWTViewModelServices <NSObject>

//这个代理用来进行网络请求
- (id<RWTFlickrSearch>)getFlickrSearchService;

@end
