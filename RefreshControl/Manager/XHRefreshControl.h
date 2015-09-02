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
 *  将要开始下拉刷新的方法
 */
- (void)beginPullDownRefreshing;

/**
 *  将要开始上提加载更多的方法
 */
- (void)beginLoadMoreRefreshing;

@optional
/**
 *  比如有一些页面不需要下拉刷新，仅仅需要一次自动上拉加载更多，然后其他情况就归为手动滑动到底部是上拉加载更多，这个方法就会被调用，前提是需要调用一下startLoadMoreRefreshing
 */
- (void)startLoadMoreForAutoTrigger;

/**
 *  是否支持下拉刷新
 *
 *  @return 如果没有实现该delegate方法，默认是支持下拉的，为YES
 */
- (BOOL)isPullDownRefreshed;

/**
 *  是否支持上提加载更多
 *
 *  @return 如果没有实现该delegate方法，默认是支持上提加载更多的，为YES
 */
- (BOOL)isLoadMoreRefreshed;

/**
 *  标识下拉刷新是UIScrollView的子view，还是UIScrollView父view的子view
 *
 *  @return 如果没有实现该delegate方法，默认是scrollView的子View，为XHRefreshViewLayerTypeOnScrollViews
 */
- (XHRefreshViewLayerType)refreshViewLayerType;

/**
 *  下拉刷新使用哪种样式
 *
 *  @return 如果没有实现该delegate方法，默认是网易新闻App的样式
 */
- (XHPullDownRefreshViewType)pullDownRefreshViewType;

/**
 *  将自动加载更多的状态转换为手动加载需要的条件，现在是加载更多多少次后，开始转换
 *
 *  @return 如果不实现该delegate方法，默认是5次
 */
- (NSInteger)autoLoadMoreRefreshedCountConverManual;

/**
 *  获取用户定义下拉的View
 *
 *  @return 返回用户定义的View
 */
- (UIView *)customPullDownRefreshView;

/**
 *  通知外部，下拉的距离，用于定制某个时机的状态
 *
 *  @param refreshView    需要改变状态的View
 *  @param pullDownOffset 下拉的距离
 */
- (void)customPullDownRefreshView:(UIView *)customPullDownRefreshView withPullDownOffset:(CGFloat)pullDownOffset;

/**
 *  通知外部，下拉的状态，用于定制某个时机的状态
 *
 *  @param refreshView    需要改变状态的View
 *  @param refreshState 下拉的状态
 */
- (void)customPullDownRefreshViewRefreshState:(XHRefreshState)refreshState;

/**
 *  将要下拉的时候，被调用
 *
 *  @param customPullDownRefreshView 目标下拉的View
 */
- (void)customPullDownRefreshViewWillStartRefresh:(UIView *)customPullDownRefreshView;

/**
 *  刚进入下拉的时候，被调用
 *
 *  @param customPullDownRefreshView 目标下拉的View
 */
- (void)customPullDownRefreshViewDidStartRefresh:(UIView *)customPullDownRefreshView;

/**
 *  将要停止下啦的时候，被调用
 *
 *  @param customPullDownRefreshView 目标下啦的View
 */
- (void)customPullDownRefreshViewWillEndRefresh:(UIView *)customPullDownRefreshView;

/**
 *  刚进入停止下啦的时候，被调用
 *
 *  @param customPullDownRefreshView 目标下啦的View
 */
- (void)customPullDownRefreshViewDidEndRefresh:(UIView *)customPullDownRefreshView;

/**
 *  加载更多的按钮，默认是网易新闻App的样式，如果你需要自己定制的话，可以，那你实现该Delegate方法
 */
- (UIButton *)customLoadMoreButton;

/**
 *  最后更新数据的时间
 *
 *  @return 返回缓存最后更新某个页面的时间
 */
- (NSString *)lastUpdateTimeString;

/**
 *  用于显示手动上提加载更多的提示字眼
 *
 *  @return 如果没有实现该Delegate，默认显示为显示下20条的字眼
 */
- (NSString *)displayAutoLoadMoreRefreshedMessage;

/**
 *  当scrollView滚动到距离底部有多少距离
 *
 *  @return 返回你预期想要的距离，默认是0，即是拖动scrollView到底部才开始加载
 */
- (CGFloat)preloadDistance;

@end

@interface XHRefreshControl : NSObject

/**
 *  是否显示下拉刷新的标签文本,如果返回YES，按照正常排版,如果返回NO,那转圈居中,默认是YES
 */
@property (nonatomic, assign) BOOL hasStatusLabelShowed;

/**
 *  圆圈的颜色，默认是[UIColor colorWithRed:173 / 255.0 green:53 / 255.0 blue:60 / 255.0 alpha:1]
 */
@property (nonatomic, strong) UIColor *circleColor;

/**
 *  圆圈的线条粗细,默认为1, 最大为2
 */
@property (nonatomic, assign) CGFloat circleLineWidth;

/**
 *  菊花的颜色
 */
@property (nonatomic, strong) UIColor *indicatorColor;

- (id)initWithScrollView:(UIScrollView *)scrollView delegate:(id <XHRefreshControlDelegate>)delegate;

/**
 *  外部手动启动下拉加载的方法，这个方法不需要手动去拖动UIScrollView
 */
- (void)startPullDownRefreshing;

- (void)startControlPixelPullDownRefreshing;

/**
 *  停止下拉刷新的方法
 */
- (void)endPullDownRefreshing;

/**
 *  外部手动启动上拉加载更多的方法，这个方法不需要手动去拖动UIScrollView
 */
- (void)startLoadMoreRefreshing;

/**
 *  停止上提加载更多的方法
 */
- (void)endLoadMoreRefresing;

/**
 *  没有更多的数据加载，展示一个提示语
 */
- (void)endMoreOverWithMessage:(NSString *)message;

/**
 *  没有更多的数据加载，展示一个提示视图
 */
- (void)endMoreOverWithMessageTipsView:(UIView *)messageTipsView;

/**
 *  重置是否有更多翻页数据要加载
 */
- (void)resetLoadMoreStatue:(BOOL)noMoreDataForLoaded;

/**
 *  当加载更多出现网络错误的时候
 */
- (void)handleLoadMoreError;

/**
 *  获取是否下啦刷新中
 *
 *  @return 返回预期结果
 */
- (BOOL)isLoading;


@end
