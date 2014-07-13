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

/**
 *  是否支持下拉刷新
 */
@property (nonatomic, assign) BOOL pullDownRefreshed;

/**
 *  是否支持上拉刷新
 */
@property (nonatomic, assign) BOOL loadMoreRefreshed;

/**
 *  下拉刷新的样式
 */
@property (nonatomic, assign) XHPullDownRefreshViewType refreshViewType;

/**
 *  加载数据的页码
 */
@property (nonatomic, assign) NSInteger requestCurrentPage;

/**
 *  自动下拉刷新调用的方法，必须放在viewDidAppear方法内，别把这行代码放到别处，然后导致了错误，那就不好了嘛！
 */
- (void)startPullDownRefreshing;

/**
 *  当下拉加载数据完成后，你必须调用该方法哦！
 */
- (void)endPullDownRefreshing;

/**
 *  当上啦加载数据完成后，你也得调用该方法哦！然后你可能会问，那我要怎么判断是下拉还是上啦啊？requestCurrentPage看这个变量，会跟着变化哦！
 */
- (void)endLoadMoreRefreshing;

/**
 *  当上啦加载数据回调告诉我们，已经没有下一页了，那你可以调用该方法，告诉用户你已经没有数据了哦！
 *
 *  @param message 提示用户的信息
 */
- (void)endMoreOverWithMessage:(NSString *)message;

/**
 *  当网络加载失败的时候，你必须调用该方法，如果你不调用，我也帮不了你了
 */
- (void)handleLoadMoreError;

@end
