//
//  HZActivityIndicator.h
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

#import <UIKit/UIKit.h>

// this code form https://github.com/hezi/HZActivityIndicatorView

typedef enum HZActivityIndicatorDirection {
    HZActivityIndicatorDirectionClockwise = -1,
    HZActivityIndicatorDirectionCounterClockwise = 1
} HZActivityIndicatorDirection;

@interface XHActivityIndicatorView : UIView {
    NSUInteger      _steps;
    CGFloat         _stepDuration;
    BOOL            _isAnimating;
    
    UIColor                         *_color;
    BOOL                            _hidesWhenStopped;
    UIRectCorner                    _roundedCoreners;
    CGSize                          _cornerRadii;
    CGSize                          _finSize;
    HZActivityIndicatorDirection    _direction;
    UIActivityIndicatorViewStyle    _actualActivityIndicatorViewStyle;
}

@property (nonatomic) NSUInteger                    steps;
@property (nonatomic) NSUInteger                    indicatorRadius;
@property (nonatomic) CGFloat                       stepDuration;
@property (nonatomic) CGSize                        finSize;
@property (nonatomic, strong) UIColor               *color;
@property (nonatomic) UIRectCorner                  roundedCoreners;
@property (nonatomic) CGSize                        cornerRadii;
@property (nonatomic) HZActivityIndicatorDirection  direction;
@property (nonatomic) UIActivityIndicatorViewStyle  activityIndicatorViewStyle;
@property (nonatomic) CGFloat                       progress;

@property(nonatomic) BOOL                           hidesWhenStopped;

- (id)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

- (UIBezierPath *)finPathWithRect:(CGRect)rect;

@end
