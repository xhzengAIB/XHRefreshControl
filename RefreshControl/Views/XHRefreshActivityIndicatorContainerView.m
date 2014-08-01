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

- (void)setRefreshViewLayerType:(XHRefreshViewLayerType)refreshViewLayerType {
    _refreshViewLayerType = refreshViewLayerType;
    
    CGRect activityIndicatorViewFrame;
    switch (refreshViewLayerType) {
        case XHRefreshViewLayerTypeOnSuperView:
            activityIndicatorViewFrame = CGRectMake(CGRectGetWidth(self.bounds) / 2.0, CGRectGetHeight(self.bounds) * 0.4, 0, 0);
            break;
        case XHRefreshViewLayerTypeOnScrollViews:
            activityIndicatorViewFrame = CGRectMake(CGRectGetWidth(self.bounds) / 2.0, CGRectGetHeight(self.bounds) * 0.6, 0, 0);
            break;
        default:
            break;
    }
    self.activityIndicatorView.frame = activityIndicatorViewFrame;
}

- (XHActivityCircleIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[XHActivityCircleIndicatorView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) / 2.0, CGRectGetHeight(self.bounds) * 0.6, 0, 0)];
        _activityIndicatorView.refreshViewLayerType = self.refreshViewLayerType;
        
    }
    return _activityIndicatorView;
}

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [self addSubview:self.activityIndicatorView];
    }
}

- (void)dealloc {
    _activityIndicatorView = nil;
}

@end
