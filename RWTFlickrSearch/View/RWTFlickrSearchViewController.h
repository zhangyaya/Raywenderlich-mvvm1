//
//  Created by Colin Eberhardt on 13/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTFlickrSearchViewModel.h"
@import UIKit;

//初始化的时候调用初始化方法
@interface RWTFlickrSearchViewController : UIViewController
-(instancetype)initWithViewModel:(RWTFlickrSearchViewModel *)viewModel;
@end
