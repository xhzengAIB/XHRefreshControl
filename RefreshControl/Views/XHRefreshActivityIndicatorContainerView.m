//
//  XHRefreshActivityIndicatorContainerView.m
//  XHRefreshControlExample
//
//  Created by 曾 宪华 on 14-6-16.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
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
