//
//  RWTAppDelegate.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 20/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTAppDelegate.h"
#import "RWTFlickrSearchViewController.h"
#import "RWTFlickrSearchViewModel.h"
#import "RWTViewModelServicesImpl.h"

@interface RWTAppDelegate ()

@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, strong) RWTFlickrSearchViewModel *viewModel;
@property (nonatomic, strong) RWTViewModelServicesImpl *viewModelServices;
@end

@implementation RWTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // create a navigation controller and perform some simple styling
  self.navigationController = [UINavigationController new];
  self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
  [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
  
  // create and navigate to a view controller
  UIViewController *viewController = [self createInitialViewController];
  [self.navigationController pushViewController:viewController animated:NO];

  // show the navigation controller
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = self.navigationController;
  [self.window makeKeyAndVisible];
  return YES;
}

/*
 初始化ViewController，因为初始化ViewController的时候需要初始化ViewController中的viewModel
 
 第二行初始化viewmodel的时候需要初始化viewModelServices
 viewModelServices是空的，所以此时的viewModel也是空的，不会执行网络请求
 
 这时候初始化完毕，进入ViewController
 
*/
- (UIViewController *)createInitialViewController {
    self.viewModelServices = [RWTViewModelServicesImpl new];
    self.viewModel = [[RWTFlickrSearchViewModel alloc] initWithServices:self.viewModelServices];
    return [[RWTFlickrSearchViewController alloc] initWithViewModel:self.viewModel];
}

@end
