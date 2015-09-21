//
//  Created by Colin Eberhardt on 13/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewController.h"

@interface RWTFlickrSearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *searchHistoryTable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@property (weak, nonatomic) RWTFlickrSearchViewModel *viewModel;

@end

@implementation RWTFlickrSearchViewController

-(instancetype)initWithViewModel:(RWTFlickrSearchViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.edgesForExtendedLayout = UIRectEdgeNone;
  
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
  
    //绑定viewModel
    [self bindViewModel];
    
}

- (void)bindViewModel
{
    //标题是等于viewModel中的title
    self.title = self.viewModel.title;
    
    //button的点击方法，不写在viewcontroller界面，而是直接执行viewModel中的方法。这一步，将button的动作写在了viewModel中
    self.searchButton.rac_command = self.viewModel.executeSearch;
    
    //viewModel中搜索的文字，根据searchTextField的变化而变化
    RAC(self.viewModel, searchText) = self.searchTextField.rac_textSignal;

    //以下方法类似，如果绑定的button动作执行，则传回一个yes，取反之后将loadingIndicator将不再隐藏
    RAC([UIApplication sharedApplication], networkActivityIndicatorVisible) = self.viewModel.executeSearch.executing;
    RAC(self.loadingIndicator, hidden) = [self.viewModel.executeSearch.executing not];
    
    //成功执行后，返回一个signal，然后执行resign的方法
    [self.viewModel.executeSearch.executionSignals subscribeNext:^(id x) {
        [self.searchTextField resignFirstResponder];
    }];
}
@end
