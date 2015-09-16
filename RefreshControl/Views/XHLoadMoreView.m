//
//  XHLoadMoreView.m
//  MessageDisplayExample
//
//  Created by 曾 宪华 on 14-6-6.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHLoadMoreView.h"

#import "XHActivityIndicatorView.h"

@interface XHLoadMoreView ()

/**
 *  系统默认菊花控件
 */
@property (nonatomic, strong) XHActivityIndicatorView *activityIndicatorView;

/**
 *  外部定制的提示视图，只有在没有数据的情况下才会出现的
 */
@property (nonatomic, strong) UIView *messageView;

@end

@implementation XHLoadMoreView

- (void)setupNormalButton {
    self.loadMoreButton.userInteractionEnabled = NO;
    self.loadMoreButton.hidden = NO;
    [self hideMessageView];
}

- (void)setupNoneDataStauts {
    self.loadMoreButton.hidden = YES;
    [self.activityIndicatorView stopAnimating];
}

- (void)hideMessageView {
    if (_messageView) {
        _messageView.hidden = YES;
    }
}

- (void)startLoading {
    [self setupNormalButton];
    [self.loadMoreButton setTitle:@"正在载入" forState:UIControlStateNormal];
    [self.activityIndicatorView startAnimating];
}

- (void)endLoading {
    [self setupNormalButton];
    [self.loadMoreButton setTitle:@"加载更多" forState:UIControlStateNormal];
    [self.activityIndicatorView stopAnimating];
}

- (void)configuraManualStateWithMessage:(NSString *)message {
    self.loadMoreButton.userInteractionEnabled = YES;
    self.loadMoreButton.hidden = NO;
    [self hideMessageView];
    [self.loadMoreButton setTitle:message forState:UIControlStateNormal];
}

- (void)configuraNothingMoreWithMessage:(NSString *)message {
    [self setupNormalButton];
    [self.loadMoreButton setTitle:message forState:UIControlStateNormal];
}

- (void)configuraNothingMoreWithMessageView:(UIView *)messageView {
    if (_messageView == messageView) {
        _messageView.hidden = NO;
        return;
    }
    [self setupNoneDataStauts];
    messageView.backgroundColor = self.loadMoreButton.backgroundColor;
    self.messageView = messageView;
    [self addSubview:self.messageView];
}

- (void)setupCustomLoadMoreButton:(UIButton *)customLoadMoreButton {
    customLoadMoreButton.frame = self.loadMoreButton.frame;
    if (_loadMoreButton) {
        [_loadMoreButton removeFromSuperview];
        _loadMoreButton = nil;
    }
    _loadMoreButton = customLoadMoreButton;
    [self insertSubview:_loadMoreButton atIndex:0];
}

#pragma mark - Propertys

- (UIButton *)loadMoreButton {
    if (!_loadMoreButton) {
        _loadMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.bounds) - 20, CGRectGetHeight(self.bounds) - 10)];
        _loadMoreButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_loadMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loadMoreButton setBackgroundColor:[UIColor colorWithWhite:0.922 alpha:1.000]];
        _loadMoreButton.hidden = YES;
    }
    return _loadMoreButton;
}

- (void)setActivityIndicatorColor:(UIColor *)activityIndicatorColor {
    _activityIndicatorColor = activityIndicatorColor;
    self.activityIndicatorView.color = activityIndicatorColor;
}

- (XHActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[XHActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _activityIndicatorView.color = [UIColor colorWithRed:228/255.0 green:27 / 255.0 blue:70/255.0 alpha:1.000];
        _activityIndicatorView.indicatorRadius = 6;
        _activityIndicatorView.hidesWhenStopped = YES;
        _activityIndicatorView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.85, CGRectGetHeight(self.bounds) / 2.0);
    }
    return _activityIndicatorView;
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.loadMoreButton];
        [self addSubview:self.activityIndicatorView];
    }
    return self;
}

- (void)dealloc {
    _loadMoreButton = nil;
    _activityIndicatorView = nil;
}

@end
