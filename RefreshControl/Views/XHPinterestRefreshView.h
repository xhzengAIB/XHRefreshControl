//
//  XHPinterestRefreshView.h
//  XHRefreshControlExample
//
//  Created by Jack_iMac on 15/8/7.
//  Copyright (c) 2015年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHPinterestRefreshView : UIView

@property (nonatomic, strong) UIColor *activityIndicatorColor;

@property (nonatomic, assign) CGFloat pullDownOffset;

- (instancetype)initWithFrame:(CGRect)frame
                logoImageName:(NSString *)logoImageName
          backCircleImageName:(NSString *)backCircleImageName
             frontCircleImage:(NSString *)frontCircleImage;

- (void)willStartRefreshing;
- (void)didStartRefreshing;

- (void)refreing;

- (void)willEndRefreshing;
- (void)didEndRefresing;

- (void)normal;

@end
