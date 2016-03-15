//
//  XHRefreshView.h
//  MessageDisplayExample
//
//  Created by 曾 宪华 on 14-6-6.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
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
