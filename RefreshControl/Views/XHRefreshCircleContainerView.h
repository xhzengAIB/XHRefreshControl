//
//  XHRefreshView.h
//  MessageDisplayExample
//
//  Created by 曾 宪华 on 14-6-6.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XHCircleView.h"

@interface XHRefreshCircleContainerView : UIView

/**
 *  线条圆形的控件
 */
@property (nonatomic, strong) XHCircleView *circleView;

/**
 *  提示下拉刷新状态的标签
 */
@property (nonatomic, strong) UILabel *stateLabel;

/**
 *  提示最后更新时间的标签
 */
@property (nonatomic, strong) UILabel *timeLabel;

/**
 *  是否显示下拉刷新的标签文本,如果返回YES，按照正常排版,如果返回NO,那转圈居中
 */
@property (nonatomic, assign) BOOL hasStatusLabelShowed;

@end
