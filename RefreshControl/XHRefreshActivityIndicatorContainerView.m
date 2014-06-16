//
//  XHRefreshActivityIndicatorContainerView.m
//  XHRefreshControlExample
//
//  Created by 曾 宪华 on 14-6-16.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHRefreshActivityIndicatorContainerView.h"

@interface XHRefreshActivityIndicatorContainerView ()

@end

@implementation XHRefreshActivityIndicatorContainerView

#pragma mark - Propertys

- (void)setIsRefreshViewOnTableView:(BOOL)isRefreshViewOnTableView {
    _isRefreshViewOnTableView = isRefreshViewOnTableView;
    CGRect activityFrame = self.activityIndicatorView.frame;
    if (isRefreshViewOnTableView) {
        activityFrame.origin.y = CGRectGetHeight(self.bounds) * 0.6;
    } else {
        activityFrame.origin.y = CGRectGetHeight(self.bounds) * 0.4;
    }
    self.activityIndicatorView.frame = activityFrame;
}

- (XHActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[XHActivityIndicatorView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) / 2.0, CGRectGetHeight(self.bounds) * 0.4, 0, 0)];
    }
    return _activityIndicatorView;
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.activityIndicatorView];
    }
    return self;
}

@end
