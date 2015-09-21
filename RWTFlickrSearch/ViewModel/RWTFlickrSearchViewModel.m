//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by  plusub on 9/10/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"

@interface RWTFlickrSearchViewModel ()
@property (weak, nonatomic) id<RWTViewModelServices> services;
@end

@implementation RWTFlickrSearchViewModel
- (instancetype)initWithServices:(id<RWTViewModelServices>)services
{
    self = [super init];
    if (self) {
        _services = services;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.title = @"Flickr Search";
    
    //建立信号，当文字大于3的时候产生信号
    RACSignal *validSearchSignal = [[RACObserve(self, searchText) map:^id(NSString *text) {
        return @(text.length > 3);
    }] distinctUntilChanged];
    
    //将产生的信号发出
    [validSearchSignal subscribeNext:^(id x) {
        NSLog(@"asdf");
    }];
    
    //建立一个raccomand的执行性信号，当有信号来的时候可以初始化，初始化之后执行网络请求
    self.executeSearch = [[RACCommand alloc] initWithEnabled:validSearchSignal signalBlock:^RACSignal *(id input) {
        return [self executeSearchSignal];
    }];
    
}

-(RACSignal *)executeSearchSignal
{
    //由于初始化的时一个代理，在此执行代理的方法，而这个代理的方法又是一个代理
    //在RWTFlickrSearchImpl我们执行了这个代理，开始进行网络请求
    return [[[self.services getFlickrSearchService] flickrSearchSignal:self.searchText] logAll];
}
@end
