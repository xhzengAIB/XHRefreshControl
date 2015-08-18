//
//  XHSysatemRefreshTableViewController.m
//  XHRefreshControlExample
//
//  Created by dw_iOS on 14-6-17.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHSysatemRefreshTableViewController.h"

@interface XHSysatemRefreshTableViewController ()

@property (nonatomic, strong) XHRefreshControl *customRefreshControl;

@end

@implementation XHSysatemRefreshTableViewController

- (void)startPullDownRefreshing {
    [self.customRefreshControl startPullDownRefreshing];
}

- (void)endPullDownRefreshing {
    [self.customRefreshControl endPullDownRefreshing];
}

- (void)endLoadMoreRefreshing {
    [self.customRefreshControl endLoadMoreRefresing];
}

- (void)endMoreOverWithMessage:(NSString *)message {
    [self.customRefreshControl endMoreOverWithMessage:message];
}

- (void)endMoreOverWithMessageTipsView:(UIView *)messageTipsView {
    [self.customRefreshControl endMoreOverWithMessageTipsView:messageTipsView];
}

/**
 *  重置是否有更多翻页数据要加载
 */
- (void)resetLoadMoreStatue:(BOOL)noMoreDataForLoaded {
    [self.customRefreshControl resetLoadMoreStatue:noMoreDataForLoaded];
}

- (void)handleLoadMoreError {
    [self.customRefreshControl handleLoadMoreError];
}

- (BOOL)isLoadingDataSource {
    return [self.customRefreshControl isLoading];
}

#pragma mark - Life Cycle

- (void)setupRefreshControl {
    if (!_customRefreshControl) {
        _customRefreshControl = [[XHRefreshControl alloc] initWithScrollView:self.tableView delegate:self];
        _customRefreshControl.hasStatusLabelShowed = self.hasStatusLabelShowed;
        _customRefreshControl.circleColor = self.circleColor;
        _customRefreshControl.circleLineWidth = self.circleLineWidth;
        _customRefreshControl.indicatorColor = self.indicatorColor;
    }
}

- (id)init {
    self = [super init];
    if (self) {
        self.pullDownRefreshed = YES;
        self.loadMoreRefreshed = YES;
        self.circleColor = [UIColor colorWithRed:173 / 255.0 green:53 / 255.0 blue:60 / 255.0 alpha:1];
        self.circleLineWidth = 1.0;
        self.indicatorColor = [UIColor colorWithRed:0.000 green:0.690 blue:0.209 alpha:1.000];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setupRefreshControl];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
}

#pragma mark - XHRefreshControl Delegate

- (void)beginPullDownRefreshing {
    self.requestCurrentPage = 0;
    [self loadDataSource];
}

- (void)beginLoadMoreRefreshing {
    self.requestCurrentPage ++;
    [self loadDataSource];
}

- (NSDate *)lastUpdateTime {
    return [NSDate date];
}

- (NSInteger)autoLoadMoreRefreshedCountConverManual {
    return 2;
}

- (BOOL)isPullDownRefreshed {
    return self.pullDownRefreshed;
}

- (BOOL)isLoadMoreRefreshed {
    return self.loadMoreRefreshed;
}

- (XHRefreshViewLayerType)refreshViewLayerType {
    return XHRefreshViewLayerTypeOnScrollViews;
}

- (XHPullDownRefreshViewType)pullDownRefreshViewType {
    return XHPullDownRefreshViewTypeActivityIndicator;
}

- (NSString *)displayAutoLoadMoreRefreshedMessage {
    return @"点击显示下10条";
}

@end
