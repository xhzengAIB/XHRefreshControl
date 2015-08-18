//
//  XHPullRefreshTableViewController.m
//  MessageDisplayExample
//
//  Created by 曾 宪华 on 14-6-6.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHPullRefreshTableViewController.h"

@interface XHPullRefreshTableViewController ()

@property (nonatomic, strong) XHRefreshControl *refreshControl;

@end

@implementation XHPullRefreshTableViewController

- (void)startPullDownRefreshing {
    [self.refreshControl startPullDownRefreshing];
}

- (void)endPullDownRefreshing {
    [self.refreshControl endPullDownRefreshing];
}

- (void)endLoadMoreRefreshing {
    [self.refreshControl endLoadMoreRefresing];
}

- (void)endMoreOverWithMessage:(NSString *)message {
    [self.refreshControl endMoreOverWithMessage:message];
}

- (void)endMoreOverWithMessageTipsView:(UIView *)messageTipsView {
    [self.refreshControl endMoreOverWithMessageTipsView:messageTipsView];
}

- (void)resetLoadMoreStatue:(BOOL)noMoreDataForLoaded {
    [self.refreshControl resetLoadMoreStatue:noMoreDataForLoaded];
}

- (void)handleLoadMoreError {
    [self.refreshControl handleLoadMoreError];
}

- (BOOL)isLoadingDataSource {
    return [self.refreshControl isLoading];
}

#pragma mark - Life Cycle

- (void)setupRefreshControl {
    if (!_refreshControl) {
        _refreshControl = [[XHRefreshControl alloc] initWithScrollView:self.tableView delegate:self];
        _refreshControl.hasStatusLabelShowed = self.hasStatusLabelShowed;
        _refreshControl.circleColor = self.circleColor;
        _refreshControl.circleLineWidth = self.circleLineWidth;
        _refreshControl.indicatorColor = self.indicatorColor;
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

#pragma mark - XHRefreshControl Delegate

- (void)beginPullDownRefreshing {
    self.requestCurrentPage = 0;
    [self loadDataSource];
}

- (void)beginLoadMoreRefreshing {
    self.requestCurrentPage ++;
    [self loadDataSource];
}

- (NSString *)lastUpdateTimeString {
    
    NSString *destDateString;
    destDateString = @"从未更新";
    
    return destDateString;
}

- (NSInteger)autoLoadMoreRefreshedCountConverManual {
    return 5;
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
    return self.refreshViewType;
}

- (NSString *)displayAutoLoadMoreRefreshedMessage {
    return @"点击显示下10条";
}

@end
