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
    [self.activityIndicatorView startAnimating];
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.circularProgressView.alpha = 0.0;
    } completion:^(BOOL finished) {
    }];
}
- (void)didStartRefreshing {
}

- (void)normal {
}
- (void)refreing {
}

- (void)willEndRefreshing {
    [self.activityIndicatorView stopAnimating];
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.circularProgressView.alpha = 1.0;
        
    } completion:^(BOOL finished) {
    }];
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
        _activityIndicatorView.hidesWhenStopped = YES;
        _activityIndicatorView.color = [UIColor redColor];
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
