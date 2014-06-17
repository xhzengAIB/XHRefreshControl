//
//  XHSysatemRefreshTableViewController.h
//  XHRefreshControlExample
//
//  Created by dw_iOS on 14-6-17.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHSystemTableViewController.h"

#import "XHRefreshControl.h"

@interface XHSysatemRefreshTableViewController : XHSystemTableViewController <XHRefreshControlDelegate>

@property (nonatomic, assign) BOOL pullDownRefreshed;
@property (nonatomic, assign) BOOL loadMoreRefreshed;

@property (nonatomic, assign) NSInteger requestCurrentPage;

// 以下所有方法都必须在tableView刷新完毕后才去调用，请自己去理解一下设计的原理哈！
- (void)startPullDownRefreshing;

- (void)endPullDownRefreshing;

- (void)endLoadMoreRefreshing;

- (void)endMoreOverWithMessage:(NSString *)message;

@end
