//
//  XHLoadMoreView.m
//  MessageDisplayExample
//
//  Created by 曾 宪华 on 14-6-6.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHLoadMoreView.h"

@interface XHLoadMoreView ()

/**
 *  系统默认菊花控件
 */
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation XHLoadMoreView

- (void)startLoading {
    self.loadMoreButton.userInteractionEnabled = NO;
    [self.loadMoreButton setTitle:@"正在载入" forState:UIControlStateNormal];
    [self.activityIndicatorView startAnimating];
}

- (void)endLoading {
    self.loadMoreButton.userInteractionEnabled = NO;
    [self.loadMoreButton setTitle:@"加载更多" forState:UIControlStateNormal];
    [self.activityIndicatorView stopAnimating];
}

- (void)configuraManualStateWithMessage:(NSString *)message {
    self.loadMoreButton.userInteractionEnabled = YES;
    [self.loadMoreButton setTitle:message forState:UIControlStateNormal];
}

- (void)configuraNothingMoreWithMessage:(NSString *)message {
    self.loadMoreButton.userInteractionEnabled = NO;
    [self.loadMoreButton setTitle:message forState:UIControlStateNormal];
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
        [_loadMoreButton setTitle:@"加载更多" forState:UIControlStateNormal];
        _loadMoreButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_loadMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loadMoreButton setBackgroundColor:[UIColor colorWithWhite:0.922 alpha:1.000]];
    }
    return _loadMoreButton;
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.hidesWhenStopped = YES;
        _activityIndicatorView.center = CGPointMake(CGRectGetWidth(self.bounds) / 3, CGRectGetHeight(self.bounds) / 2.0);
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
