//
//  XHJDRefreshView.h
//  XHRefreshControlExample
//
//  Created by Jack_iMac on 15/4/22.
//  Copyright (c) 2015年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHJDRefreshView : UIView

@property (nonatomic, assign) CGFloat pullDownOffset;

- (void)willRefresh;

- (void)refreing;

- (void)endRefresing;

- (void)normal;

@end
