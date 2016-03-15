//
//  XHCircleView.h
//  MessageDisplayExample
//
//  Created by 曾 宪华 on 14-6-6.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XHRefreshControlHeader.h"

// 开始画圆圈时的offset
#define kXHRefreshCircleViewHeight 20

@interface XHCircleView : UIView

/**
 *  圆圈开始旋转时的offset （即开始刷新数据时）
 */
@property (nonatomic, assign) CGFloat heightBeginToRefresh;

/**
 *  offset的Y值
 */
@property (nonatomic, assign) CGFloat offsetY;

/**
 *  标识下拉刷新是UIScrollView的子view，还是UIScrollView父view的子view， 默认是scrollView的子View，为XHRefreshViewLayerTypeOnScrollViews
 */
@property (nonatomic, assign) XHRefreshViewLayerType refreshViewLayerType;

/**
 *  圆圈的颜色，默认是[UIColor colorWithRed:173 / 255.0 green:53 / 255.0 blue:60 / 255.0 alpha:1]
 */
@property (nonatomic, strong) UIColor *circleColor;

/**
 *  圆圈的线条粗细
 */
@property (nonatomic, assign) CGFloat circleLineWidth;

/**
 *  旋转的animation
 *
 *  @return animation
 */
+ (CABasicAnimation*)repeatRotateAnimation;

@end
