//
//  XHRefreshView.m
//  MessageDisplayExample
//
//  Created by 曾 宪华 on 14-6-6.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
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
