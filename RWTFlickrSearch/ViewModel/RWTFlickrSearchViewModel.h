//
//  RWTFlickrSearchViewModel.h
//  RWTFlickrSearch
//
//  Created by  plusub on 9/10/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTViewModelServices.h"


@interface RWTFlickrSearchViewModel : NSObject
@property (nonatomic, strong) RACCommand *executeSearch;

@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) NSString *title;

//初始化viewModel的时候用了一个代理
- (instancetype)initWithServices:(id<RWTViewModelServices>)services;
@end
