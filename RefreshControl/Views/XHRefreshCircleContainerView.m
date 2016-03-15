//
//  XHRefreshView.m
//  MessageDisplayExample
//
//  Created by 曾 宪华 on 14-6-6.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHRefreshCircleContainerView.h"

@interface XHRefreshCircleContainerView ()

@end

@implementation XHRefreshCircleContainerView

#pragma mark - Propertys

- (void)setHasStatusLabelShowed:(BOOL)hasStatusLabelShowed {
    _hasStatusLabelShowed = hasStatusLabelShowed;
    
    if (hasStatusLabelShowed) {
        self.circleView.frame = CGRectMake((CGRectGetWidth(self.bounds) - kXHRefreshCircleViewHeight) / 2 - 40, (CGRectGetHeight(self.bounds) - kXHRefreshCircleViewHeight) / 2 - 5, kXHRefreshCircleViewHeight, kXHRefreshCircleViewHeight);
    } else {
        self.circleView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    }
    self.stateLabel.hidden = !hasStatusLabelShowed;
    self.timeLabel.hidden = !hasStatusLabelShowed;
}

- (XHCircleView *)circleView {
    if (!_circleView) {
        _circleView = [[XHCircleView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.bounds) - kXHRefreshCircleViewHeight) / 2 - 40, (CGRectGetHeight(self.bounds) - kXHRefreshCircleViewHeight) / 2 - 5, kXHRefreshCircleViewHeight, kXHRefreshCircleViewHeight)];
    }
    return _circleView;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.circleView.frame) + 5, CGRectGetMinY(self.circleView.frame), 160, 14)];
        _stateLabel.backgroundColor = [UIColor clearColor];
        _stateLabel.font = [UIFont systemFontOfSize:14.f];
        _stateLabel.textColor = [UIColor blackColor];
    }
    return _stateLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        CGRect timeLabelFrame = self.stateLabel.frame;
        timeLabelFrame.origin.y += CGRectGetHeight(timeLabelFrame) + 6;
        _timeLabel = [[UILabel alloc] initWithFrame:timeLabelFrame];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont systemFontOfSize:11.f];
        _timeLabel.textColor = [UIColor colorWithWhite:0.659 alpha:1.000];
    }
    return _timeLabel;
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.circleView];
        [self addSubview:self.stateLabel];
        [self addSubview:self.timeLabel];
    }
    return self;
}

- (void)dealloc {
    _circleView = nil;
    _stateLabel = nil;
    _timeLabel = nil;
}

@end
