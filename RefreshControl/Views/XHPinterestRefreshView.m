//
//  XHPinterestRefreshView.m
//  XHRefreshControlExample
//
//  Created by Jack_iMac on 15/8/7.
//  Copyright (c) 2015年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHPinterestRefreshView.h"

#import "XHActivityIndicatorView.h"
#import "XHCircularProgressView.h"

@interface XHPinterestRefreshView ()

@property (nonatomic, strong) XHActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) XHCircularProgressView *circularProgressView;

@end

@implementation XHPinterestRefreshView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.activityIndicatorView];
        [self addSubview:self.circularProgressView];
    }
    return self;
}

- (void)willStartRefreshing {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.circularProgressView.alpha = 0.0;
        self.activityIndicatorView.alpha = 1.0;
    } completion:^(BOOL finished) {
    }];
    [self.activityIndicatorView startAnimating];
}
- (void)didStartRefreshing {
}

- (void)normal {
}
- (void)refreing {
}

- (void)willEndRefreshing {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.circularProgressView.alpha = 1.0;
        self.activityIndicatorView.alpha = 0.0;
    } completion:^(BOOL finished) {
    }];
    [self.activityIndicatorView stopAnimating];
}
- (void)didEndRefresing {
}

#pragma mark - Propertys

- (void)setPullDownOffset:(CGFloat)pullDownOffset {
    if (_pullDownOffset == pullDownOffset) {
        return ;
    }
    _pullDownOffset = pullDownOffset;
    
    CGFloat progress = pullDownOffset / 40.0;
    self.circularProgressView.progress = progress;
}

- (XHActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[XHActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _activityIndicatorView.color = [UIColor colorWithRed:228/255.0 green:27 / 255.0 blue:70/255.0 alpha:1.000];
        _activityIndicatorView.indicatorRadius = 6;
        _activityIndicatorView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    }
    return _activityIndicatorView;
}

- (XHCircularProgressView *)circularProgressView {
    if (!_circularProgressView) {
        UIImage *logoImage = [UIImage imageNamed:@"bicon.png"];
        UIImage *backCircleImage = [UIImage imageNamed:@"light_circle.png"];
        UIImage *frontCircleImage = [UIImage imageNamed:@"dark_circle.png"];
        
        _circularProgressView = [[XHCircularProgressView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)
                                                                         logo:logoImage
                                                              backCircleImage:backCircleImage
                                                             frontCircleImage:frontCircleImage];
        
        _circularProgressView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    }
    return _circularProgressView;
}

@end
