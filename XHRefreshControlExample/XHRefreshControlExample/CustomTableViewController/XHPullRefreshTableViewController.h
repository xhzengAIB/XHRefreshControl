//
//  XHPullRefreshTableViewController.h
//  MessageDisplayExample
//
//  Created by 曾 宪华 on 14-6-6.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHBaseTableViewController.h"

#import "XHRefreshControl.h"

@interface XHPullRefreshTableViewController : XHBaseTableViewController <XHRefreshControlDelegate>

@property (nonatomic, assign) BOOL pullDownRefreshed;
@property (nonatomic, assign) BOOL loadMoreRefreshed;

@property (nonatomic, assign) XHPullDownRefreshViewType refreshViewType;

@property (nonatomic, assign) NSInteger requestCurrentPage;

// 以下所有方法都必须在tableView刷新完毕后才去调用，请自己去理解一下设计的原理哈！
- (void)startPullDownRefreshing;

- (void)endPullDownRefreshing;

- (void)endLoadMoreRefreshing;

- (void)endMoreOverWithMessage:(NSString *)message;

- (void)handleLoadMoreError;

@end
