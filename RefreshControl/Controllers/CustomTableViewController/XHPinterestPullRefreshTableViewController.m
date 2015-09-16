//
//  XHPinterestPullRefreshTableViewController.m
//  XHRefreshControlExample
//
//  Created by Jack_iMac on 15/8/7.
//  Copyright (c) 2015年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHPinterestPullRefreshTableViewController.h"

#import "XHPinterestRefreshView.h"

@interface XHPinterestPullRefreshTableViewController ()

@property (nonatomic, strong) XHPinterestRefreshView *refreshView;

@end

@implementation XHPinterestPullRefreshTableViewController

#pragma mark - Propertys

- (XHPinterestRefreshView *)refreshView {
    if (!_refreshView) {
        _refreshView = [[XHPinterestRefreshView alloc] initWithFrame:CGRectMake(0, -50, CGRectGetWidth(self.view.bounds), 50)];
        _refreshView.activityIndicatorColor = self.indicatorColor;
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
            break;
        default:
            break;
    }
}

- (void)customPullDownRefreshView:(UIView *)customPullDownRefreshView withPullDownOffset:(CGFloat)pullDownOffset {
    self.refreshView.pullDownOffset = pullDownOffset;
}

- (void)customPullDownRefreshViewWillStartRefresh:(UIView *)customPullDownRefreshView {
    [self.refreshView willStartRefreshing];
}
- (void)customPullDownRefreshViewDidStartRefresh:(UIView *)customPullDownRefreshView {
    [self.refreshView didStartRefreshing];
}

- (void)customPullDownRefreshViewWillEndRefresh:(UIView *)customPullDownRefreshView {
    [self.refreshView willEndRefreshing];
}
- (void)customPullDownRefreshViewDidEndRefresh:(UIView *)customPullDownRefreshView {
    [self.refreshView didEndRefresing];
}

- (XHPullDownRefreshViewType)pullDownRefreshViewType {
    return XHPullDownRefreshViewTypeCustom;
}

@end
