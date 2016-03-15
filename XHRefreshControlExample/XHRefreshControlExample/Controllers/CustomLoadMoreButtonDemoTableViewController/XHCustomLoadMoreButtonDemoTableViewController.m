//
//  XHCustomLoadMoreButtonDemoTableViewController.m
//  XHRefreshControlExample
//
//  Created by dw_iOS on 14-6-25.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHCustomLoadMoreButtonDemoTableViewController.h"

@implementation XHCustomLoadMoreButtonDemoTableViewController

#pragma mark - XHRefreshControl Delegate

- (UIButton *)customLoadMoreButton {
    UIButton *_loadMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.view.bounds) - 20, CGRectGetHeight(self.view.bounds) - 10)];
    [_loadMoreButton setTitle:@"加载更多" forState:UIControlStateNormal];
    _loadMoreButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_loadMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_loadMoreButton setBackgroundColor:[UIColor colorWithWhite:0.922 alpha:1.000]];
    [_loadMoreButton.layer setMasksToBounds:YES];
    [_loadMoreButton.layer setCornerRadius:8.0]; //设置矩形四个圆角半径
    return _loadMoreButton;
}

@end
