//
//  XHActivityCircleIndicatorView.h
//  XHRefreshControlExample
//
//  Created by 曾 宪华 on 14-6-16.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XHRefreshControlHeader.h"

@interface XHActivityCircleIndicatorView : UIView

/**
 *  菊花的颜色
 */
@property (nonatomic, copy) UIColor *tintColor;

/**
 *  外部设置滑动距离
 */
@property (nonatomic, assign) CGFloat timeOffset;  // 0.0 ~ 1.0

/**
 *  标识下拉刷新是UIScrollView的子view，还是UIScrollView父view的子view， 默认是scrollView的子View，为XHRefreshViewLayerTypeOnScrollViews
 */
@property (nonatomic, assign) XHRefreshViewLayerType refreshViewLayerType;

/**
 *  开始动画加载
 */
- (void)beginRefreshing;

/**
 *  结束动画加载
 */
- (void)endRefreshing;

@end
