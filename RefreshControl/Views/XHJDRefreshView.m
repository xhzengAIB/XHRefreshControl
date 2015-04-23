//
//  XHJDRefreshView.m
//  XHRefreshControlExample
//
//  Created by Jack_iMac on 15/4/22.
//  Copyright (c) 2015年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHJDRefreshView.h"

@interface XHJDRefreshView ()

@property (nonatomic, strong) UIImageView *peopleImageView;
@property (nonatomic, strong) UIImageView *animationImageView;
@property (nonatomic, strong) UIImageView *boxView;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UILabel *stateLabel;

@end

@implementation XHJDRefreshView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.peopleImageView];
        [self addSubview:self.animationImageView];
        [self addSubview:self.boxView];
        [self addSubview:self.tipsLabel];
        [self addSubview:self.stateLabel];
    }
    return self;
}

- (void)willRefresh {
    self.stateLabel.text = @"松手更新";
}

- (void)normal {
    self.stateLabel.text = @"下拉刷新";
}

- (void)endRefresing {
    self.animationImageView.hidden = YES;
    [self.animationImageView stopAnimating];
    
    self.peopleImageView.hidden = NO;
    self.boxView.hidden = NO;
    
    CGFloat thum = 0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.0, 0.0);
        CGAffineTransform transform = CGAffineTransformTranslate(scaleTransform, thum * 30, thum * -35);
        self.peopleImageView.transform = transform;
        self.boxView.transform = CGAffineTransformMakeTranslation(- thum * 52, -thum);
    } completion:^(BOOL finished) {

    }];
    
    
}

- (void)refreing {
    self.stateLabel.text = @"更新中...";
    self.peopleImageView.hidden = YES;
    self.boxView.hidden = YES;
    self.animationImageView.hidden = NO;
    [self.animationImageView startAnimating];
}

#pragma mark - Propertys

- (void)setPullDownOffset:(CGFloat)pullDownOffset {
    _pullDownOffset = pullDownOffset;
    CGFloat thum = pullDownOffset / 40.0;
    self.peopleImageView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(thum * 30, thum * -35), CGAffineTransformMakeScale(thum, thum));
    self.boxView.transform = CGAffineTransformMakeTranslation(- thum * 52, thum);
}

- (UIImageView *)peopleImageView {
    if (!_peopleImageView) {
        _peopleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"staticDeliveryStaff"]];
        CGRect peopleImageViewFrame = _peopleImageView.frame;
        peopleImageViewFrame.origin = CGPointMake(30, 15);
        _peopleImageView.frame = peopleImageViewFrame;
        _peopleImageView.transform = CGAffineTransformMakeScale(0.0, 0.0);
    }
    return _peopleImageView;
}

- (UIImageView *)animationImageView {
    if (!_animationImageView) {
        _animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(62, -14, 49, 74)];
        NSArray *images = @[[UIImage imageNamed:@"deliveryStaff0"],
                            [UIImage imageNamed:@"deliveryStaff1"],
                            [UIImage imageNamed:@"deliveryStaff2"],
                            [UIImage imageNamed:@"deliveryStaff3"]
                            ];
        _animationImageView.animationImages = images;
        _animationImageView.hidden = YES;
        _animationImageView.animationDuration = 0.3;
    }
    return _animationImageView;
}

- (UIImageView *)boxView {
    if (!_boxView) {
        _boxView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"box"]];
        CGRect boxViewFrame = _boxView.frame;
        boxViewFrame.origin = CGPointMake(150, 10);
        _boxView.frame = boxViewFrame;
    }
    return _boxView;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds) - 30, 15, 80, 20)];
        _tipsLabel.text = @"让购物更便捷";
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        _tipsLabel.font = [UIFont systemFontOfSize:14];
        _tipsLabel.textColor = [UIColor colorWithWhite:0.574 alpha:1.000];
    }
    return _tipsLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_tipsLabel.frame), CGRectGetMaxY(_tipsLabel.frame), 80, 14)];
        _stateLabel.textAlignment = NSTextAlignmentLeft;
        _stateLabel.font = [UIFont systemFontOfSize:12];
        _stateLabel.textColor = [UIColor colorWithWhite:0.714 alpha:1.000];
    }
    return _stateLabel;
}

@end
