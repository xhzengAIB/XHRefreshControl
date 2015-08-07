//
//  HZActivityIndicator.m
//  HZActivityIndicator
//
//  Created by Hezi Cohen on 10/7/11.
//  Copyright (c) 2011 Hezi Cohen. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
// 
// Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
// 
// Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
// 
// Neither the name of the project's author nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
// TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
// LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "XHActivityIndicatorView.h"

@interface XHActivityIndicatorView () {
    NSTimer     *_timer;
    CGFloat     _anglePerStep;
    CGFloat     _currStep;
}

- (void)_repeatAnimation:(NSTimer*)timer;
- (UIColor*)_colorForStep:(NSUInteger)stepIndex;
- (void)_setPropertiesForStyle:(UIActivityIndicatorViewStyle)style;

@end

@implementation XHActivityIndicatorView
@synthesize steps = _steps;
@synthesize indicatorRadius = _indicatorRadius;
@synthesize finSize = _finSize;
@synthesize color = _color;
@synthesize stepDuration = _stepDuration;
@synthesize hidesWhenStopped = _hidesWhenStopped;
@synthesize roundedCoreners = _roundedCoreners;
@synthesize cornerRadii = _cornerRadii;
@synthesize direction = _direction;
@synthesize activityIndicatorViewStyle = _actualActivityIndicatorViewStyle;

- (void)awakeFromNib {
    [self _setPropertiesForStyle:UIActivityIndicatorViewStyleWhite];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self _setPropertiesForStyle:UIActivityIndicatorViewStyleWhite];
    }
    return self;
}

- (id)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style {
    self = [self initWithFrame:CGRectZero];
    if (self)
    {
        [self _setPropertiesForStyle:style];
    }
    return self;
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle {
    [self _setPropertiesForStyle:activityIndicatorViewStyle];
}

- (void)_setPropertiesForStyle:(UIActivityIndicatorViewStyle)style {
    self.backgroundColor = [UIColor clearColor];
    self.direction = HZActivityIndicatorDirectionClockwise;
    self.roundedCoreners = UIRectCornerAllCorners;
    self.cornerRadii = CGSizeMake(1, 1);
    self.stepDuration = 0.1;
    self.steps = 12;
    
    switch (style) {
        case UIActivityIndicatorViewStyleGray:
        {
            self.color = [UIColor darkGrayColor];
            self.finSize = CGSizeMake(2, 5);
            self.indicatorRadius = 5;

            break;
        }
        
        case UIActivityIndicatorViewStyleWhite:
        {
            self.color = [UIColor whiteColor];
            self.finSize = CGSizeMake(2, 5);
            self.indicatorRadius = 5;
            
            break;
        }
            
        case UIActivityIndicatorViewStyleWhiteLarge:
        {
            self.color = [UIColor whiteColor];
            self.cornerRadii = CGSizeMake(2, 2);
            self.finSize = CGSizeMake(3, 9);
            self.indicatorRadius = 8.5;
            
            break;
        }
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"style invalid"];
            break;
    }

    _isAnimating = NO;
    if (_hidesWhenStopped) 
        self.hidden = YES;
}

#pragma mark - UIActivityIndicator

- (void)startAnimating {
  if(self.isAnimating)
    return;
  
    // maa bugfix: this was 0 in the original code.  this means clockwise rotation starts more slowly than it should.
    _currStep = self.direction == HZActivityIndicatorDirectionClockwise ? self.steps - 1 : 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:_stepDuration target:self selector:@selector(_repeatAnimation:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    _isAnimating = YES;
    
    if (_hidesWhenStopped) 
        self.hidden = NO;
}

- (void)stopAnimating {
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
    _currStep = self.direction == HZActivityIndicatorDirectionClockwise ? self.steps - 1 : 0;
    [self setNeedsDisplay];
    
    _isAnimating = NO;
    if (_hidesWhenStopped) 
        self.hidden = YES;
}

- (BOOL)isAnimating {
    return _isAnimating;
}

#pragma mark - HZActivityIndicator Drawing.

- (void)setIndicatorRadius:(NSUInteger)indicatorRadius {
    _indicatorRadius = indicatorRadius;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                            _indicatorRadius*2 + _finSize.height*2,
                            _indicatorRadius*2 + _finSize.height*2);
    [self setNeedsDisplay];
}

- (void)setSteps:(NSUInteger)steps {
    _anglePerStep = (360.0 / (CGFloat)steps) * M_PI / 180.0;
    _steps = steps;
    [self setNeedsDisplay];
}

- (void)setFinSize:(CGSize)finSize {
    _finSize = finSize;
    [self setNeedsDisplay];
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

- (UIColor*)_colorForStep:(NSUInteger)stepIndex {
    CGFloat alpha = 1.0 - (stepIndex % _steps) * (1.0 / _steps);
    CGColorRef copiedColor = CGColorCreateCopyWithAlpha(_color.CGColor, alpha);
    UIColor *color = [UIColor colorWithCGColor:copiedColor];
    CGColorRelease(copiedColor);
    return color;
}

- (void)_repeatAnimation:(NSTimer*)timer {
    _currStep ++;
    [self setNeedsDisplay];
}

- (UIBezierPath *)finPathWithRect:(CGRect)rect {
  return [UIBezierPath bezierPathWithRoundedRect:rect
                               byRoundingCorners:_roundedCoreners
                                     cornerRadii:_cornerRadii];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGRect finRect = CGRectMake(self.bounds.size.width/2 - _finSize.width/2, 0,
                                _finSize.width, _finSize.height);
    UIBezierPath *bezierPath = [self finPathWithRect:finRect];

    CGPathRef bezierPathRef = CGPathCreateCopy([bezierPath CGPath]);    
  
    for (int i = 0; i < _steps; i++) 
    {
        if (!_isAnimating && _progress < ((CGFloat)(i + 1) / (CGFloat)(_steps))) break;
        [[self _colorForStep:_currStep+i*_direction] set];
                        
        CGContextBeginPath(context);
        CGContextAddPath(context, bezierPathRef);
        CGContextClosePath(context);
        CGContextFillPath(context);

        CGContextTranslateCTM(context, self.bounds.size.width / 2, self.bounds.size.height / 2);
        CGContextRotateCTM(context, _anglePerStep);
        CGContextTranslateCTM(context, -(self.bounds.size.width / 2), -(self.bounds.size.height / 2));
    }
  
    CGPathRelease(bezierPathRef);
}


@end
