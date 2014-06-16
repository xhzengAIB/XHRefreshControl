//
//  XHRefreshActivityIndicatorContainerView.h
//  XHRefreshControlExample
//
//  Created by 曾 宪华 on 14-6-16.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XHActivityIndicatorView.h"

@interface XHRefreshActivityIndicatorContainerView : UIView

@property (nonatomic, strong) XHActivityIndicatorView *activityIndicatorView;

/**
 *  isRefreshViewOnTableView
 *  YES:refreshView是tableView的子view
 *  NO:refreshView是tableView.superView的子view
 */
@property (nonatomic, assign) BOOL isRefreshViewOnTableView;

@end
