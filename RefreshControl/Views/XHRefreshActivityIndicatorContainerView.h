//
//  XHRefreshActivityIndicatorContainerView.h
//  XHRefreshControlExample
//
//  Created by 曾 宪华 on 14-6-16.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XHActivityCircleIndicatorView.h"

#import "XHRefreshControlHeader.h"

@interface XHRefreshActivityIndicatorContainerView : UIView

/**
 *  iOS7自定义菊花转圈控件
 */
@property (nonatomic, strong) XHActivityCircleIndicatorView *activityIndicatorView;

/**
 *  标识下拉刷新是UIScrollView的子view，还是UIScrollView父view的子view， 默认是scrollView的子View，为XHRefreshViewLayerTypeOnScrollViews
 */
@property (nonatomic, assign) XHRefreshViewLayerType refreshViewLayerType;

@end
