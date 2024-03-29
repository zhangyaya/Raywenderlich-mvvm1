//
//  RWTFlickrSearchImpl.m
//  RWTFlickrSearch
//
//  Created by  plusub on 9/10/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchImpl.h"
#import "RWTFlickrPhoto.h"
#import <objectiveflickr/ObjectiveFlickr.h>
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>
#import "RWTFlickrSearchResults.h"

@interface RWTFlickrSearchImpl () <OFFlickrAPIRequestDelegate>
@property (nonatomic, strong) NSMutableSet *requests;
@property (nonatomic, strong) OFFlickrAPIContext *flickrContext;
@end

@implementation RWTFlickrSearchImpl
- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *OFSampleAppAPIKey = @"9d1bdbde083bc30ebe168a64aac50be5";
        NSString *OFSampleAppAPISharedSecret = @"5fbfa610234c6c23";
        
        _flickrContext = [[OFFlickrAPIContext alloc] initWithAPIKey:OFSampleAppAPIKey
                                                       sharedSecret:OFSampleAppAPISharedSecret];
        _requests = [NSMutableSet new];
    }
    return  self;
}

- (RACSignal *)signalFromAPIMethod:(NSString *)method
                         arguments:(NSDictionary *)args
                         transform:(id (^)(NSDictionary *response))block {
    
    // 1. Create a signal for this request
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // 2. Create a Flick request object
        OFFlickrAPIRequest *flickrRequest =
        [[OFFlickrAPIRequest alloc] initWithAPIContext:self.flickrContext];
        flickrRequest.delegate = self;
        [self.requests addObject:flickrRequest];
        
        // 3. Create a signal from the delegate method
        RACSignal *successSignal =
        [self rac_signalForSelector:@selector(flickrAPIRequest:didCompleteWithResponse:)
                       fromProtocol:@protocol(OFFlickrAPIRequestDelegate)];
        
        // 4. Handle the response
        [[[successSignal
           map:^id(RACTuple *tuple) {
               return tuple.second;
           }]
          map:block]
         subscribeNext:^(id x) {
             [subscriber sendNext:x];
             [subscriber sendCompleted];
         }];
        
        // 5. Make the request
        [flickrRequest callAPIMethodWithGET:method
                                  arguments:args];
        
        // 6. When we are done, remove the reference to this request
        return [RACDisposable disposableWithBlock:^{
            [self.requests removeObject:flickrRequest];
        }];
    }];
}

- (RACSignal *)flickrSearchSignal:(NSString *)searchString {
    return [self signalFromAPIMethod:@"flickr.photos.search"
                           arguments:@{@"text": searchString,
                                       @"sort": @"interestingness-desc"}
                           transform:^id(NSDictionary *response) {
                               
                               RWTFlickrSearchResults *results = [RWTFlickrSearchResults new];
                               results.searchString = searchString;
                               results.totalResults = [[response valueForKeyPath:@"photos.total"] integerValue];
                               
                               NSArray *photos = [response valueForKeyPath:@"photos.photo"];
                               results.photos = [photos linq_select:^id(NSDictionary *jsonPhoto) {
                                   RWTFlickrPhoto *photo = [RWTFlickrPhoto new];
                                   photo.title = [jsonPhoto objectForKey:@"title"];
                                   photo.identifier = [jsonPhoto objectForKey:@"id"];
                                   photo.url = [self.flickrContext photoSourceURLFromDictionary:jsonPhoto
                                                                                           size:OFFlickrSmallSize];
                                   return photo;
                               }];
                               
                               return results;
                           }];
}
@end
