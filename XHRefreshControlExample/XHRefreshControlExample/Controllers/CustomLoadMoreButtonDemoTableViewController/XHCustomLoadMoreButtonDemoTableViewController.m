//
//  XHCustomLoadMoreButtonDemoTableViewController.m
//  XHRefreshControlExample
//
//  Created by dw_iOS on 14-6-25.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHCustomLoadMoreButtonDemoTableViewController.h"

@implementation XHCustomLoadMoreButtonDemoTableViewController

#pragma mark - XHRefreshControl Delegate

- (UIButton *)customLoadMoreButton {
    UIButton *_loadMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.view.bounds) - 20, CGRectGetHeight(self.view.bounds) - 10)];
    _loadMoreButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_loadMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_loadMoreButton setBackgroundColor:[UIColor colorWithWhite:0.922 alpha:1.000]];
    [_loadMoreButton.layer setMasksToBounds:YES];
    [_loadMoreButton.layer setCornerRadius:8.0]; //设置矩形四个圆角半径
    return _loadMoreButton;
}

@end
