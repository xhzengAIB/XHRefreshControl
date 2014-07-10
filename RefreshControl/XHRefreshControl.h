//
//  XHRefreshControl.h
//  MessageDisplayExample
//
//  Created by 曾 宪华 on 14-6-6.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XHRefreshControlHeader.h"

@protocol XHRefreshControlDelegate <NSObject>

@required
/**
 *  1、将要开始下拉刷新的方法
 */
- (void)beginPullDownRefreshing;

/**
 *  2、将要开始上提加载更多的方法
 */
- (void)beginLoadMoreRefreshing;

@optional
/**
 *  1、是否支持下拉刷新
 *
 *  @return 如果没有实现该delegate方法，默认是支持下拉的，为YES
 */
- (BOOL)isPullDownRefreshed;

/**
 *  2、是否支持上提加载更多
 *
 *  @return 如果没有实现该delegate方法，默认是支持上提加载更多的，为YES
 */
- (BOOL)isLoadMoreRefreshed;

/**
 *  3、标识下拉刷新是UIScrollView的子view，还是UIScrollView父view的子view
 *
 *  @return 如果没有实现该delegate方法，默认是scrollView的子View，为XHRefreshViewLayerTypeOnScrollViews
 */
- (XHRefreshViewLayerType)refreshViewLayerType;

/**
 *  4、下拉刷新使用哪种样式
 *
 *  @return 如果没有实现该delegate方法，默认是网易新闻App的样式
 */
- (XHPullDownRefreshViewType)pullDownRefreshViewType;

/**
 *  5、将自动加载更多的状态转换为手动加载需要的条件，现在是加载更多多少次后，开始转换
 *
 *  @return 如果不实现该delegate方法，默认是5次
 */
- (NSInteger)autoLoadMoreRefreshedCountConverManual;

/**
 *  6、获取用户定义下拉的View
 *
 *  @return 返回用户定义的View
 */
- (UIView *)customPullDownRefreshView;

/**
 *  7、通知外部，下拉的距离，用于定制某个时机的状态
 *
 *  @param refreshView    需要改变状态的View
 *  @param pullDownOffset 下拉的距离
 */
- (void)customPullDownRefreshView:(UIView *)customPullDownRefreshView withPullDownOffset:(CGFloat)pullDownOffset;

/**
 *  8、将要下拉的时候，被调用
 *
 *  @param customPullDownRefreshView 目标下拉的View
 */
- (void)customPullDownRefreshViewWillStartRefresh:(UIView *)customPullDownRefreshView;

/**
 *  9、将要停止下啦的时候，被调用
 *
 *  @param customPullDownRefreshView 目标下啦的View
 */
- (void)customPullDownRefreshViewWillEndRefresh:(UIView *)customPullDownRefreshView;

/**
 *  10、加载更多的按钮，默认是网易新闻App的样式，如果你需要自己定制的话，可以，那你实现该Delegate方法
 */
- (UIButton *)customLoadMoreButton;

/**
 *  11、最后更新数据的时间
 *
 *  @return 返回缓存最后更新某个页面的时间
 */
- (NSString *)lastUpdateTimeString;

/**
 *  12、用于显示手动上提加载更多的提示字眼
 *
 *  @return 如果没有实现该Delegate，默认显示为显示下20条的字眼
 */
- (NSString *)displayAutoLoadMoreRefreshedMessage;


@end

@interface XHRefreshControl : NSObject

- (id)initWithScrollView:(UIScrollView *)scrollView delegate:(id <XHRefreshControlDelegate>)delegate;

/**
 *  外部手动启动下拉加载的方法，这个方法不需要手动去拖动UIScrollView
 */
- (void)startPullDownRefreshing;

/**
 *  停止下拉刷新的方法
 */
- (void)endPullDownRefreshing;

/**
 *  停止上提加载更多的方法
 */
- (void)endLoadMoreRefresing;

/**
 *  没有更多的数据加载
 */
- (void)endMoreOverWithMessage:(NSString *)message;

/**
 *  当加载更多出现网络错误的时候
 */
- (void)handleLoadMoreError;

@end
