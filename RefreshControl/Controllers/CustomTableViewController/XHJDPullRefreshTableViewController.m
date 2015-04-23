//
//  XHJDPullRefreshTableViewController.m
//  XHRefreshControlExample
//
//  Created by Jack_iMac on 15/4/22.
//  Copyright (c) 2015年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHJDPullRefreshTableViewController.h"
#import "XHJDRefreshView.h"

@interface XHJDPullRefreshTableViewController ()

@property (nonatomic, strong) XHJDRefreshView *refreshView;

@end

@implementation XHJDPullRefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Propertys

- (XHJDRefreshView *)refreshView {
    if (!_refreshView) {
        _refreshView = [[XHJDRefreshView alloc] initWithFrame:CGRectMake(0, -60, 320, 60)];
    }
    return _refreshView;
}

#pragma mark - XHRefreshControl Delegate

- (UIView *)customPullDownRefreshView {
    return self.refreshView;
}

- (void)customPullDownRefreshViewRefreshState:(XHRefreshState)refreshState {
    switch (refreshState) {
        case XHRefreshStateNormal:
        case XHRefreshStateStopped:
            [self.refreshView normal];
            break;
        case XHRefreshStateLoading:
            [self.refreshView refreing];
            break;
        case XHRefreshStatePulling:
            [self.refreshView willRefresh];
            break;
        default:
            break;
    }
}

- (void)customPullDownRefreshView:(UIView *)customPullDownRefreshView withPullDownOffset:(CGFloat)pullDownOffset {
    self.refreshView.pullDownOffset = pullDownOffset;
}

- (void)customPullDownRefreshViewWillStartRefresh:(UIView *)customPullDownRefreshView {
    
}
- (void)customPullDownRefreshViewDidStartRefresh:(UIView *)customPullDownRefreshView {
    
}

- (void)customPullDownRefreshViewWillEndRefresh:(UIView *)customPullDownRefreshView {
    [self.refreshView endRefresing];
}
- (void)customPullDownRefreshViewDidEndRefresh:(UIView *)customPullDownRefreshView {
    
}

- (XHPullDownRefreshViewType)pullDownRefreshViewType {
    return XHPullDownRefreshViewTypeCustom;
}

@end
