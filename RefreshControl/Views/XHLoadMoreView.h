//
//  XHLoadMoreView.h
//  MessageDisplayExample
//
//  Created by 曾 宪华 on 14-6-6.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import <UIKit/UIKit.h>

#define kXHLoadMoreViewHeight 50

@interface XHLoadMoreView : UIView

/**
 *  加载更多的按钮
 */
@property (nonatomic, strong) UIButton *loadMoreButton;

@property (nonatomic, strong) UIColor *activityIndicatorColor;

/**
 *  当外部需要自定义加载更多的按钮时，需要通过该方法进行覆盖原本的按钮
 *
 *  @param customLoadMoreButton 目标自定义加载更多按钮
 */
- (void)setupCustomLoadMoreButton:(UIButton *)customLoadMoreButton;

/**
 *  开始加载
 */
- (void)startLoading;

/**
 *  结束加载
 */
- (void)endLoading;

/**
 *  设置手动加载更多的UI
 */
- (void)configuraManualStateWithMessage:(NSString *)message;

/**
 *  当外部加载更多数据的时候，发现没有数据了，可以进行设置一些提示字眼
 *
 *  @param message 被显示的目标文本
 */
- (void)configuraNothingMoreWithMessage:(NSString *)message;

/**
 *  当外部加载更多数据的时候，发现没有数据了，可以进行设置一些更有趣的视图
 *
 *  @param messageView 被显示的目标视图
 */
- (void)configuraNothingMoreWithMessageView:(UIView *)messageView;

@end
