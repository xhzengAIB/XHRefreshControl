//
//  BMYCircularProgressView.m
//  BMYPullToRefreshDemo
//
//  Created by Alberto De Bortoli on 15/05/2014.
//  Copyright (c) 2014 Beamly. All rights reserved.
//

#import "XHCircularProgressView.h"

#import <QuartzCore/QuartzCore.h>

#define degToRad(angle) (angle) * (M_PI / 180.0)

@interface XHCircularProgressView ()

@property (nonatomic, strong) CAShapeLayer *logoLayer;
@property (nonatomic, strong) CAShapeLayer *backCircleLayer;
@property (nonatomic, strong) CAShapeLayer *frontCircleLayer;
@property (nonatomic, strong) CAShapeLayer *pieLayer;

@end

@implementation XHCircularProgressView

- (id)initWithFrame:(CGRect)frame
               logo:(UIImage *)logoImage
    backCircleImage:(UIImage *)backCircleImage
   frontCircleImage:(UIImage *)frontCircleImage {
    self = [super initWithFrame:frame];
    if (self) {
        _logoLayer = [CAShapeLayer layer];
        _backCircleLayer = [CAShapeLayer layer];
        _frontCircleLayer = [CAShapeLayer layer];
        _pieLayer = [CAShapeLayer layer];
        
        [self.layer addSublayer:_logoLayer];
        [self.layer addSublayer:_backCircleLayer];
        [self.layer addSublayer:_frontCircleLayer];
        [self.layer addSublayer:_pieLayer];
        
        _logoLayer.contents = (__bridge id)[logoImage CGImage];
        _backCircleLayer.contents = (__bridge id)[backCircleImage CGImage];
        _frontCircleLayer.contents = (__bridge id)[frontCircleImage CGImage];
        _frontCircleLayer.mask = _pieLayer;
        _logoLayer.opacity = 0.0f;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _logoLayer.frame = self.bounds;
    _backCircleLayer.frame = self.bounds;
    _frontCircleLayer.frame = self.bounds;
    _pieLayer.frame = self.bounds;
}

#pragma mark - BMYProgressViewProtocol

- (void)setProgress:(CGFloat)progress {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    
    [self updatePie:_pieLayer forAngle:progress * 360.0f];
    _frontCircleLayer.mask = _pieLayer;
    _logoLayer.opacity = progress;
    
    [CATransaction commit];
}

#pragma mark - Private Methods

- (void)updatePie:(CAShapeLayer *)layer forAngle:(CGFloat)degrees {
    CGFloat angle = degToRad(-90);
    CGPoint center_ = CGPointMake(CGRectGetWidth(layer.frame)/2.0, CGRectGetWidth(layer.frame)/2.0);
    CGFloat radius = CGRectGetWidth(layer.frame)/2.0;
    
    UIBezierPath *piePath = [UIBezierPath bezierPath];
    [piePath moveToPoint:center_];
    [piePath addLineToPoint:CGPointMake(center_.x, center_.y - radius)];
    [piePath addArcWithCenter:center_ radius:radius startAngle:angle endAngle:degToRad(degrees - 90.0f) clockwise:YES];
    [piePath addLineToPoint:center_];
    [piePath closePath];
    
    layer.path = piePath.CGPath;
}

@end
